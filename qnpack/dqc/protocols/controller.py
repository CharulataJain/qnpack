"""
protocols/controller.py
-----------------------
ControllerProtocol — runs on the Central Controller node.

Coordinates QPU and BSM nodes by:
1. Sending commands to all QPUs
2. Collecting ready signals from QPUs at sync points
3. Dispatching clock ticks when both parties for a label are ready
4. Triggering BSM nodes for entanglement generation
"""

import os
import json
import logging

import netsquid as ns
from netsquid.protocols.nodeprotocols import NodeProtocol
from netsquid.components.component import Message
from netsquid.protocols.protocol import Signals

from ..frontends import load_frontend
from ..frontends.util import DATA_REGION_START
from ..labeling import label_and_build_maps
from .epr_factory import FactoryEntanglementWorker

log = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def create_mapper(mapping_list):
    """Build a bidirectional name mapper from a list of (server, site) pairs."""
    server_to_site = {s: site for s, site in mapping_list}
    site_to_server = {site: s for s, site in mapping_list}

    def mapper(name, to="site"):
        if to == "site":
            return server_to_site.get(name, name)
        elif to == "server":
            return site_to_server.get(name, name)
        return name

    return mapper


def insert_pre_entanglement_commands(
    qpu_commands,
    expected_ent_latency_ns=None,
    one_q_gate_duration_ns=5000,
    two_q_gate_duration_ns=10700,
):
    """Move ``entanglement_gen`` commands earlier in each QPU's command list.

    The goal is to overlap Bell-pair generation (which takes
    *expected_ent_latency_ns*) with local gate execution so that the
    entangled pair is ready by the time the corresponding
    ``starting_process`` needs it.

    Parameters
    ----------
    qpu_commands : dict[int, list[dict]]
        Per-QPU command lists (mutated in place).
    expected_ent_latency_ns : float or None
        Expected entanglement latency.  If None or ≤ 0, no moves are made.
    one_q_gate_duration_ns : float
        Duration of a 1-qubit gate (ns).
    two_q_gate_duration_ns : float
        Duration of a 2-qubit gate (ns).

    Returns
    -------
    dict
        Stats dict with keys ``total_pairs``, ``moved_pairs``,
        ``unmoved_pairs``, ``expected_latency_ns``, ``moves``.
    """
    if expected_ent_latency_ns is None or expected_ent_latency_ns <= 0:
        return {
            "total_pairs": 0,
            "moved_pairs": 0,
            "unmoved_pairs": 0,
            "expected_latency_ns": 0,
            "moves": [],
        }

    SYNC_OPS = {
        'entanglement_gen', 'starting_process', 'starting_process_link',
        'ending_process', 'ending_process_link',
    }

    # Index every entanglement_gen by its label
    ent_pairs = {}
    for qpu_id, cmd_list in qpu_commands.items():
        for idx, cmd in enumerate(cmd_list):
            if cmd.get('op') == 'entanglement_gen':
                label = cmd['entanglement_label']
                ent_pairs.setdefault(label, []).append((qpu_id, idx))

    def _gate_duration(cmd):
        op = cmd.get('op', '')
        if op in SYNC_OPS:
            return 0
        qubits = cmd.get('qubits', [])
        if len(qubits) >= 2:
            return two_q_gate_duration_ns
        return one_q_gate_duration_ns

    def _comm_qubits_of(cmd):
        op = cmd.get('op', '')
        if op == 'entanglement_gen':
            return set(cmd.get('qubits', []))
        if op in ('starting_process', 'ending_process'):
            ll = cmd.get('l_local')
            return {ll} if ll is not None else set()
        if op in ('starting_process_link', 'ending_process_link'):
            return set(cmd.get('qubits', []))
        return set()

    sorted_labels = sorted(
        ent_pairs.keys(), key=lambda lbl: int(lbl.split('_')[1])
    )

    total_pairs = len(sorted_labels)
    moved_pairs = 0
    unmoved_pairs = 0
    moves = []

    for ent_label in sorted_labels:
        locations = ent_pairs[ent_label]
        if len(locations) != 2:
            log.warning(
                f"[pre-ent] entanglement_gen {ent_label} has "
                f"{len(locations)} locations (expected 2); skipping"
            )
            unmoved_pairs += 1
            continue

        current_positions = []
        for qpu_id, _ in locations:
            cmd_list = qpu_commands[qpu_id]
            pos = None
            for i, c in enumerate(cmd_list):
                if (
                    c.get('op') == 'entanglement_gen'
                    and c.get('entanglement_label') == ent_label
                ):
                    pos = i
                    break
            if pos is None:
                log.warning(
                    f"[pre-ent] Cannot find {ent_label} on QPU {qpu_id}"
                )
                break
            current_positions.append((qpu_id, pos))

        if len(current_positions) != 2:
            unmoved_pairs += 1
            continue

        feasible_pullbacks = []
        accumulated_times = []
        for qpu_id, cur_pos in current_positions:
            cmd_list = qpu_commands[qpu_id]
            ent_cmd = cmd_list[cur_pos]
            ent_comm_qubits = _comm_qubits_of(ent_cmd)

            accumulated_ns = 0
            earliest_pos = cur_pos

            for j in range(cur_pos - 1, -1, -1):
                prev_cmd = cmd_list[j]
                prev_op = prev_cmd.get('op', '')

                if prev_op in SYNC_OPS:
                    prev_comm = _comm_qubits_of(prev_cmd)
                    if prev_comm & ent_comm_qubits:
                        break
                    break

                prev_gate_qubits = set(prev_cmd.get('qubits', []))
                if prev_gate_qubits & ent_comm_qubits:
                    break

                gate_ns = _gate_duration(prev_cmd)
                accumulated_ns += gate_ns
                earliest_pos = j

                if accumulated_ns >= expected_ent_latency_ns:
                    break

            pullback = cur_pos - earliest_pos
            feasible_pullbacks.append(pullback)
            accumulated_times.append(accumulated_ns)

        if len(feasible_pullbacks) != 2:
            unmoved_pairs += 1
            continue

        actual_pullback = min(feasible_pullbacks)

        if actual_pullback <= 0:
            unmoved_pairs += 1
            continue

        moved_pairs += 1
        qpu_ids = [qid for qid, _ in current_positions]
        moves.append({
            "label": ent_label,
            "pullback": actual_pullback,
            "feasible": list(feasible_pullbacks),
            "gate_time_ns": list(accumulated_times),
            "qpus": qpu_ids,
        })

        log.debug(
            f"[pre-ent] Moving {ent_label} earlier by {actual_pullback} "
            f"commands (feasible: {feasible_pullbacks})"
        )

        for qpu_id, cur_pos in current_positions:
            cmd_list = qpu_commands[qpu_id]
            new_pos = cur_pos - actual_pullback
            ent_cmd = cmd_list.pop(cur_pos)
            cmd_list.insert(new_pos, ent_cmd)

    return {
        "total_pairs": total_pairs,
        "moved_pairs": moved_pairs,
        "unmoved_pairs": unmoved_pairs,
        "expected_latency_ns": expected_ent_latency_ns,
        "moves": moves,
    }


# ---------------------------------------------------------------------------
# ControllerProtocol
# ---------------------------------------------------------------------------

