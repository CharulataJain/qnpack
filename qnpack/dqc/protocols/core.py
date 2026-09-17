"""
protocols/core.py
-----------------
DQCProtocol — top-level LocalProtocol that orchestrates the full DQC simulation.

Instantiates and manages:
  - One ControllerProtocol (on the controller node)
  - N QPUProtocols (one per QPU node)
  - M BSMProtocols (one per BSM node)
"""

import logging

import netsquid as ns
from netsquid.protocols.nodeprotocols import LocalProtocol
from netsquid.protocols.protocol import Signals

from .controller import ControllerProtocol
from .qpu import QPUProtocol
from .bsm import BSMProtocol
from .switch import QuantumSwitchProtocol
from .fidelity import FidelityTracker
from .epr_factory import EPRFactoryProtocol

log = logging.getLogger(__name__)


class DQCProtocol(LocalProtocol):
    def __init__(self, cfg, network, controller_node, qpu_nodes,
                 qpu_info=None, bsm_info=None, bsm_nodes=None, run_idx=0,
                 frontend=None, q_switch=None, switch_node=None,
                 pre_labeled_commands=None, pre_process_maps=None):
        super().__init__(nodes=network.nodes)
        self.cfg = cfg
        self.run_idx = run_idx
        self.network = network
        self.controller_node = controller_node
        self.qpu_nodes = qpu_nodes
        self.qpu_info = qpu_info or {}
        self.bsm_info = bsm_info or {}
        self.bsm_nodes = bsm_nodes or []
        self.frontend = frontend
        self.q_switch = q_switch
        self.switch_node = switch_node
        self.pre_labeled_commands = pre_labeled_commands
        self.pre_process_maps = pre_process_maps
        self.controller_protocol = None
        self.qpu_protocols = []
        self.bsm_protocols = []
        self.global_entanglement_durations = {}
        self._add_subprotocols()

    def _add_subprotocols(self):
        controller_protocol = ControllerProtocol(
            self.cfg,
            node=self.controller_node,
            qpu_nodes=self.qpu_nodes,
            qpu_info=self.qpu_info,
            bsm_info=self.bsm_info,
            name="ControllerProtocol",
            run_idx=self.run_idx,
            frontend=self.frontend,
            pre_labeled_commands=self.pre_labeled_commands,
            pre_process_maps=self.pre_process_maps,
        )
        self.add_subprotocol(controller_protocol)

        # In switch mode, QuantumSwitchProtocol forwards qubits from the QPU
        # input ports to each BSM's left/right output ports using the
        # FullMeshOpticalSwitch routing table.
        if self.q_switch is not None and self.switch_node is not None:
            qpu_port_map = {
                label: f"qin_{label}" for label in self.qpu_info
            }
            # bsm_port_map maps bsm_label -> (left_node_port, right_node_port)
            bsm_port_map = {
                label: (f"qout_{label}_left", f"qout_{label}_right")
                for label in self.bsm_info
            }
            qs_proto = QuantumSwitchProtocol(
                node=self.switch_node,
                q_switch=self.q_switch,
                qpu_port_map=qpu_port_map,
                bsm_port_map=bsm_port_map,
                name="QuantumSwitchProtocol",
            )
            self.add_subprotocol(qs_proto)
            log.debug(
                f"Added QuantumSwitchProtocol on {self.switch_node.name} "
                f"(QPU ports: {list(qpu_port_map.values())}, "
                f"BSM ports: {list(bsm_port_map.values())})"
            )

        # Invert qpu_info (label -> {qpu_id, ...}) into qpu_id -> label.
        id_to_label = {info["qpu_id"]: label for label, info in self.qpu_info.items()}

        for i, qpu_node in enumerate(self.qpu_nodes, start=1):
            qpu_label = id_to_label.get(i)
            qpu_proto = QPUProtocol(
                self.cfg,
                node=qpu_node,
                qpu_id=i,
                qpu_label=qpu_label,
                q_switch=self.q_switch,
                bsm_info=self.bsm_info,
                name=f"QPUProtocol_{i}"
            )
            qpu_proto.global_entanglement_durations = self.global_entanglement_durations
            self.add_subprotocol(qpu_proto)

        sorted_bsm_info = sorted(self.bsm_info.values(), key=lambda x: x["bsm_id"])
        for i, bsm_node in enumerate(self.bsm_nodes, start=1):
            channel_length = 1
            if i - 1 < len(sorted_bsm_info):
                bsm_inf = sorted_bsm_info[i - 1]
                lengths = bsm_inf.get("channel_lengths", {})
                q_left = lengths.get("q_left", 1)
                q_right = lengths.get("q_right", 1)
                channel_length = max(q_left, q_right)
            bsm_proto = BSMProtocol(
                node=bsm_node,
                bsm_id=i,
                cfg=self.cfg,
                channel_length=channel_length,
                name=f"BSMProtocol_{i}"
            )
            self.add_subprotocol(bsm_proto)

        # ── EPR Factory setup ────────────────────────────────────────
        epr_factory_cfg = getattr(self.cfg, 'epr_factory', None)
        if epr_factory_cfg and getattr(epr_factory_cfg, 'enabled', False):
            self._setup_epr_factories(self.cfg, self.qpu_nodes)

        log.debug(
            f"DQC Protocol setup complete: 1 controller, "
            f"{len(self.qpu_nodes)} QPUs, {len(self.bsm_nodes)} BSMs"
            + (", 1 QuantumSwitchProtocol" if self.q_switch is not None else "")
        )

    def _setup_epr_factories(self, cfg, qpu_nodes):
        """Create EPRFactoryProtocol instances for each QPU node.

        Only *capacity* is decided here.  Which communication qubits hold
        the pooled pairs is chosen later by
        :meth:`ControllerProtocol._align_pools_with_circuit`, once the
        compiled circuit is known, so that pool storage can be placed clear
        of every position the circuit names.
        """
        epr_cfg = cfg.epr_factory
        pool_size = getattr(epr_cfg, 'pool_size_per_pair', 3)
        comm_reserved = getattr(epr_cfg, 'comm_qubits_reserved', 4)
        min_fidelity = getattr(epr_cfg, 'min_fidelity', 0.9)
        check_interval = getattr(epr_cfg, 'check_interval_ns', 1_000_000)
        # Pool-only execution: no on-demand fallback, block until refill
        # delivers (see QPUProtocol._await_pooled_pair).
        pool_only = bool(getattr(epr_cfg, 'pool_only', False))
        drain_timeout = float(getattr(epr_cfg, 'drain_timeout_ns', 5e6))


        T1 = float(cfg.memory.T1)
        T2 = float(cfg.memory.T2)
        fidelity_tracker = FidelityTracker(T1=T1, T2=T2, min_fidelity=min_fidelity)

        # Each QPU needs its peer QPUs and the BSM channel connecting them.
        for qpu_proto_name, qpu_proto in list(self.subprotocols.items()):
            if not isinstance(qpu_proto, QPUProtocol):
                continue

            qpu_id = qpu_proto.qpu_id
            bsm_info = qpu_proto.bsm_info

            if not bsm_info:
                continue

            # Build peer_configs from bsm_info
            peer_configs = {}
            for bsm_label, bsm_inf in bsm_info.items():
                # Only BSMs where this QPU is one of the two endpoints.
                left_label = bsm_inf.get('left_qpu')
                right_label = bsm_inf.get('right_qpu')

                if qpu_proto.qpu_label == left_label:
                    peer_label = right_label
                elif qpu_proto.qpu_label == right_label:
                    peer_label = left_label
                else:
                    # This QPU is not connected to this BSM — skip
                    continue

                # Find peer QPU ID from other QPU protocols
                peer_qpu_id = None
                for other_name, other_proto in self.subprotocols.items():
                    if isinstance(other_proto, QPUProtocol) and other_proto.qpu_label == peer_label:
                        peer_qpu_id = other_proto.qpu_id
                        break

                if peer_qpu_id is None:
                    continue

                # The controller assigns storage during alignment.
                peer_configs[peer_qpu_id] = {
                    'pool_size': pool_size,
                    'bsm_label': bsm_label,
                    'comm_positions': [],
                }

            if not peer_configs:
                continue

            # Create factory protocol
            factory = EPRFactoryProtocol(
                node=qpu_proto.node,
                qpu_protocol=qpu_proto,
                peer_configs=peer_configs,
                fidelity_tracker=fidelity_tracker,
                q_switch=qpu_proto.q_switch,
                bsm_info=bsm_info,
                check_interval_ns=check_interval,
            )

            # Wire factory to QPU protocol
            qpu_proto.epr_factory = factory
            qpu_proto.pool_only = pool_only
            qpu_proto.pool_drain_timeout_ns = drain_timeout

            # Add as sub-protocol
            factory_name = f"EPRFactory_QPU_{qpu_id}"
            self.add_subprotocol(factory, name=factory_name)

        # ── Hand the factory map to the controller ────────────────────────
        # It drives pre-fill: arming both endpoints' factory workers and
        # triggering the shared BSM on the factory classical plane.
        factory_by_qpu = {}
        for name, proto in self.subprotocols.items():
            if isinstance(proto, EPRFactoryProtocol):
                factory_by_qpu[proto.qpu_protocol.qpu_id] = proto

        # Scratch dict cross-checking that both QPUs of a pairing consumed
        # matching halves.  Simulation-side bookkeeping only.
        consumption_log = {}
        for factory in factory_by_qpu.values():
            factory.shared_consumption_log = consumption_log

        # Sibling QPU protocols, letting a QPU blocking on an empty pool see
        # whether its peer pins the slots it needs, which distinguishes a
        # recoverable wait from mutual deadlock
        # (see QPUProtocol._refill_can_progress).  Introspection only.
        qpu_protocols = {
            qpu_id: factory.qpu_protocol
            for qpu_id, factory in factory_by_qpu.items()
        }
        for factory in factory_by_qpu.values():
            factory.peer_qpu_protocols = qpu_protocols

        for name, proto in self.subprotocols.items():
            if isinstance(proto, ControllerProtocol):
                proto.epr_factory_enabled = True
                proto.epr_factories = list(factory_by_qpu.values())
                proto.factory_by_qpu = factory_by_qpu
                proto.factory_comm_budget = comm_reserved
                proto.pool_only = pool_only
                log.debug(
                    f"Controller wired to EPR factories on QPUs: "
                    f"{sorted(factory_by_qpu)}"
                )
                break

    def run(self):
        self.start_subprotocols()

        # Wait for controller to finish dispatching
        controller = self.subprotocols["ControllerProtocol"]
        yield self.await_signal(controller, Signals.SUCCESS)

        log.debug("[DQCProtocol] Controller finished. Waiting for QPUs to complete.")

        # A circuit need not use every QPU in the topology.  Idle QPUs block
        # on ctrl_port forever and never emit SUCCESS, which stalls teardown
        # (and with the EPR factory's maintenance timer re-arming, sim_run()
        # never returns).  Take the active set from the pre-labeled payload
        # if injected, else the controller's parsed map, and stop the rest.
        if self.pre_labeled_commands is not None:
            active_qpu_ids = set(self.pre_labeled_commands.keys())
        else:
            controller_cmds = getattr(controller, "qpu_commands", None) or {}
            active_qpu_ids = {
                qpu_id for qpu_id, cmds in controller_cmds.items() if cmds
            } or None

        qpu_protos = [
            proto for proto in self.subprotocols.values()
            if isinstance(proto, QPUProtocol)
        ]
        idle_qpu_protos = []

        for qpu_proto in qpu_protos:
            if active_qpu_ids is not None and qpu_proto.qpu_id not in active_qpu_ids:
                idle_qpu_protos.append(qpu_proto)
                continue
            if qpu_proto.is_running:
                yield self.await_signal(qpu_proto, Signals.SUCCESS)
                log.debug(f"[DQCProtocol] {qpu_proto.name} finished at {ns.sim_time()}")

        log.debug("[DQCProtocol] All QPUs finished. Cleaning up.")

        # Stop BSMs, QuantumSwitchProtocol, EPR factories, BSM workers, and any idle QPUs.
        for name, proto in self.subprotocols.items():
            if isinstance(proto, BSMProtocol):
                proto.stop()
            elif isinstance(proto, QuantumSwitchProtocol):
                if proto.is_running:
                    proto.stop()
            elif isinstance(proto, EPRFactoryProtocol):
                proto.stop_workers()
                if proto.is_running:
                    proto.stop()
            elif isinstance(proto, QPUProtocol):
                if proto in idle_qpu_protos and proto.is_running:
                    proto.stop()
                for bsm_lbl, worker in list(proto._bsm_workers.items()):
                    if worker.is_running:
                        worker.stop()
                proto._bsm_workers.clear()

        log.debug(f"[DQCProtocol] All protocols completed at time {ns.sim_time()}")
        self.send_signal(Signals.SUCCESS)