class ControllerProtocol(NodeProtocol):
    """Protocol running on the Central Controller node.

    Parameters
    ----------
    cfg : Munch
        Simulation configuration.
    node : Node
        The controller node.
    qpu_nodes : list[Node]
        All QPU nodes.
    qpu_info : dict, optional
        QPU topology metadata.
    bsm_info : dict, optional
        BSM topology metadata.
    name : str or None
        Protocol name.
    run_idx : int
        Current simulation run index (used to gate schedule printing).
    frontend : BaseFrontend or None
        Pre-loaded frontend instance.  When provided, the controller
        reuses it instead of calling ``load_frontend`` again.
    """

    def __init__(
        self,
        cfg,
        node,
        qpu_nodes,
        qpu_info=None,
        bsm_info=None,
        name=None,
        run_idx=0,
        frontend=None,
        pre_labeled_commands=None,
        pre_process_maps=None,
    ):
        super().__init__(node, name=name)
        self.cfg = cfg
        self.run_idx = run_idx
        self.frontend = frontend
        self.qpu_nodes = qpu_nodes
        self.num_qpus = len(qpu_nodes)
        self.qpu_commands = {}
        self.qpu_info = qpu_info or {}
        self.bsm_info = bsm_info or {}

        # Pre-labeled commands injected from outside (e.g. the DQC plugin),
        # keyed by 1-based QPU id.  When set, run() skips parse, validate,
        # and label and uses these directly.
        self._pre_labeled_commands = pre_labeled_commands
        self._pre_process_maps = pre_process_maps
        self.mapping_list = [
            ("QPU_1", "LBNL-A"),
            ("QPU_2", "LBNL-B"),
            ("QPU_3", "LBNL-C"),
            ("QPU_4", "LBNL-D"),
        ]

        self.qpu_pair_to_bsms = {}
        self._build_qpu_pair_to_bsm_map()

        self.clk = self.node.subcomponents["CtrlCLK"]

        self.num_bsm_nodes = len(self.bsm_info)

        self.start_qpus = {}
        self.start_ready = {}
        # start_label -> set of QPU ids that hold a usable pre-generated pair
        self.start_pool_ready = {}
        self.end_qpus = {}
        self.end_ready = {}

        self.waiting_qpus = set()
        self.finished_qpus = set()

        self.epr_factory_enabled = False  # Set by DQCProtocol when factory is configured
        self.epr_factories = []  # List of EPRFactoryProtocol instances (set by DQCProtocol)
        self.factory_by_qpu = {}  # qpu_id -> EPRFactoryProtocol (set by DQCProtocol)
        # Max comm qubits per QPU that pool storage may claim (set by DQCProtocol)
        self.factory_comm_budget = None

        # ── Continuous refill state ──────────────────────────────────────
        # Pool layout (see _build_pool_pairings); computed once per run.
        self._pool_pairings = None
        # Shared scheduler; leases BSMs so two rounds never share one.
        self._refill_queue = None
        # job_id -> in-flight round bookkeeping
        self._refill_in_flight = {}
        # (lo, hi, slot) -> rebuild count, keeping refill job ids distinct
        # from the pre-fill round.
        self._refill_generation = {}
        self._stats_refill_dispatched = 0
        self._stats_refill_succeeded = 0
        self._stats_refill_failed = 0
        # BSMs leased to an on-demand round: bsm_label -> participating QPUs.
        # A BSM has one gated detector window, so overlapping rounds would
        # make the herald unattributable.  Leases come from the pool the
        # refill scheduler uses, making the two paths mutually exclusive,
        # and are released when a participating QPU next reports in.
        self._ondemand_bsm_leases = {}

    # ── BSM mapping ──────────────────────────────────────────────────────────

    def _build_qpu_pair_to_bsm_map(self):
        """Map each QPU pair to **every** ``(bsm_id, bsm_label)`` serving it.

        The value is a list rather than a single entry because a pairing may
        be wired to more than one BSM.  With one BSM per pairing this
        degenerates to the previous behaviour; with several, the refill
        scheduler can lease them independently and run rounds in parallel.
        """
        label_to_qpu_id = {
            label: info["qpu_id"] for label, info in self.qpu_info.items()
        }

        for bsm_label, bsm_inf in self.bsm_info.items():
            bsm_id = bsm_inf["bsm_id"]
            left_label = bsm_inf.get("left_qpu")
            right_label = bsm_inf.get("right_qpu")

            if left_label in label_to_qpu_id and right_label in label_to_qpu_id:
                left_qpu_id = label_to_qpu_id[left_label]
                right_qpu_id = label_to_qpu_id[right_label]
                pair = frozenset({left_qpu_id, right_qpu_id})
                self.qpu_pair_to_bsms.setdefault(pair, []).append(
                    (bsm_id, bsm_label)
                )
                log.debug(
                    f"[Controller] BSM mapping: QPU_{left_qpu_id} & QPU_{right_qpu_id} "
                    f"-> BSM_Node{bsm_id} ({bsm_label})"
                )

        # Deterministic order, so the "default" BSM for a pairing is stable
        # across runs even when the topology lists several.
        for pair in self.qpu_pair_to_bsms:
            self.qpu_pair_to_bsms[pair].sort()

        log.debug(f"[Controller] QPU-pair -> BSM map: {self.qpu_pair_to_bsms}")

    def bsms_for_pair(self, qpu_ids):
        """Every ``(bsm_id, bsm_label)`` that can entangle *qpu_ids*."""
        return self.qpu_pair_to_bsms.get(frozenset(qpu_ids), [])

    def default_bsm_for_pair(self, qpu_ids):
        """The first BSM serving *qpu_ids*, or ``None`` if the pair is unwired.

        Used by paths that need a single BSM — on-demand entanglement keeps
        the circuit plane's one-BSM-per-pair assumption; only refill leases
        across the full set.
        """
        entries = self.bsms_for_pair(qpu_ids)
        return entries[0] if entries else None

    # ── Messaging ────────────────────────────────────────────────────────────

    # ── On-demand BSM leasing ────────────────────────────────────────────────

    def _acquire_ondemand_bsm(self, bsm_label, qpu_ids):
        """Lease *bsm_label* for a circuit-plane round, if it is free.

        Refill and the on-demand path share physical BSMs, so they must
        share one arbiter.  Taking the lease out of the refill scheduler's
        own ``available_bsms`` set is what guarantees the two can never
        overlap on a detector.

        Returns
        -------
        bool
            ``True`` when the BSM is ours (or there is no refill scheduler
            to contend with, as during single-shot execution).
        """
        if self._refill_queue is None or bsm_label is None:
            return True
        if bsm_label not in self._refill_queue.available_bsms:
            return False
        self._refill_queue.available_bsms.discard(bsm_label)
        self._ondemand_bsm_leases[bsm_label] = set(qpu_ids)
        return True

    def _release_ondemand_bsm(self, qpu_id):
        """Return any BSM leased on behalf of *qpu_id* to the refill pool."""
        if not self._ondemand_bsm_leases:
            return
        for bsm_label, qpus in list(self._ondemand_bsm_leases.items()):
            if qpu_id in qpus:
                del self._ondemand_bsm_leases[bsm_label]
                if self._refill_queue is not None:
                    self._refill_queue.available_bsms.add(bsm_label)

    def _ondemand_bsm_busy(self, bsm_label):
        """Whether a circuit-plane round currently holds *bsm_label*."""
        return bsm_label in self._ondemand_bsm_leases

    def send_start_entanglement_to_bsm(
        self, qpu_ids, start_label, factory=False, bsm_label=None,
    ):
        """Send a 'Start Entanglement' message to the BSM node.

        When *factory* is ``True`` the message type is
        ``'factory_start_entanglement'``, which makes the BSM emit its clock
        ticks and results on the dedicated EPR-factory classical plane
        instead of the circuit plane.

        Parameters
        ----------
        bsm_label : str or None
            Target a specific BSM.  Refill leases a BSM from the set serving
            the pairing and must trigger exactly that one; callers that omit
            this get the pairing's default BSM.
        """
        entries = self.bsms_for_pair(qpu_ids)
        if bsm_label is not None:
            bsm_entry = next(
                (e for e in entries if e[1] == bsm_label), None
            )
        else:
            bsm_entry = entries[0] if entries else None

        if bsm_entry is None:
            log.warning(
                f"[Controller] No BSM node found for QPU pair {qpu_ids}"
            )
            return

        bsm_id, bsm_label = bsm_entry
        port_name = f"ctrl_bsm{bsm_id}_port"
        if port_name in self.node.ports:
            msg = Message(items={
                'type': (
                    'factory_start_entanglement' if factory
                    else 'start_entanglement'
                ),
                'start_label': start_label,
                'qpu_ids': list(qpu_ids),
                'bsm_id': bsm_id,
                'bsm_label': bsm_label,
            })
            self.node.ports[port_name].tx_output(msg)
            log.debug(
                f"[Controller] Sent 'Start Entanglement' to BSM_Node{bsm_id} "
                f"({bsm_label}) via {port_name} for start_label={start_label}, "
                f"QPUs={qpu_ids}"
            )
        else:
            log.error(
                f"[Controller] Port {port_name} not found on {self.node.name}"
            )

    def send_commands_to_qpu(self, qpu_id, commands):
        """Send commands to a specific QPU via ctrl port."""
        port_name = f"ctrl{qpu_id}_port"
        if port_name in self.node.ports:
            msg = Message(items={'commands': commands, 'qpu_id': qpu_id})
            self.node.ports[port_name].tx_output(msg)
            log.debug(
                f"[{self.node.name}] Sent {len(commands)} commands to QPU_{qpu_id}"
            )
        else:
            log.error(f"[{self.node.name}] Port {port_name} not found")

    def choose_pool_slot(self, qpu_ids):
        """Pick the slot both endpoints of *qpu_ids* will consume.

        The two sides used to select independently by "lowest usable slot",
        which agreed only while the pool was static.  Continuous refill
        breaks that: each side consumes at a slightly different instant, so
        a slot committed in between is visible to one and not the other and
        they pick different halves.  The controller sees both pools at one
        instant, so it can name the slot and remove the ambiguity entirely.

        Returns
        -------
        int or None
            A slot usable on both sides, or ``None`` if there is none.
        """
        pair = sorted(qpu_ids)
        if len(pair) != 2:
            return None
        lo, hi = pair
        lo_factory = self.factory_by_qpu.get(lo)
        hi_factory = self.factory_by_qpu.get(hi)
        if lo_factory is None or hi_factory is None:
            return None

        now = ns.sim_time()
        shared = (
            lo_factory.usable_slots(hi, now) & hi_factory.usable_slots(lo, now)
        )
        return min(shared) if shared else None

    def send_clock_tick_to_all(
        self, qpu_ids, start_label=None, end_label=None, bsm_label=None,
        use_pool=False, pool_slot=None,
    ):
        """Send a single clock tick to multiple QPUs simultaneously."""
        if not self.clk.is_running:
            self.clk.start()
        log.debug(
            f"{ns.sim_time()} Controller: Clock running: {self.clk.is_running}, "
            f"num_ticks: {self.clk.num_ticks} at {self.node.name}"
        )

        def _build_port_names():
            return [f"comm{qpu_id_iter}_port" for qpu_id_iter in self.qpu_commands]

        def _build_combined_ev():
            _clk_ev = self.await_port_output(self.clk.ports["cout"])
            _comm_ev = None
            for pn in _build_port_names():
                if pn in self.node.ports:
                    port_ev = self.await_port_input(self.node.ports[pn])
                    _comm_ev = port_ev if _comm_ev is None else _comm_ev | port_ev
            if _comm_ev is not None:
                return _clk_ev | _comm_ev
            return _clk_ev

        combined_ev = _build_combined_ev()
        clk_received = False

        while not clk_received:
            yield combined_ev

            clk_msg = self.clk.ports["cout"].rx_output()
            if clk_msg is not None:
                clk_received = True

            for pn in _build_port_names():
                if pn in self.node.ports:
                    comm_msg = self.node.ports[pn].rx_input()
                    if comm_msg is not None:
                        self.process_ready_message(comm_msg)

            if not clk_received:
                combined_ev = _build_combined_ev()

        for qpu_id in qpu_ids:
            port_name = f"clk{qpu_id}_port"
            if port_name in self.node.ports:
                msg = Message(items={
                    'start_label': start_label,
                    'end_label': end_label,
                    'bsm_label': bsm_label,
                    'use_pool': use_pool,
                    'pool_slot': pool_slot,
                    'clk_tick': clk_msg,
                })
                self.node.ports[port_name].tx_output(msg)
                log.debug(
                    f"[Controller] Sent clock tick to QPU_{qpu_id}, "
                    f"start_label={start_label}, end_label={end_label}, "
                    f"bsm_label={bsm_label}"
                )
            else:
                log.error(
                    f"[Controller] Port {port_name} not found on {self.node.name}"
                )

    # ── Process maps ─────────────────────────────────────────────────────────

    def process_ready_message(self, msg):
        """Process a ready message from a QPU and store it."""
        item = msg.items[0]
        recv_qpu = item.get('qpu_id')
        recv_type = item.get('type')
        start_label = item.get('start_label')
        end_label = item.get('end_label')

        # A QPU only sends once its on-demand round has completed, so its
        # BSM can be released back to refill.
        self._release_ondemand_bsm(recv_qpu)

        if recv_type == 'start_ready' and start_label is not None:
            if start_label not in self.start_ready:
                self.start_ready[start_label] = set()
            self.start_ready[start_label].add(recv_qpu)
            self.waiting_qpus.add(recv_qpu)

            # Track which QPUs can serve this label from their EPR pool.
            if item.get('pool_ready'):
                self.start_pool_ready.setdefault(start_label, set()).add(recv_qpu)

            log.debug(
                f"[Controller] QPU_{recv_qpu} ready for start_label={start_label} "
                f"(pool_ready={bool(item.get('pool_ready'))})"
            )
            return ('start', start_label, recv_qpu)

        elif recv_type == 'end_ready' and end_label is not None:
            if end_label not in self.end_ready:
                self.end_ready[end_label] = set()
            self.end_ready[end_label].add(recv_qpu)
            self.waiting_qpus.add(recv_qpu)
            log.debug(
                f"[Controller] QPU_{recv_qpu} ready for end_label={end_label}"
            )
            return ('end', end_label, recv_qpu)

        elif recv_type == 'done':
            self.finished_qpus.add(recv_qpu)
            log.debug(
                f"[Controller] QPU_{recv_qpu} done. "
                f"finished_qpus={self.finished_qpus} "
                f"({len(self.finished_qpus)}/{self.num_qpus})"
            )
            return ('done', None, recv_qpu)

        return (None, None, recv_qpu)

    def get_next_ready_process(self):
        """Find the next process (start or end) that has both parties ready."""

        def sort_key(label):
            if isinstance(label, str) and label.startswith("ent_"):
                try:
                    n = int(label[4:])
                except ValueError:
                    n = 0
                return (0, n, label)
            elif isinstance(label, int):
                return (1, label, "")
            else:
                return (2, 0, str(label))

        for label in sorted(self.start_qpus.keys(), key=sort_key):
            required = self.start_qpus[label]
            ready = self.start_ready.get(label, set())
            if required == ready:
                return (True, label)

        for label in sorted(self.end_qpus.keys()):
            required = self.end_qpus[label]
            ready = self.end_ready.get(label, set())
            if required == ready:
                return (False, label)

        return (None, None)

    # ── Schedule printing ────────────────────────────────────────────────────

    def compute_timeslot_schedule(self, qpu_commands, mapping_list):
        """Compute a timeslot schedule with commands aligned across QPUs."""
        map_name = create_mapper(mapping_list)
        qpu_ids = sorted(qpu_commands.keys())
        cursors = {qid: 0 for qid in qpu_ids}

        start_label_qpus = {}
        end_label_qpus = {}
        entanglement_label_qpus = {}
        for qid in qpu_ids:
            for cmd in qpu_commands[qid]:
                sl = cmd.get('start_label')
                el = cmd.get('end_label')
                if sl is not None:
                    start_label_qpus.setdefault(sl, set()).add(qid)
                if el is not None:
                    end_label_qpus.setdefault(el, set()).add(qid)
                ent_l = cmd.get('entanglement_label')
                if ent_l is not None and cmd['op'] == 'entanglement_gen':
                    entanglement_label_qpus.setdefault(ent_l, set()).add(qid)

        schedule = []

        def cmd_description(cmd):
            op = cmd['op']
            orig = cmd.get('original_qubits', [])
            sl = cmd.get('start_label') or cmd.get('target_start_label')
            el = cmd.get('end_label')
            if op == 'pre_entanglement':
                return f"PRE_ENTG (sl={sl})" if sl is not None else "PRE_ENTG"
            desc = f"{op} {', '.join(orig)}" if orig else op
            if sl is not None:
                desc += f" (sl={sl})"
            elif el is not None:
                desc += f" (el={el})"
            return desc

        def current_cmd(qid):
            idx = cursors[qid]
            cmds = qpu_commands[qid]
            return cmds[idx] if idx < len(cmds) else None

        def is_sync_cmd(cmd):
            if cmd is None:
                return False
            if cmd.get('start_label') is not None:
                return True
            if cmd.get('end_label') is not None:
                return True
            if (
                cmd.get('entanglement_label') is not None
                and cmd['op'] == 'entanglement_gen'
            ):
                return True
            return False

        max_iterations = sum(len(cmds) for cmds in qpu_commands.values()) * 2
        iteration = 0

        while any(cursors[qid] < len(qpu_commands[qid]) for qid in qpu_ids):
            iteration += 1
            if iteration > max_iterations:
                log.warning(
                    "[Controller] Timeslot scheduling exceeded max iterations, breaking."
                )
                break

            slot = {map_name(f"QPU_{qid}", to="site"): "" for qid in qpu_ids}
            advanced = set()
            sync_found = False

            current_start_labels = {}
            current_end_labels = {}
            current_ent_labels = {}

            for qid in qpu_ids:
                cmd = current_cmd(qid)
                if cmd is None:
                    continue
                sl = cmd.get('start_label')
                el = cmd.get('end_label')
                ent_l = cmd.get('entanglement_label')
                if ent_l is not None and cmd['op'] == 'entanglement_gen':
                    current_ent_labels.setdefault(ent_l, set()).add(qid)
                if sl is not None:
                    current_start_labels.setdefault(sl, set()).add(qid)
                if el is not None:
                    current_end_labels.setdefault(el, set()).add(qid)

            for label in sorted(current_ent_labels.keys()):
                required = entanglement_label_qpus.get(label, set())
                ready = current_ent_labels.get(label, set())
                if required == ready:
                    for qid in required:
                        cmd = current_cmd(qid)
                        site = map_name(f"QPU_{qid}", to="site")
                        slot[site] = cmd_description(cmd)
                        advanced.add(qid)
                    sync_found = True
                    break

            if not sync_found:
                for label in sorted(current_start_labels.keys()):
                    required = start_label_qpus.get(label, set())
                    ready = current_start_labels.get(label, set())
                    if required == ready:
                        for qid in required:
                            cmd = current_cmd(qid)
                            site = map_name(f"QPU_{qid}", to="site")
                            slot[site] = cmd_description(cmd)
                            advanced.add(qid)
                        sync_found = True
                        break

            if not sync_found:
                for label in sorted(current_end_labels.keys()):
                    required = end_label_qpus.get(label, set())
                    ready = current_end_labels.get(label, set())
                    if required == ready:
                        for qid in required:
                            cmd = current_cmd(qid)
                            site = map_name(f"QPU_{qid}", to="site")
                            slot[site] = cmd_description(cmd)
                            advanced.add(qid)
                        sync_found = True
                        break

            if not sync_found:
                for qid in qpu_ids:
                    cmd = current_cmd(qid)
                    if cmd is None:
                        continue
                    if is_sync_cmd(cmd):
                        continue
                    site = map_name(f"QPU_{qid}", to="site")
                    slot[site] = cmd_description(cmd)
                    advanced.add(qid)

                if not advanced:
                    for qid in qpu_ids:
                        cmd = current_cmd(qid)
                        if cmd is not None:
                            site = map_name(f"QPU_{qid}", to="site")
                            slot[site] = cmd_description(cmd)
                            advanced.add(qid)
                            break

            for qid in advanced:
                cursors[qid] += 1

            schedule.append(slot)

        return schedule

    def print_timeslot_schedule(self, schedule, mapping_list):
        """Print the timeslot schedule as a formatted table."""
        map_name = create_mapper(mapping_list)

        qpu_names = set()
        for slot in schedule:
            qpu_names.update(slot.keys())
        qpu_names = sorted(qpu_names)

        slot_col_width = max(len("Slot"), len(str(len(schedule) - 1))) + 2
        col_widths = {}
        for qpu in qpu_names:
            max_content = len(qpu)
            for slot in schedule:
                content = slot.get(qpu, "")
                max_content = max(max_content, len(content))
            col_widths[qpu] = max_content + 2

        total_width = slot_col_width + sum(col_widths.values())
        header = f"{'Slot':<{slot_col_width}}" + "".join(
            f"{qpu:<{col_widths[qpu]}}" for qpu in qpu_names
        )
        separator = "-" * total_width
        print(header)
        print(separator)

        for t, slot in enumerate(schedule):
            has_pre_entg = any(
                "PRE_ENTG" in slot.get(qpu, "") for qpu in qpu_names
            )
            has_start = any(
                "starting_process" in slot.get(qpu, "") for qpu in qpu_names
            )

            suffix = ""
            if has_pre_entg:
                suffix = "  ◄── PRE_ENTG"
            elif has_start:
                suffix = "  ◄── SYNC"

            row = (
                f"{t:<{slot_col_width}}"
                + "".join(
                    f"{slot.get(qpu, ''):<{col_widths[qpu]}}" for qpu in qpu_names
                )
                + suffix
            )
            print(row)

        print(separator)
        print(f"Total timeslots: {len(schedule)}")

    def _print_pre_ent_summary(self, stats):
        """Print a human-readable summary of pre-entanglement scheduling."""
        total = stats["total_pairs"]
        moved = stats["moved_pairs"]
        unmoved = stats["unmoved_pairs"]
        latency = stats["expected_latency_ns"]

        log.info("=" * 60)
        log.info("PRE-ENTANGLEMENT SCHEDULING SUMMARY")
        log.info("=" * 60)
        log.info(
            f"  Expected entanglement latency : {latency:,.0f} ns "
            f"({latency / 1e6:.3f} ms)"
        )
        log.info(f"  Total entanglement pairs      : {total}")
        log.info(f"  Pairs moved earlier           : {moved}")
        log.info(f"  Pairs not moved (at barrier)  : {unmoved}")
        if total > 0:
            log.info(
                f"  Move rate                     : "
                f"{moved / total * 100:.1f}%"
            )

        if stats["moves"]:
            log.info("-" * 60)
            log.info(
                f"  {'Label':<10} {'QPUs':<10} {'Pullback':>8} "
                f"{'Feasible':>12} {'Gate time (ns)':>20}"
            )
            log.info("-" * 60)
            total_gate_time = 0.0
            for m in stats["moves"]:
                qpus_str = f"{m['qpus'][0]},{m['qpus'][1]}"
                feas_str = f"[{m['feasible'][0]},{m['feasible'][1]}]"
                gt = m["gate_time_ns"]
                gt_str = f"[{gt[0]:,.0f}, {gt[1]:,.0f}]"
                effective_overlap = min(gt[0], gt[1])
                total_gate_time += effective_overlap
                log.info(
                    f"  {m['label']:<10} {qpus_str:<10} "
                    f"{m['pullback']:>8} {feas_str:>12} {gt_str:>20}"
                )

            avg_overlap = total_gate_time / len(stats["moves"])
            coverage = (avg_overlap / latency * 100) if latency > 0 else 0
            log.info("-" * 60)
            log.info(
                f"  Avg effective gate overlap    : {avg_overlap:,.0f} ns "
                f"({coverage:.1f}% of expected latency)"
            )
            log.info(
                f"  Total gate time overlapped    : {total_gate_time:,.0f} ns "
                f"({total_gate_time / 1e6:.3f} ms)"
            )
        log.info("=" * 60)

    # ── EPR factory pre-fill ─────────────────────────────────────────────────

    def _circuit_entanglement_pairs(self):
        """Return the set of QPU pairs the circuit actually entangles.

        Derived from the ``entanglement_gen`` labels and their participating
        QPUs, so the factory only reserves communication qubits for pairings
        the circuit will really consume.

        Returns
        -------
        set[frozenset[int]]
        """
        pairs = set()
        for label in getattr(self, 'entanglement_gen_labels', ()) or ():
            qpus = self.start_qpus.get(label)
            if qpus and len(qpus) == 2:
                pairs.add(frozenset(qpus))
        return pairs

    def _topology_comm_capacity(self):
        """Communication qubits each QPU actually has, per the topology.

        The factory must size pool storage against *hardware*, not against
        the address-layout constant ``NUM_COMM_QUBITS`` (which merely says
        where the data region begins).  A QPU declaring 2 communication
        qubits cannot hold 8 pooled pairs no matter what the config asks
        for.

        Returns
        -------
        dict[int, int]
            ``{qpu_id: comm_qubit_count}``.  QPUs missing from
            ``qpu_info`` are omitted, and callers then fall back to the
            layout constant.
        """
        capacity = {}
        for _label, info in (self.qpu_info or {}).items():
            if not isinstance(info, dict) or "qpu_id" not in info:
                continue
            qubits = info.get("qubits")
            if not qubits:
                continue
            capacity[info["qpu_id"]] = sum(
                1 for q in qubits if q.get("type") == "communication"
            )
        return capacity

    def _all_circuit_comm_positions(self):
        """Every comm position the circuit names, per QPU.

        Returns
        -------
        dict[int, set[int]]
        """
        used = {}
        for qpu_id, commands in self.qpu_commands.items():
            seen = used.setdefault(qpu_id, set())
            for cmd in commands:
                candidates = list(cmd.get('qubits') or [])
                for key in ('qubit', 'comm_qubit', 'data_qubit', 'l_local',
                            'free_comm_qubit', 'mark_comm_occupied'):
                    value = cmd.get(key)
                    if isinstance(value, int):
                        candidates.append(value)
                for pos in candidates:
                    if isinstance(pos, int) and 0 <= pos < DATA_REGION_START:
                        seen.add(pos)
        return used

    def _align_pools_with_circuit(self):
        """Prune unused pools and give each pooled pair disjoint storage.

        Two corrections are applied before pre-fill:

        1. **Prune** pools for QPU pairs the circuit never entangles, since
           each pooled pair permanently occupies a communication qubit.
        2. **Allocate storage outside the circuit's own comm positions.**

        The second point is subtle.  Pre-fill stages every pooled pair
        *before* the circuit runs, so each needs its own physical qubit —
        and that qubit must not be one the circuit itself names.  The
        compiler reuses a small set of low comm positions, recycling them
        after each release, so reusing its positions as pool storage creates
        aliasing: a pair parked on position 1 collides with the circuit's
        independent use of position 1, and the remap table degenerates into
        a cycle such as ``{0: 1, 1: 2, 2: 0}``.

        Allocating from the *top* of the comm region downwards keeps pool
        storage disjoint from compiler-named positions.  ``QPUProtocol``
        then redirects the compiler's position to the pooled one through its
        remap table, so the circuit stays agnostic to where the pair lives.

        Each QPU may dedicate at most ``factory_comm_budget`` qubits
        (``epr_factory.comm_qubits_reserved``) to pool storage in total,
        so a deep pool cannot starve the circuit of communication qubits.
        That budget is split **evenly across a QPU's peers**.  Allocating
        greedily in peer order instead would let the first pairing consume
        almost everything: with ``pool_size=16`` and a budget of 20, peer A
        took 16 qubits and peer B got 2.  Because pre-fill pairs slots via
        ``min()`` of the two endpoints, the starved pairing then collapses to
        depth 2 and *total* pooled coverage falls as ``pool_size`` rises.
        """
        wanted = self._circuit_entanglement_pairs()
        circuit_used = self._all_circuit_comm_positions()
        budget = getattr(self, 'factory_comm_budget', None)
        comm_capacity = self._topology_comm_capacity()

        # Per-QPU allocator: start above every circuit-named position and
        # walk down so pool storage never aliases one.
        taken = {
            qpu_id: set(circuit_used.get(qpu_id, set()))
            for qpu_id in self.factory_by_qpu
        }

        # Validate the reservation against hardware up front so an oversized
        # request is reported once instead of truncated per pairing.
        for qpu_id in sorted(self.factory_by_qpu):
            hw = comm_capacity.get(qpu_id)
            if hw is None:
                continue
            in_use = len(circuit_used.get(qpu_id, set()))
            free = hw - in_use
            if budget is not None and budget > free:
                log.warning(
                    f"[Controller] EPR factory: QPU_{qpu_id} has {hw} "
                    f"communication qubit(s), {in_use} used by the circuit, "
                    f"leaving {free} for pool storage — but "
                    f"comm_qubits_reserved={budget}. Clamping to {max(free, 0)}."
                )
            if free <= 0:
                log.warning(
                    f"[Controller] EPR factory: QPU_{qpu_id} has no spare "
                    f"communication qubits; its pools will be dropped and "
                    f"all its entanglement served on demand."
                )

        # Drop pairings the circuit never entangles before dividing the
        # budget, so pruned peers do not consume a share.
        for qpu_id, factory in list(self.factory_by_qpu.items()):
            for peer_qpu_id in list(factory.peer_configs):
                if frozenset({qpu_id, peer_qpu_id}) not in wanted:
                    factory.drop_peer(peer_qpu_id)
                    log.debug(
                        f"[Controller] Pruned unused EPR pool "
                        f"QPU_{qpu_id}<->QPU_{peer_qpu_id} "
                        f"(no entanglement_gen between them)"
                    )

        # Fair share per peer, bounded by whatever the hardware leaves free
        # after the circuit's own comm-qubit use.
        share = {}
        for qpu_id, factory in self.factory_by_qpu.items():
            n_peers = len(factory.peer_configs)
            hw = comm_capacity.get(
                qpu_id, factory.qpu_protocol.NUM_COMM_QUBITS
            )
            free = max(0, hw - len(circuit_used.get(qpu_id, set())))
            allowed = free if budget is None else min(budget, free)
            if n_peers == 0 or allowed <= 0:
                share[qpu_id] = 0
            else:
                share[qpu_id] = max(1, allowed // n_peers)

        for qpu_id, factory in list(self.factory_by_qpu.items()):
            for peer_qpu_id in list(factory.peer_configs):
                requested = factory.peer_configs[peer_qpu_id]["pool_size"]
                capacity = min(requested, share[qpu_id])
                # Never address beyond the QPU's real communication qubits.
                num_comm = min(
                    factory.qpu_protocol.NUM_COMM_QUBITS,
                    comm_capacity.get(
                        qpu_id, factory.qpu_protocol.NUM_COMM_QUBITS
                    ),
                )

                positions = []
                for pos in range(num_comm - 1, -1, -1):
                    if len(positions) >= capacity:
                        break
                    if pos not in taken[qpu_id]:
                        positions.append(pos)
                        taken[qpu_id].add(pos)

                if positions and len(positions) < requested:
                    log.info(
                        f"[Controller] EPR pool QPU_{qpu_id}<->"
                        f"QPU_{peer_qpu_id}: depth {len(positions)} instead of "
                        f"the requested {requested} (communication qubits are "
                        f"shared with the circuit and {max(1, len(factory.peer_configs))} "
                        f"peer pool(s))"
                    )

                if not positions:
                    factory.drop_peer(peer_qpu_id)
                    log.debug(
                        f"[Controller] Pruned EPR pool "
                        f"QPU_{qpu_id}<->QPU_{peer_qpu_id}: no comm position "
                        f"free of circuit use (falling back to on-demand)"
                    )
                    continue

                factory.set_peer_positions(peer_qpu_id, sorted(positions))
                log.debug(
                    f"[Controller] EPR pool QPU_{qpu_id}<->QPU_{peer_qpu_id} "
                    f"storage={sorted(positions)} "
                    f"(circuit uses {sorted(circuit_used.get(qpu_id, set()))})"
                )

        # A pool is only usable if BOTH endpoints kept one, since a pair
        # needs a reserved qubit on each side.
        for qpu_id, factory in list(self.factory_by_qpu.items()):
            for peer_qpu_id in list(factory.peer_configs):
                peer_factory = self.factory_by_qpu.get(peer_qpu_id)
                if peer_factory is None or qpu_id not in peer_factory.peer_configs:
                    factory.drop_peer(peer_qpu_id)
                    log.debug(
                        f"[Controller] Pruned EPR pool "
                        f"QPU_{qpu_id}<->QPU_{peer_qpu_id}: peer side "
                        f"has no matching pool"
                    )

    def _build_prefill_schedule(self):
        """Build the deterministic list of pre-fill jobs to execute.

        Each job entangles one communication qubit on ``qpu_lo`` with one on
        ``qpu_hi`` through their shared BSM.  Jobs are emitted in sorted
        ``(qpu_lo, qpu_hi, slot)`` order so both endpoints agree on the
        sequencing without any negotiation.

        Only QPU pairs where *both* sides are active (have circuit commands)
        and both have a configured factory pool are scheduled.

        Returns
        -------
        list[dict]
            Job descriptors with keys ``job_id``, ``lo``, ``hi``,
            ``lo_position``, ``hi_position``, ``slot``.

        Notes
        -----
        ``lo`` and ``hi`` are the two **QPU ids** of the pairing, sorted —
        not register positions.  ``lo_position`` therefore means "the comm
        qubit on the lower-numbered QPU", which is frequently the larger
        index, since storage is allocated from the top of the comm region
        downwards.

        The ``slot`` index is the durable identity of a pair: both halves
        are tagged with it, so each QPU can later pick the matching half
        purely by local rule (see :meth:`EPRPairPool.consume_best`).
        """
        schedule = []
        for pairing in self._build_pool_pairings():
            for slot in range(pairing["num_slots"]):
                schedule.append(self._make_generation_job(pairing, slot))
        return schedule

    def _build_pool_pairings(self):
        """Describe every pooled QPU pairing and the storage backing it.

        This is the durable shape of the pool layout: which two QPUs share a
        pool, which comm qubit holds each slot on each side, and how many
        slots there are.  Pre-fill walks it once; refill consults it for the
        lifetime of the run to rebuild whichever slots have drained.

        Returns
        -------
        list[dict]
            Keys ``lo``, ``hi``, ``lo_positions``, ``hi_positions``,
            ``num_slots``.
        """
        if self._pool_pairings is not None:
            return self._pool_pairings

        pairings = []
        seen_pairs = set()

        for qpu_id, factory in sorted(self.factory_by_qpu.items()):
            for peer_qpu_id, _peer_cfg in sorted(factory.peer_configs.items()):
                lo, hi = min(qpu_id, peer_qpu_id), max(qpu_id, peer_qpu_id)
                if (lo, hi) in seen_pairs:
                    continue

                lo_factory = self.factory_by_qpu.get(lo)
                hi_factory = self.factory_by_qpu.get(hi)
                if lo_factory is None or hi_factory is None:
                    continue

                # Both sides must be running a circuit, otherwise the idle
                # QPU's node protocols never start and the round would hang.
                if lo not in self.active_qpu_ids or hi not in self.active_qpu_ids:
                    log.debug(
                        f"[Controller] Skipping pre-fill for QPU_{lo}<->QPU_{hi}: "
                        f"inactive endpoint (active={sorted(self.active_qpu_ids)})"
                    )
                    continue

                if not self.bsms_for_pair({lo, hi}):
                    continue

                lo_cfg = lo_factory.peer_configs.get(hi)
                hi_cfg = hi_factory.peer_configs.get(lo)
                if lo_cfg is None or hi_cfg is None:
                    continue

                seen_pairs.add((lo, hi))

                lo_positions = list(lo_cfg["comm_positions"])
                hi_positions = list(hi_cfg["comm_positions"])
                pairings.append({
                    "lo": lo,
                    "hi": hi,
                    "lo_positions": lo_positions,
                    "hi_positions": hi_positions,
                    "num_slots": min(len(lo_positions), len(hi_positions)),
                })

        self._pool_pairings = pairings
        return pairings

    def _make_generation_job(self, pairing, slot, generation=0):
        """Build one generation job for *slot* of *pairing*.

        Parameters
        ----------
        generation : int
            How many times this slot has been rebuilt.  It only
            distinguishes job ids, so a refill round is never confused with
            the pre-fill round that first filled the same slot.
        """
        lo, hi = pairing["lo"], pairing["hi"]
        suffix = "" if generation == 0 else f"_r{generation}"
        return {
            "job_id": f"factory_{lo}_{hi}_{slot}{suffix}",
            "lo": lo,
            "hi": hi,
            "lo_position": pairing["lo_positions"][slot],
            "hi_position": pairing["hi_positions"][slot],
            "slot": slot,
        }

    # ── Generation scheduling (shared by pre-fill and refill) ────────────────

    def _make_entanglement_queue(self):
        """Create an :class:`EntanglementQueue` over every BSM in the network.

        The queue owns the two hardware constraints that govern parallel
        generation — one round per BSM, one emission per QPU — so neither
        pre-fill nor refill has to re-implement serialisation.  With a single
        BSM per pairing it schedules exactly the sequential behaviour the
        pre-fill phase had before; with several it produces genuinely
        parallel batches.
        """
        from ..models.qswitch import EntanglementQueue

        all_bsm_labels = sorted(self.bsm_info.keys())
        return EntanglementQueue(all_bsm_labels)

    def _dispatch_generation_job(self, job, bsm_label):
        """Arm both endpoints for *job* and trigger the leased BSM.

        Returns the two factory workers, whose ``ENTANGLEMENT_DONE`` signals
        mark the round complete.  Nothing is awaited here, so the caller
        decides whether to block (pre-fill) or fold the completion into a
        larger event expression (refill).

        Parameters
        ----------
        job : dict
            Descriptor from :meth:`_build_prefill_schedule` or
            :meth:`_build_refill_jobs`.
        bsm_label : str
            The BSM leased for this round.  Both sides must be armed for the
            same BSM, and it is the one the trigger message is sent to.

        Returns
        -------
        tuple
            ``(lo_worker, hi_worker)``
        """
        lo, hi = job["lo"], job["hi"]
        lo_factory = self.factory_by_qpu[lo]
        hi_factory = self.factory_by_qpu[hi]

        # Arm both endpoints with the same slot index so they agree on the
        # pair at consumption.  By convention (shared with the on-demand
        # path) the higher-numbered QPU applies the Pauli corrections.
        lo_worker = lo_factory.arm_prefill(
            peer_qpu_id=hi,
            job_id=job["job_id"],
            position=job["lo_position"],
            peer_position=job["hi_position"],
            apply_corrections=False,
            slot_id=job["slot"],
            bsm_label=bsm_label,
        )
        hi_worker = hi_factory.arm_prefill(
            peer_qpu_id=lo,
            job_id=job["job_id"],
            position=job["hi_position"],
            peer_position=job["lo_position"],
            apply_corrections=True,
            slot_id=job["slot"],
            bsm_label=bsm_label,
        )

        # Trigger the leased BSM on the factory plane.
        self.send_start_entanglement_to_bsm(
            {lo, hi}, start_label=job["job_id"], factory=True,
            bsm_label=bsm_label,
        )
        return lo_worker, hi_worker

    def _queue_generation_jobs(self, queue, jobs):
        """Enqueue *jobs*, restricting each to the BSMs serving its pairing."""
        for job in jobs:
            allowed = {
                label for _bsm_id, label in self.bsms_for_pair(
                    {job["lo"], job["hi"]}
                )
            }
            queue.add_request(
                qpu_left=f"QPU_{job['lo']}",
                qpu_right=f"QPU_{job['hi']}",
                allowed_bsms=allowed,
                payload=job,
            )

    def _run_factory_prefill(self):
        """Fill every EPR pool to capacity before circuit execution starts.

        This is a generalisation of the on-demand ``entanglement_gen`` flow:
        the controller triggers a BSM and both QPUs emit a photon.  The
        difference is that everything happens on the dedicated factory
        classical plane, so the circuit-execution workers are untouched, and
        the resulting pairs land in :class:`EPRPairPool` objects rather than
        the ``bell_pair_buffer``.

        Scheduling is delegated to :class:`EntanglementQueue`, which leases
        each BSM to at most one round and defers any job whose QPUs are
        already emitting.  Each batch it returns is therefore safe to run
        concurrently; the controller dispatches the whole batch and waits for
        all of it before asking for the next.
        """
        self._align_pools_with_circuit()
        schedule = self._build_prefill_schedule()

        if not schedule:
            log.info("[Controller] EPR factory pre-fill: nothing to schedule")
            return

        log.info(
            f"[Controller] EPR factory pre-fill: {len(schedule)} job(s) "
            f"starting at t={ns.sim_time()}"
        )

        queue = self._make_entanglement_queue()
        self._queue_generation_jobs(queue, schedule)

        done_signal = FactoryEntanglementWorker.ENTANGLEMENT_DONE
        generated = 0
        batches = 0

        while queue.has_pending():
            assignments = queue.get_next_assignments()
            if not assignments:
                # Nothing runnable and nothing active is a stall: the queue
                # only empties on conflicts with active rounds, and pre-fill
                # awaits each batch fully.
                log.error(
                    "[Controller] EPR pre-fill stalled: no runnable job and "
                    "no round in flight"
                )
                break

            wait_ev = None
            for req, bsm_label in assignments:
                lo_worker, hi_worker = self._dispatch_generation_job(
                    req.payload, bsm_label
                )
                round_ev = (
                    self.await_signal(lo_worker, done_signal)
                    & self.await_signal(hi_worker, done_signal)
                )
                wait_ev = round_ev if wait_ev is None else wait_ev & round_ev

            batches += 1
            log.debug(
                f"[Controller] Pre-fill batch {batches}: "
                f"{len(assignments)} round(s) in parallel on "
                f"{sorted(bsm for _r, bsm in assignments)}"
            )

            yield wait_ev

            for req, bsm_label in assignments:
                queue.complete_request(bsm_label)
                generated += 1
                log.debug(
                    f"[Controller] Pre-fill job {req.payload['job_id']} "
                    f"complete ({generated}/{len(schedule)}) at "
                    f"t={ns.sim_time()}"
                )

        pool_summary = {
            qpu_id: factory.stats["pool_sizes"]
            for qpu_id, factory in sorted(self.factory_by_qpu.items())
        }
        log.info(
            f"[Controller] EPR factory pre-fill complete at t={ns.sim_time()}: "
            f"{generated} round(s) in {batches} batch(es), pools={pool_summary}"
        )

    # ── Continuous refill ────────────────────────────────────────────────────

    def _refill_candidate_slots(self):
        """Slots that have drained and could be regenerated right now.

        A slot qualifies when neither endpoint still holds a half of it —
        both consumed their halves, so the pair is spent and its storage
        qubits are free again.  Refilling the *exact* vacated slot keeps the
        two sides' slot numbering identical by construction, which is what
        their no-negotiation agreement rests on.

        Slots with a round already in flight are excluded by the caller.

        Returns
        -------
        list[tuple[dict, int]]
            ``(pairing, slot)`` pairs, in deterministic order.
        """
        candidates = []
        for pairing in self._build_pool_pairings():
            lo_factory = self.factory_by_qpu.get(pairing["lo"])
            hi_factory = self.factory_by_qpu.get(pairing["hi"])
            if lo_factory is None or hi_factory is None:
                continue

            # A finished QPU stops emitting, so a round involving it could
            # never herald and would leave events queued forever.  Skip only
            # this pairing; others keep refilling.
            if (
                pairing["lo"] in self.finished_qpus
                or pairing["hi"] in self.finished_qpus
            ):
                continue


            for slot in range(pairing["num_slots"]):
                lo_holds = lo_factory.holds_slot(pairing["hi"], slot)
                hi_holds = hi_factory.holds_slot(pairing["lo"], slot)
                if lo_holds or hi_holds:
                    continue

                # Refill re-initialises the storage qubits, so the circuit
                # must have released them first.
                if (
                    pairing["lo_positions"][slot]
                    in lo_factory.qpu_protocol.occupied_comm_qubits
                    or pairing["hi_positions"][slot]
                    in hi_factory.qpu_protocol.occupied_comm_qubits
                ):
                    continue

                candidates.append((pairing, slot))
        return candidates

    def _dispatch_refill(self):
        """Start a generation round for every drained slot that can run now.

        Fire-and-forget: the controller must never block on refill, because
        while it waits it is not draining ``start_ready`` and the whole
        circuit stalls.  Completions are collected later by
        :meth:`_harvest_refill`, whose events the main loop folds into the
        expression it already waits on when idle.

        Returns
        -------
        int
            Number of rounds dispatched.
        """
        if not self.epr_factory_enabled or not self.factory_by_qpu:
            return 0


        queue = self._refill_queue
        if queue is None:
            return 0

        in_flight_slots = {
            (r["lo"], r["hi"], r["slot"]) for r in self._refill_in_flight.values()
        }

        # Candidates are recomputed from pool state each call, so drop stale
        # pending requests to keep the queue bounded.
        queue.clear_pending()

        jobs = []
        for pairing, slot in self._refill_candidate_slots():
            key = (pairing["lo"], pairing["hi"], slot)
            if key in in_flight_slots:
                continue
            generation = self._refill_generation.get(key, 0) + 1
            jobs.append(self._make_generation_job(pairing, slot, generation))

        if not jobs:
            return 0

        self._queue_generation_jobs(queue, jobs)
        assignments = queue.get_next_assignments()

        for req, bsm_label in assignments:
            job = req.payload
            # Halves stay invisible until both sides have them
            # (see EPRPairEntry.committed), so no partial consumption.
            job = dict(job, committed=False)
            lo_worker, hi_worker = self._dispatch_generation_job(job, bsm_label)
            self._refill_in_flight[job["job_id"]] = {
                "lo": job["lo"],
                "hi": job["hi"],
                "slot": job["slot"],
                "bsm_label": bsm_label,
                "lo_worker": lo_worker,
                "hi_worker": hi_worker,
                "lo_done": False,
                "hi_done": False,
                "started_ns": ns.sim_time(),
            }
            key = (job["lo"], job["hi"], job["slot"])
            self._refill_generation[key] = self._refill_generation.get(key, 0) + 1
            self._stats_refill_dispatched += 1
            log.debug(
                f"[Controller] Refill dispatched {job['job_id']} on {bsm_label} "
                f"at t={ns.sim_time()}"
            )

        return len(assignments)

    def _refill_wait_expression(self):
        """Event expression covering every refill round currently in flight.

        Returned for OR-ing into the controller's idle wait, so a refill
        completion wakes the loop just like a QPU message would.  ``None``
        when nothing is in flight.
        """
        ev = None
        done_signal = FactoryEntanglementWorker.ENTANGLEMENT_DONE
        for record in self._refill_in_flight.values():
            for side in ("lo", "hi"):
                if record[f"{side}_done"]:
                    continue
                worker_ev = self.await_signal(
                    record[f"{side}_worker"], done_signal
                )
                ev = worker_ev if ev is None else ev | worker_ev
        return ev

    def _harvest_refill(self):
        """Commit or discard refill rounds whose both halves have landed.

        A round only yields a usable pair when *both* endpoints succeeded.
        When they did, the two halves are committed together so they become
        selectable at the same instant on both sides.  When either failed,
        any surviving half is dropped: it is entangled with nothing, and
        leaving it would hand out a broken pair.

        Returns
        -------
        int
            Number of rounds completed (successfully or not).
        """
        if not self._refill_in_flight:
            return 0

        completed = 0
        for job_id, record in list(self._refill_in_flight.items()):
            lo_factory = self.factory_by_qpu.get(record["lo"])
            hi_factory = self.factory_by_qpu.get(record["hi"])
            if lo_factory is None or hi_factory is None:
                del self._refill_in_flight[job_id]
                continue

            lo_outcome = lo_factory.take_job_outcome(job_id)
            hi_outcome = hi_factory.take_job_outcome(job_id)
            if lo_outcome is not None:
                record["lo_done"] = True
                record["lo_success"] = lo_outcome
            if hi_outcome is not None:
                record["hi_done"] = True
                record["hi_success"] = hi_outcome

            if not (record["lo_done"] and record["hi_done"]):
                continue

            slot = record["slot"]
            both_ok = record.get("lo_success") and record.get("hi_success")

            if both_ok:
                lo_factory.commit_slot(record["hi"], slot)
                hi_factory.commit_slot(record["lo"], slot)
                self._stats_refill_succeeded += 1
                log.debug(
                    f"[Controller] Refill {job_id} committed at "
                    f"t={ns.sim_time()} "
                    f"({ns.sim_time() - record['started_ns']:.0f} ns)"
                )
            else:
                # Drop whichever half did land, so the slot reads as free
                # and becomes a refill candidate again.
                lo_factory.drop_slot(record["hi"], slot)
                hi_factory.drop_slot(record["lo"], slot)
                self._stats_refill_failed += 1
                log.debug(
                    f"[Controller] Refill {job_id} failed "
                    f"(lo={record.get('lo_success')}, "
                    f"hi={record.get('hi_success')}); slot {slot} released"
                )

            self._refill_queue.complete_request(record["bsm_label"])
            del self._refill_in_flight[job_id]
            completed += 1

        return completed

    def _service_refill(self):
        """Harvest finished refill rounds, then start whatever can run now.

        Called from the controller's main loop at every opportunity.  Both
        halves are non-blocking, so servicing refill never delays circuit
        dispatch.
        """
        if not self.epr_factory_enabled or self._refill_queue is None:
            return
        self._harvest_refill()
        self._dispatch_refill()

    # ── Main run loop ────────────────────────────────────────────────────────

    def run(self):
        log.debug(f"[{self.node.name}] Starting at time {ns.sim_time()}")

        circuit_cfg = getattr(self.cfg, 'circuit', None)

        if self._pre_labeled_commands is not None:
            # Fast path: the DQC plugin already parsed, validated, labeled.
            log.debug("[Controller] Using pre-labeled commands from DQC plugin")
            self.qpu_commands        = self._pre_labeled_commands
            self.start_qpus          = self._pre_process_maps['start_qpus']
            self.end_qpus            = self._pre_process_maps['end_qpus']
            self.entanglement_gen_labels = self._pre_process_maps['entanglement_gen_labels']
            self.start_ready = {k: set() for k in self.start_qpus}
            self.end_ready   = {k: set() for k in self.end_qpus}
            self.start_pool_ready = {}
        else:
            # ── Normal path: parse → validate → label ────────────────────────
            if self.frontend is not None:
                frontend = self.frontend
            else:
                frontend, _ = load_frontend(circuit_cfg)
            qpu_info = {
                i: {'num_qubits': qpu_node.qmemory.num_positions}
                for i, qpu_node in enumerate(self.qpu_nodes, start=1)
            }
            parsed = frontend.parse(qpu_info)

            # ── Validate parsed commands against the instruction-set registry ──
            from qnpack.dqc.models.validation import validate_commands
            validation_errors = validate_commands(parsed)
            if validation_errors:
                for ve in validation_errors:
                    if ve.severity == "error":
                        log.error(str(ve))
                    else:
                        log.warning(str(ve))
                hard_errors = [ve for ve in validation_errors if ve.severity == "error"]
                if hard_errors:
                    raise ValueError(
                        f"Circuit validation failed with {len(hard_errors)} error(s) "
                        f"(and {len(validation_errors) - len(hard_errors)} warning(s)). "
                        f"See log output above for details."
                    )

            for qpu_id, commands in parsed.items():
                self.qpu_commands[qpu_id] = commands

            # ── Label commands and build process maps ─────────────────────────
            labeled, process_maps = label_and_build_maps(self.qpu_commands)
            self.qpu_commands = labeled
            self.start_qpus              = process_maps['start_qpus']
            self.end_qpus                = process_maps['end_qpus']
            self.entanglement_gen_labels = process_maps['entanglement_gen_labels']
            self.start_ready = {k: set() for k in self.start_qpus}
            self.end_ready   = {k: set() for k in self.end_qpus}
            self.start_pool_ready = {}

        if getattr(self.cfg.circuit, 'pre_schedule_entanglement', False):
            expected_latency = getattr(
                self.cfg.circuit, 'expected_ent_latency_ns', 0
            )
            stats = insert_pre_entanglement_commands(
                self.qpu_commands,
                expected_ent_latency_ns=expected_latency,
            )
            self._print_pre_ent_summary(stats)

        self.active_qpu_ids = set(self.qpu_commands.keys())
        self.num_active_qpus = len(self.active_qpu_ids)
        log.debug(
            f"[Controller] Active QPUs (have commands): {self.active_qpu_ids} "
            f"({self.num_active_qpus}/{self.num_qpus} total)"
        )

        # ── EPR Factory pre-fill ───────────────────────────────────────────
        # Fill every pool to capacity before dispatching circuit commands so
        # entanglement_gen can consume a ready-made pair.
        if self.epr_factory_enabled and self.factory_by_qpu:
            yield from self._run_factory_prefill()
            # Pre-fill is one-shot and covers only pool_size x pairings
            # operations; the refill queue regenerates drained slots for the
            # rest of the run.
            self._refill_queue = self._make_entanglement_queue()

        if self.run_idx == 0:
            with open("qpu_partitioned_commands.json", "w") as f:
                json.dump(self.qpu_commands, f, indent=2)
            log.debug("Saved all QPU commands to qpu_partitioned_commands.json")

            schedule = self.compute_timeslot_schedule(
                self.qpu_commands, self.mapping_list
            )
            self.print_timeslot_schedule(schedule, self.mapping_list)

        for qpu_id, commands in self.qpu_commands.items():
            self.send_commands_to_qpu(qpu_id, commands)

        log.debug(">>> Starting execution <<<")

        while (
            self.start_qpus
            or self.end_qpus
            or len(self.finished_qpus) < self.num_active_qpus
        ):
            log.debug(
                f"[Controller] Loop top: finished={self.finished_qpus}, "
                f"need={self.num_active_qpus}, waiting={self.waiting_qpus}"
            )

            # Harvest completed refill rounds and start new ones.  Both are
            # non-blocking, so this never delays circuit dispatch.
            self._service_refill()

            # Drain all buffered messages
            found_buffered = True
            while found_buffered:
                found_buffered = False
                for qpu_id in self.active_qpu_ids:
                    port_name = f"comm{qpu_id}_port"
                    if port_name in self.node.ports:
                        while True:
                            msg = self.node.ports[port_name].rx_input()
                            if msg is None:
                                break
                            self.process_ready_message(msg)
                            found_buffered = True

            if (
                not self.start_qpus
                and not self.end_qpus
                and len(self.finished_qpus) >= self.num_active_qpus
            ):
                break

            is_start, label = self.get_next_ready_process()

            if is_start is not None:
                if is_start:
                    qpus_involved = self.start_qpus[label]

                    bsm_entry = self.default_bsm_for_pair(qpus_involved)
                    bsm_label = bsm_entry[1] if bsm_entry else None

                    needs_bsm = label in self.entanglement_gen_labels

                    # Skip the BSM round only if every party holds a usable
                    # pair; a partial hit leaves one side entangled with
                    # nothing.
                    pool_voters = self.start_pool_ready.get(label, set())
                    use_pool = needs_bsm and qpus_involved <= pool_voters

                    # Name the slot both sides take; independent choices
                    # desync under continuous refill (see choose_pool_slot).
                    pool_slot = (
                        self.choose_pool_slot(qpus_involved) if use_pool
                        else None
                    )
                    if use_pool and pool_slot is None:
                        # Both sides have a usable pair but no common slot
                        # (mid-flight refill); fall back rather than consume
                        # mismatched halves.
                        log.debug(
                            f"[Controller] {label}: no slot usable on both "
                            f"sides; falling back to on-demand"
                        )
                        use_pool = False

                    if use_pool:
                        needs_bsm = False

                    # Take the BSM before ticking the QPUs into emission.
                    # Waiting out a refill round's short detector window is
                    # cheap; overlapping rounds hang both sides.
                    while needs_bsm and not self._acquire_ondemand_bsm(
                        bsm_label, qpus_involved
                    ):
                        refill_ev = self._refill_wait_expression()
                        if refill_ev is None:
                            # Nothing in flight to wait for — the lease is
                            # not a refill one, so proceed rather than spin.
                            break
                        log.debug(
                            f"[Controller] {label} waiting for refill to "
                            f"release {bsm_label}"
                        )
                        yield refill_ev
                        self._harvest_refill()

                    label_type = (
                        "entanglement_gen" if needs_bsm
                        else ("entanglement_gen[pool]" if use_pool
                              else "starting_process")
                    )
                    log.debug(
                        f">>> Executing {label_type} {label} with "
                        f"QPUs {qpus_involved}, BSM={bsm_label} <<<"
                    )

                    yield from self.send_clock_tick_to_all(
                        qpus_involved, start_label=label, bsm_label=bsm_label,
                        use_pool=use_pool, pool_slot=pool_slot,
                    )
                    for qpu_id in qpus_involved:
                        self.waiting_qpus.discard(qpu_id)

                    if needs_bsm:
                        self.send_start_entanglement_to_bsm(
                            qpus_involved, start_label=label
                        )

                    self.start_ready[label] = set()
                    self.start_pool_ready.pop(label, None)
                    del self.start_qpus[label]
                else:
                    qpus_involved = self.end_qpus[label]
                    log.debug(
                        f">>> Executing ending_process {label} with "
                        f"QPUs {qpus_involved} <<<"
                    )

                    yield from self.send_clock_tick_to_all(
                        qpus_involved, end_label=label
                    )
                    for qpu_id in qpus_involved:
                        self.waiting_qpus.discard(qpu_id)

                    self.end_ready[label] = set()
                    del self.end_qpus[label]

                continue

            # No ready process — wait for QPU messages
            log.debug(
                f"[Controller] No ready process. "
                f"finished={len(self.finished_qpus)}/{self.num_active_qpus} "
                f"start_qpus={list(self.start_qpus.keys())[:10]}, "
                f"start_ready={dict((k, v) for k, v in self.start_ready.items() if v)}"
            )
            ev_expr = None
            for qpu_id in self.active_qpu_ids:
                port_name = f"comm{qpu_id}_port"
                if port_name in self.node.ports:
                    port = self.node.ports[port_name]
                    ev_expr = (
                        self.await_port_input(port)
                        if ev_expr is None
                        else ev_expr | self.await_port_input(port)
                    )

            # Fold refill completions into the same wait, otherwise a
            # finished round sits unharvested while every QPU blocks on it.
            refill_ev = self._refill_wait_expression()
            if refill_ev is not None:
                ev_expr = refill_ev if ev_expr is None else ev_expr | refill_ev

            if ev_expr is None:
                log.error(
                    "[Controller] Nothing to wait on and no ready process — "
                    "aborting to avoid a hang"
                )
                break

            yield ev_expr
            log.debug(f"[Controller] Woke up at time={ns.sim_time()}")

            self._service_refill()

            drain_round = 0
            while True:
                any_found = False
                for qpu_id in self.active_qpu_ids:
                    port_name = f"comm{qpu_id}_port"
                    if port_name in self.node.ports:
                        while True:
                            msg = self.node.ports[port_name].rx_input()
                            if msg is None:
                                break
                            result = self.process_ready_message(msg)
                            log.debug(
                                f"[Controller] Drained from {port_name}: {result}"
                            )
                            any_found = True
                drain_round += 1
                if not any_found:
                    break
            log.debug(
                f"[Controller] After drain: drain_rounds={drain_round}"
            )

        if self.clk.is_running:
            self.clk.stop()

        if self.epr_factory_enabled and self._stats_refill_dispatched:
            log.info(
                f"[Controller] EPR refill: {self._stats_refill_dispatched} "
                f"round(s) dispatched, {self._stats_refill_succeeded} "
                f"committed, {self._stats_refill_failed} failed"
            )

        log.debug(f"[{self.node.name}] All QPUs done at {ns.sim_time()}")
        self.send_signal(Signals.SUCCESS)
