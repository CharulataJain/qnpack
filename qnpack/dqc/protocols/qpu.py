"""
protocols/qpu.py
----------------
QPU-side protocols for the DQC simulation.

Classes
-------
    IDQCEmit                    — Custom emit instruction (creates entangled pair)
    DQCEmitProgram              — QuantumProgram wrapper for IDQCEmit
    EntanglementWorkerProtocol  — Persistent per-BSM Bell-pair generator
    QPUProtocol                 — Main QPU execution protocol
"""

import math
import random
import logging

import netsquid as ns
from netsquid.protocols.nodeprotocols import NodeProtocol
from netsquid.components.component import Message
from netsquid.protocols.protocol import Signals
from netsquid.components.instructions import (
    INSTR_INIT,
    INSTR_ROT_Z,
    INSTR_ROT_X,
    INSTR_ROT_Y,
    INSTR_H,
    INSTR_CNOT,
    INSTR_X,
    INSTR_Y,
    INSTR_Z,
    INSTR_MEASURE,
    INSTR_TOFFOLI,
    IInit,
    Instruction,
)
from netsquid.qubits import qubitapi as qapi
from netsquid.qubits import operators as ops
from netsquid.qubits.stabtools import StabRepr
from netsquid.components.qprogram import QuantumProgram

from qnpack.dqc.models.instruction_set import GATE_OPS
from qnpack.dqc.frontends.util import COMM_REGION_SIZE, DATA_REGION_START

log = logging.getLogger(__name__)


def _is_stabilizer_formalism():
    """Return True when the active NetSquid formalism is stabilizer (STAB)."""
    try:
        return ns.get_qstate_formalism() is StabRepr
    except Exception:
        return False

# BSM detector output values that indicate successful Bell measurement
BSM_SUCCESS = [[2], [3]]

# --- Global Timing Variables ---
ENTANGLEMENT_DURATION = 0
MAX_ENTANGLEMENT_TIME = 0
EXECUTION_DURATION = 0
MAX_EXECUTION_TIME = 0
ENTANGLEMENT_START_TIME = 0
ENTANGLEMENT_END_TIME = 0
EXECUTION_START_TIME = 0
EXECUTION_END_TIME = 0
SYNC_PROCESS_DURATION = 0
MAX_SYNC_PROCESS_TIME = 0
SYNC_START_TIME = 0
SYNC_END_TIME = 0


# ---------------------------------------------------------------------------
# Custom emit instruction
# ---------------------------------------------------------------------------

class IDQCEmit(Instruction):
    """Custom emit instruction for DQC that always creates an entangled pair."""

    @property
    def name(self):
        return "dqc_emit_ent_qubit"

    @property
    def num_positions(self):
        return 2

    def execute(self, quantum_memory, positions, *args, **kwargs):
        emitter_position = positions[0]
        [memory_qubit] = quantum_memory.peek(emitter_position)
        [emission_qubit] = qapi.create_qubits(1)
        qapi.operate(memory_qubit, ops.H)
        qapi.operate([memory_qubit, emission_qubit], ops.CNOT)
        quantum_memory.ports[f"qout{emitter_position}"].tx_output(emission_qubit)


DQC_EMIT = IDQCEmit()


class DQCEmitProgram(QuantumProgram):
    """QuantumProgram wrapper that applies :data:`DQC_EMIT`."""

    default_num_qubits = 2

    def program(self):
        memory_position, emission_position = self.get_qubit_indices()
        self.apply(
            instruction=DQC_EMIT,
            qubit_indices=[memory_position, emission_position],
        )
        yield self.run()


# ---------------------------------------------------------------------------
# Entanglement worker
# ---------------------------------------------------------------------------

class EntanglementWorkerProtocol(NodeProtocol):
    """Persistent sub-protocol that generates Bell pairs sequentially.

    A single instance is created per BSM channel and processes all
    pre-entanglement requests from a work queue.  This avoids the
    overhead of creating/destroying many sub-protocol instances and
    eliminates event-handler explosion from concurrent waiters on
    the same BSM clock port.

    Uses ``qapi`` direct qubit operations instead of ``execute_instruction``
    / ``execute_program`` to avoid ``ProcessorBusyError``.

    Parameters
    ----------
    node : Node
        The QPU node (shared with QPUProtocol).
    qpu_protocol : QPUProtocol
        Reference to the parent protocol (for shared state access).
    bsm_label : str
        BSM label for routing the photon.
    name : str or None
        Protocol name (auto-generated if None).
    """

    ENTANGLEMENT_DONE = "ENTANGLEMENT_DONE"
    NEW_WORK = "NEW_WORK"

    def __init__(self, node, qpu_protocol, bsm_label, name=None):
        if name is None:
            name = f"EntWorker_{node.name}_{bsm_label}"
        super().__init__(node, name=name)
        self.qpu_protocol = qpu_protocol
        self.bsm_label = bsm_label
        self._work_queue = []
        self.add_signal(self.ENTANGLEMENT_DONE)
        self.add_signal(self.NEW_WORK)

        self._one_q_gate_duration = float(
            qpu_protocol.cfg.gate_durations.one_q_gate_duration
        )
        self._one_q_depolar_prob = float(
            qpu_protocol.cfg.qpu.one_q_depolar_prob
        )

    def add_work(self, target_start_label, cmd):
        """Add a pre-gen request to the work queue."""
        self._work_queue.append((target_start_label, cmd))
        self.send_signal(self.NEW_WORK)

    def _init_qubit(self, position):
        """Re-initialize a qubit to |0⟩ using qapi (no processor lock)."""
        [qubit] = self.node.qmemory.peek(position)
        if qubit is not None:
            qapi.assign_qstate([qubit], ns.qubits.ketstates.s0)
        else:
            [qubit] = qapi.create_qubits(1)
            self.node.qmemory.put(qubit, positions=[position])

    def _emit_photon(self, position):
        """Create a Bell pair between memory qubit and a fresh photon."""
        [memory_qubit] = self.node.qmemory.peek(position)
        [emission_qubit] = qapi.create_qubits(1)

        qapi.operate(memory_qubit, ops.H)
        qapi.operate([memory_qubit, emission_qubit], ops.CNOT)

        emission_fidelity = self.qpu_protocol.cfg.qpu.emission_fidelity
        if emission_fidelity < 1.0:
            self._apply_emission_noise(memory_qubit, emission_qubit, emission_fidelity)

        collection_efficiency = self.qpu_protocol.cfg.qpu.collection_efficiency
        if collection_efficiency < 1.0:
            if random.random() > collection_efficiency:
                log.debug(
                    f"[{self.node.name}|Worker] Photon lost due to "
                    f"collection efficiency ({collection_efficiency})"
                )
                qapi.discard(emission_qubit)
                qapi.assign_qstate([memory_qubit], ns.qubits.ketstates.s0)
                return False

        qout_port = self.node.qmemory.ports.get(f"qout{position}")
        if qout_port is None:
            qout_port = self.node.qmemory.ports.get("qout")
        if qout_port is None:
            log.error(
                f"[{self.node.name}|Worker] No qout port for position {position}"
            )
            qapi.discard(emission_qubit)
            return False

        qout_port.tx_output(emission_qubit)
        return True

    def _apply_emission_noise(self, matter_qubit, photon_qubit, fidelity):
        """Apply depolarizing noise to simulate emission fidelity."""
        depol_prob = 4 / 3 * (1 - fidelity)
        qapi.depolarize(photon_qubit, depol_prob)

    def _apply_correction(self, position, gate_op):
        """Apply a single-qubit correction gate using qapi.

        Adds a timing delay matching ``one_q_gate_duration`` so that
        T1/T2 memory decoherence accumulates correctly, and manually
        applies depolarising noise matching ``one_q_depolar_prob``.
        """
        [qubit] = self.node.qmemory.peek(position)
        qapi.operate(qubit, gate_op)

        if self._one_q_gate_duration > 0:
            yield self.await_timer(duration=self._one_q_gate_duration)

        if self._one_q_depolar_prob > 0:
            r = random.random()
            p = self._one_q_depolar_prob
            if r < p:
                pauli_r = random.random()
                if pauli_r < 1.0 / 3.0:
                    qapi.operate(qubit, ops.X)
                elif pauli_r < 2.0 / 3.0:
                    qapi.operate(qubit, ops.Y)
                else:
                    qapi.operate(qubit, ops.Z)

    def _drain_stale_bsm_results(self, bsm_res_port):
        """Drain any stale BSM result messages left in the port buffer."""
        drained = 0
        while True:
            stale = bsm_res_port.rx_input()
            if stale is None:
                break
            drained += 1
        return drained

    def run(self):
        """Process pre-gen requests sequentially from the work queue."""
        parent = self.qpu_protocol
        bsm_label = self.bsm_label

        bsm_clk_port_name = f"clk_from_{bsm_label}"
        bsm_res_port_name = f"bsm_res_from_{bsm_label}"
        bsm_clk_port = self.node.ports.get(bsm_clk_port_name)
        bsm_res_port = self.node.ports.get(bsm_res_port_name)

        if bsm_clk_port is None or bsm_res_port is None:
            log.error(
                f"[{self.node.name}|Worker] Cannot find BSM ports for {bsm_label}"
            )
            return

        max_retries = parent.cfg.bsm.max_emission_retries
        retry_duration = parent.cfg.bsm.retry_duration

        while True:
            while not self._work_queue:
                yield self.await_signal(self, self.NEW_WORK)

            target_start_label, cmd = self._work_queue.pop(0)
            ent_label = cmd['entanglement_label']

            if cmd.get('l_local') is not None:
                l_local = cmd['l_local']
                is_link_side = False
                data_qubit = cmd.get('data_qubit')
                exclude = {data_qubit} if data_qubit is not None else set()
            else:
                l_local = cmd['qubits'][0]
                is_link_side = True
                exclude = set()

            actual_emit = parent.find_free_comm_qubit(l_local, exclude=exclude)

            log.debug(
                f"[{self.node.name}|Worker] Generating entanglement for "
                f"start_label={target_start_label} on qubit {actual_emit} "
                f"(bsm={bsm_label}, link_side={is_link_side})"
            )

            self._drain_stale_bsm_results(bsm_res_port)
            parent._forward_qout_to_bsm(bsm_label, actual_emit)

            yield self.await_port_input(bsm_clk_port)
            bsm_clk_port.rx_input()

            self._drain_stale_bsm_results(bsm_res_port)

            ent_start_time = parent.entanglement_timing.request_time_ns(ent_label)
            retries = 0
            success = False
            bsm_data = None

            while retries <= max_retries:
                if retries > 0:
                    yield self.await_port_input(bsm_clk_port)
                    bsm_clk_port.rx_input()
                    self._drain_stale_bsm_results(bsm_res_port)

                self._init_qubit(actual_emit)

                if retries != 0 and retry_duration > 0:
                    yield self.await_timer(duration=retry_duration)

                parent._forward_qout_to_bsm(bsm_label, actual_emit)
                emit_ok = self._emit_photon(actual_emit)
                if not emit_ok:
                    retries += 1
                    continue

                yield self.await_port_input(bsm_res_port)
                res = bsm_res_port.rx_input()

                if res is None or not res.items:
                    retries += 1
                    continue

                item = res.items[0] if isinstance(res.items, list) else res.items
                if isinstance(item, dict):
                    bsm_data = item.get('data')
                else:
                    bsm_data = item

                if bsm_data in BSM_SUCCESS:
                    success = True
                    break
                else:
                    retries += 1

            if success:
                role = cmd.get('role')
                apply_corrections = is_link_side if role is None else (role == 'peer')
                if apply_corrections and bsm_data is not None:
                    if _is_stabilizer_formalism():
                        # STAB: corrections must match the BSM circuit the
                        # detector used, selected by bsm.deterministic_bsm.
                        if self.qpu_protocol.cfg.bsm.deterministic_bsm:
                            # CNOT+H+Z-measure BSM:
                            #   [2] = m2=0 → no correction
                            #   [3] = m2=1 → X correction
                            if bsm_data == [3]:
                                yield from self._apply_correction(actual_emit, ops.X)
                        else:
                            # Pauli-measurement BSM leaves XZ/ZX stabilizers
                            # rather than XX/ZZ, so H restores the basis first:
                            #   [2] = m1=0, m2=0 → H
                            #   [3] = m1=0, m2=1 → H then X
                            yield from self._apply_correction(actual_emit, ops.H)
                            if bsm_data == [3]:
                                yield from self._apply_correction(actual_emit, ops.X)
                    else:
                        # KET: create_meas_ops() POVM outcomes.
                        #   [2] = success, X correction
                        #   [3] = success, X and Z correction
                        if bsm_data == [2] or bsm_data == [3]:
                            yield from self._apply_correction(actual_emit, ops.X)
                        if bsm_data == [3]:
                            yield from self._apply_correction(actual_emit, ops.Z)

                parent.occupied_comm_qubits.add(actual_emit)
                parent.entanglement_timing.endpoint_ready(
                    ent_label, parent.qpu_id, ns.sim_time()
                )
                log.debug(
                    f"[{self.node.name}|Worker] Entanglement SUCCESS for "
                    f"start_label={target_start_label}: actual_emit={actual_emit}, "
                    f"retries={retries}, bsm_data={bsm_data}"
                )
            else:
                log.warning(
                    f"[{self.node.name}|Worker] Entanglement FAILED for "
                    f"start_label={target_start_label} after {retries} retries"
                )

            ent_end_time = ns.sim_time()
            ent_duration_ns = ent_end_time - ent_start_time

            parent.bell_pair_buffer[target_start_label] = {
                'success': success,
                'bsm_data': bsm_data,
                'retries': retries,
                'actual_emit': actual_emit,
                'ent_duration_ns': ent_duration_ns,
                'generation_time': ent_end_time if success else ns.sim_time(),
            }

            self.send_signal(self.ENTANGLEMENT_DONE, result=target_start_label)


# ---------------------------------------------------------------------------
# QPU protocol
# ---------------------------------------------------------------------------

class QPUProtocol(NodeProtocol):
    """Protocol running on a QPU node.

    Entanglement is generated via persistent :class:`EntanglementWorkerProtocol`
    instances (one per BSM channel).  When the main ``run()`` loop reaches
    a ``starting_process`` or ``starting_process_link`` command, it submits
    work to the appropriate worker and blocks until the Bell pair is ready
    in ``bell_pair_buffer``.

    Parameters
    ----------
    cfg : Munch
        Simulation configuration.
    node : Node
        The QPU node this protocol runs on.
    qpu_id : int
        1-based QPU index.
    name : str or None
        Protocol name (auto-generated if None).
    """

    def __init__(self, cfg, node, qpu_id, qpu_label=None, q_switch=None, bsm_info=None, name=None):
        super().__init__(node, name=name)
        self.cfg = cfg
        self.qpu_id = qpu_id
        self.qpu_label = qpu_label   # topology label (e.g. 'LBNL-A'), used by switch
        self.q_switch = q_switch     # FullMeshOpticalSwitch or None
        self.bsm_info = bsm_info or {}  # bsm_label -> {left_qpu, right_qpu, ...}
        self.qpu = node.subcomponents.get("QPU")
        self.pre_schedule_entanglement = cfg.circuit.pre_schedule_entanglement
        self.ctrl_port = self.node.ports["ctrl_port"]
        self.clk_port = self.node.ports["clk_port"]
        self.comm_port = self.node.ports["comm_port"]
        self.commands = []

        self.occupied_comm_qubits: set = set()

        # Memory layout constants shared with ..frontends.util; the topology
        # decides how many positions exist, these only mark region starts.
        self.NUM_COMM_QUBITS = COMM_REGION_SIZE
        self.FIRST_DATA_QUBIT = DATA_REGION_START
        self._pending_msg_exchange: dict = {}
        self._pending_classical_msgs: dict = {}
        self.classical_memory: dict = {}
        self.final_measurements = {}

        self.bell_pair_buffer: dict = {}
        self.global_entanglement_durations = None
        self.entanglement_timing = None

        # Persistent BSM workers: bsm_label -> EntanglementWorkerProtocol (or SwitchedEntanglementWorker)
        self._bsm_workers: dict = {}

        self.epr_factory = None  # Set by DQCProtocol when factory is configured
        # Pool-only execution (set by DQCProtocol): always serve remote ops
        # from the pool, waiting for refill instead of an on-demand round.
        self.pool_only = cfg.epr_factory.pool_only
        self.pool_drain_timeout_ns = cfg.epr_factory.drain_timeout_ns
        # Pool starvation diagnostics: wait count and total wait time.
        self.pool_starvation_events = 0
        self.pool_starvation_ns = 0.0

        # ── Communication-qubit remapping ────────────────────────────────
        # {compiler_position: actual_position}.  A pooled pair may sit on a
        # different comm qubit than the compiler nominated; the redirect
        # holds for the lifetime of the pair and is cleared on release.
        # Only the link side of a pair resolves through this table.
        self._comm_remap: dict = {}

    # ── Worker management ────────────────────────────────────────────────────

    def _get_or_create_bsm_worker(self, bsm_label):
        """Return the persistent worker for *bsm_label*, creating it if needed.

        When a ``FullMeshOpticalSwitch`` is present (``self.q_switch`` is not
        ``None``), a :class:`~qnpack.dqc.protocols.switch.SwitchedEntanglementWorker`
        is created instead of the base
        :class:`~qnpack.dqc.protocols.qpu.EntanglementWorkerProtocol`.
        The switched worker configures the optical switch route before each
        photon emission and reads BSM results / clock ticks from the switch
        output ports on the QPU node.
        """
        if bsm_label not in self._bsm_workers:
            if self.q_switch is not None:
                from qnpack.dqc.protocols.switch import SwitchedEntanglementWorker
                # Determine if this QPU is the left or right side for this BSM
                bsm_inf = self.bsm_info.get(bsm_label, {})
                bsm_side = "left" if bsm_inf.get("left_qpu") == self.qpu_label else "right"
                worker = SwitchedEntanglementWorker(
                    node=self.node,
                    qpu_protocol=self,
                    bsm_label=bsm_label,
                    qpu_label=self.qpu_label,
                    q_switch=self.q_switch,
                    bsm_side=bsm_side,
                )
                log.debug(
                    f"[{self.node.name}] Created SwitchedEntanglementWorker "
                    f"for BSM {bsm_label} (qpu_label={self.qpu_label}, side={bsm_side})"
                )
            else:
                worker = EntanglementWorkerProtocol(
                    node=self.node,
                    qpu_protocol=self,
                    bsm_label=bsm_label,
                )
                log.debug(
                    f"[{self.node.name}] Created EntanglementWorkerProtocol "
                    f"for BSM {bsm_label}"
                )
            self._bsm_workers[bsm_label] = worker
            worker.start()
        return self._bsm_workers[bsm_label]

    # ── Communication-qubit remapping ────────────────────────────────────────

    def _resolve_comm(self, pos):
        """Translate a compiler-nominated comm position to the physical one.

        Returns *pos* unchanged when no pooled pair has redirected it, so
        this is safe to apply unconditionally at every comm-qubit use site.

        Parameters
        ----------
        pos : int or None
            Position as written by the compiler.

        Returns
        -------
        int or None
        """
        if pos is None or not self._comm_remap:
            return pos
        return self._comm_remap.get(pos, pos)

    def _resolve_comm_list(self, qubits):
        """Apply :meth:`_resolve_comm` to every comm position in a list.

        Data qubits (>= ``FIRST_DATA_QUBIT``) are never remapped.
        """
        if not self._comm_remap or not qubits:
            return qubits
        return [
            self._resolve_comm(q)
            if isinstance(q, int) and q < self.NUM_COMM_QUBITS else q
            for q in qubits
        ]

    def _register_comm_remap(self, compiler_pos, actual_pos):
        """Redirect *compiler_pos* to *actual_pos* until the pair is released.

        Returns ``True`` when the redirect is now in force.

        A mapping is refused while an earlier pair still occupies
        *compiler_pos*.  Callers treat refusal as "cannot serve this request
        from the pool" and fall back to on-demand generation.

        Rebinding instead of refusing was tried, on the §3.1 argument that a
        live entry is always held by a *data*-side episode, which takes its
        physical qubit from ``actual_emit`` rather than from this table.
        That argument is incomplete: the data side does not resolve its
        *gate* operands here, but it does resolve ``free_comm_qubit`` when
        releasing (see :meth:`handle_msg_sender`).  Overwriting the entry
        therefore makes the release free the wrong physical qubit and leak
        the right one — measured as 4 pool slots pinned per QPU on
        ``grover_4_2qpu``, whose peak concurrency is 2, which then presents
        as pool exhaustion.

        Lifting this restriction needs the release path to carry the
        physical position it consumed, rather than re-deriving it from a
        table that may have moved on.
        """
        if compiler_pos is None or actual_pos is None:
            return False
        if compiler_pos == actual_pos:
            # Pool landed on the nominated qubit; drop stale entries so the
            # position resolves to itself.
            self._comm_remap.pop(compiler_pos, None)
            return True
        existing = self._comm_remap.get(compiler_pos)
        if existing is not None and existing != actual_pos:
            log.debug(
                f"[{self.node.name}] comm remap refused: {compiler_pos} is "
                f"still redirected to {existing}"
            )
            return False
        self._comm_remap[compiler_pos] = actual_pos
        log.debug(
            f"[{self.node.name}] comm remap: compiler position {compiler_pos} "
            f"-> pooled qubit {actual_pos}"
        )
        return True

    def _record_pool_consumption(self, ent_label, peer_qpu_id, pair):
        """Cross-check that both QPUs consumed two halves of the same pair.

        The two sides never negotiate: each picks the lowest available
        ``slot_id`` from its own pool and trusts that the peer's rule
        selected the counterpart.  That holds as long as both pools were
        filled by the same schedule and drained the same number of times.

        This verifies the assumption rather than relying on it.  The first
        QPU to reach a label publishes what it took; the second compares.
        A genuine pair satisfies two conditions:

        - identical ``slot_id`` — they came from the same pre-fill round
        - crossed positions — each side's ``comm_qubit_remote`` names the
          other's ``comm_qubit_local``

        A mismatch means the pools have desynchronised, which otherwise
        surfaces only as wrong measurement outcomes much later.  This is a
        diagnostic, not a recovery path: it logs loudly and leaves execution
        untouched.
        """
        factory = self.epr_factory
        if factory is None:
            return

        registry = getattr(factory, 'shared_consumption_log', None)
        if registry is None:
            return

        record = {
            'qpu_id': self.qpu_id,
            'slot_id': pair.slot_id,
            'local': pair.comm_qubit_local,
            'remote': pair.comm_qubit_remote,
        }
        key = (ent_label, frozenset({self.qpu_id, peer_qpu_id}))
        other = registry.get(key)
        if other is None:
            registry[key] = record
            return

        del registry[key]
        crossed = (
            other['local'] == record['remote']
            and other['remote'] == record['local']
        )
        if other['slot_id'] != record['slot_id'] or not crossed:
            log.error(
                f"[{self.node.name}] POOL DESYNC on label={ent_label}: "
                f"QPU_{record['qpu_id']} took slot={record['slot_id']} "
                f"(local={record['local']}, remote={record['remote']}) but "
                f"QPU_{other['qpu_id']} took slot={other['slot_id']} "
                f"(local={other['local']}, remote={other['remote']})"
            )

    def _refill_can_progress(self, peer_qpu_id):
        """Whether waiting for a refilled pair could ever succeed.

        A slot can only be regenerated once the QPUs holding its storage
        qubit have released it.  If every slot for this pairing is pinned by
        eJPP episodes that are still live, no slot can be rebuilt until one
        of those QPUs advances — and a QPU about to block here is waiting for
        precisely the pair that would let it advance.

        Both endpoints are inspected, because the deadlock is usually
        *mutual*: on ``grover_4_2qpu`` with eight slots, each QPU ends up
        holding four and waiting on the four its partner holds.  Checking
        only the local side misses that entirely and the run burns down to
        the timeout instead.

        This is a depth shortfall, not a scheduling fault — the circuit
        holds more pairs concurrently than the pool can store — so it is
        worth reporting as the configuration problem it is.
        """
        factory = self.epr_factory
        pool = factory.get_pool(peer_qpu_id) if factory is not None else None
        if pool is None:
            return False

        cfg = factory.peer_configs.get(peer_qpu_id) or {}
        storage = set(cfg.get("comm_positions") or ())
        if not storage:
            return False

        # Storage qubits still in occupied_comm_qubits back consumed pairs
        # that have not been measured out yet.
        pinned = storage & self.occupied_comm_qubits

        peer_proto = getattr(factory, 'peer_qpu_protocols', {}).get(peer_qpu_id)
        if peer_proto is not None:
            peer_cfg = (
                peer_proto.epr_factory.peer_configs.get(self.qpu_id) or {}
                if peer_proto.epr_factory is not None else {}
            )
            peer_storage = set(peer_cfg.get("comm_positions") or ())
            # Slot i uses the i-th position on each side, so it is unusable
            # if either endpoint still pins its qubit.
            local_order = sorted(storage)
            peer_order = sorted(peer_storage)
            for idx, pos in enumerate(local_order):
                if idx < len(peer_order) and (
                    peer_order[idx] in peer_proto.occupied_comm_qubits
                ):
                    pinned.add(pos)

        return len(pinned) < len(storage)

    def _await_pooled_pair(self, peer_qpu_id, ent_label):
        """Wait until a usable pooled pair exists for *peer_qpu_id*.

        In pool-only mode there is no fallback: when the pool is dry the QPU
        blocks here until continuous refill delivers.  This is deadlock-free
        *provided refill can still make progress* — QPUs block individually
        while the controller stays live and keeps servicing refill.  When
        even that is impossible the wait is refused immediately rather than
        burned down to the timeout.

        The wait is otherwise bounded.  On timeout the run fails loudly
        instead of hanging, so a scheduling bug stays diagnosable.

        Returns
        -------
        bool
            ``True`` when a pair became available.  ``False`` when waiting
            is futile or the bound elapsed, leaving the caller to fail.
        """
        factory = self.epr_factory
        if factory is None:
            return False
        if factory.has_usable_pair(peer_qpu_id, ns.sim_time()):
            return True

        if not self._refill_can_progress(peer_qpu_id):
            cfg = factory.peer_configs.get(peer_qpu_id) or {}
            depth = len(cfg.get("comm_positions") or ())
            log.warning(
                f"[{self.node.name}] POOL TOO SHALLOW for peer=QPU_{peer_qpu_id} "
                f"at {ent_label}: all {depth} pool slot(s) are pinned by eJPP "
                f"episodes that are still live, so none can be refilled until "
                f"one of them finishes — which cannot happen while this QPU "
                f"waits here. The circuit holds more pairs concurrently than "
                f"the pool can store; raise epr_factory.pool_size_per_pair "
                f"(and comm_qubits_reserved) above the circuit's peak "
                f"concurrency. Serving this operation on demand instead."
            )
            return False

        started = ns.sim_time()
        deadline = started + self.pool_drain_timeout_ns
        self.pool_starvation_events += 1

        log.debug(
            f"[{self.node.name}] Pool empty for peer=QPU_{peer_qpu_id} "
            f"(label={ent_label}); waiting for refill"
        )

        while not factory.has_usable_pair(peer_qpu_id, ns.sim_time()):
            remaining = deadline - ns.sim_time()
            if remaining <= 0:
                waited = ns.sim_time() - started
                self.pool_starvation_ns += waited
                log.error(
                    f"[{self.node.name}] POOL STARVATION TIMEOUT: waited "
                    f"{waited:.0f} ns for a pair with QPU_{peer_qpu_id} "
                    f"(label={ent_label}) and none arrived. Refill cannot "
                    f"keep up with demand, or a refill round is stuck. "
                    f"Serving this operation on demand instead."
                )
                return False

            yield (
                self.await_signal(
                    factory, factory.PAIR_GENERATED
                ) | self.await_timer(duration=remaining)
            )

        waited = ns.sim_time() - started
        self.pool_starvation_ns += waited
        # Demand outran regeneration: pool too shallow or BSMs saturated.
        log.warning(
            f"[{self.node.name}] Pool starved for {waited:.0f} ns waiting on "
            f"a pair with QPU_{peer_qpu_id} (label={ent_label})"
        )
        return True

    def _release_comm_remap(self, actual_pos):
        """Drop the remap entry pointing at *actual_pos* once it is freed."""
        if actual_pos is None or not self._comm_remap:
            return
        for compiler_pos, mapped in list(self._comm_remap.items()):
            if mapped == actual_pos:
                del self._comm_remap[compiler_pos]
                log.debug(
                    f"[{self.node.name}] comm remap released: "
                    f"{compiler_pos} -> {actual_pos}"
                )

    # ── Qubit management ─────────────────────────────────────────────────────

    def find_free_comm_qubit(self, preferred: int, exclude: set = None) -> int:
        """Find a free communication qubit, avoiding occupied, excluded, and factory-reserved positions.

        Parameters
        ----------
        preferred : int
            The preferred comm qubit position.
        exclude : set, optional
            Additional positions to exclude.

        Returns
        -------
        int
            A free comm qubit position.
        """
        if exclude is None:
            exclude = set()

        # Include factory-reserved positions in unavailable set
        factory_reserved = set()
        if self.epr_factory is not None:
            factory_reserved = self.epr_factory.reserved_positions

        unavailable = self.occupied_comm_qubits | exclude | factory_reserved

        if preferred not in unavailable:
            return preferred

        for pos in range(self.NUM_COMM_QUBITS):
            if pos not in unavailable:
                log.debug(
                    f"[{self.node.name}] Comm qubit {preferred} unavailable "
                    f"(occupied={self.occupied_comm_qubits}, exclude={exclude}, "
                    f"factory_reserved={factory_reserved}); "
                    f"redirecting emission to free comm qubit {pos}"
                )
                return pos

        log.error(
            f"[{self.node.name}] All comm qubits 0-{self.NUM_COMM_QUBITS - 1} "
            f"unavailable! occupied={self.occupied_comm_qubits}, exclude={exclude}, "
            f"factory_reserved={factory_reserved}. "
            f"Defaulting to preferred={preferred} (may corrupt state)"
        )
        return preferred

    def _log_qubit_state(self, label=""):
        if not log.isEnabledFor(logging.DEBUG):
            return
        try:
            num_pos = self.node.qmemory.num_positions
            for pos in range(num_pos):
                qubit_list = self.node.qmemory.peek(positions=[pos])
                if qubit_list and qubit_list[0] is not None:
                    q = qubit_list[0]
                    if q.qstate is not None:
                        log.debug(
                            f"  [STATE {self.node.name}] {label} qubit[{pos}]: "
                            f"{q.qstate.qrepr}"
                        )
                    else:
                        log.debug(
                            f"  [STATE {self.node.name}] {label} qubit[{pos}]: no qstate"
                        )
                else:
                    log.debug(
                        f"  [STATE {self.node.name}] {label} qubit[{pos}]: empty/None"
                    )
        except Exception as e:
            log.debug(f"  [STATE {self.node.name}] {label} Error logging state: {e}")

    def _forward_qout_to_bsm(self, bsm_label, emit_qubit):
        qout_port_name = f"qout{emit_qubit}"
        qout_port = self.node.qmemory.ports.get(qout_port_name)
        if qout_port is None:
            qout_port = self.node.qmemory.ports.get("qout")
            qout_port_name = "qout"
        if qout_port is None:
            log.error(f"[{self.node.name}] qmemory has no '{qout_port_name}' port")
            return

        q_port_name = f"q_to_{bsm_label}"
        if q_port_name not in self.node.ports:
            log.error(f"[{self.node.name}] Node has no port '{q_port_name}'")
            return

        if qout_port.forwarded_ports:
            qout_port.disconnect()
            log.debug(
                f"[{self.node.name}] Disconnected previous {qout_port_name} forwarding"
            )

        qout_port.forward_output(self.node.ports[q_port_name])
        log.debug(
            f"[{self.node.name}] Forwarded qmemory.{qout_port_name} -> {q_port_name} "
            f"(BSM: {bsm_label})"
        )

    # ── Controller signalling ────────────────────────────────────────────────

    def send_start_ready(self, start_label, pool_ready=False, magic_position=None):
        """Announce readiness for *start_label* to the controller.

        Parameters
        ----------
        start_label : hashable
            The synchronisation label being awaited.
        pool_ready : bool
            ``True`` when this QPU holds a usable pre-generated EPR pair for
            the label and could therefore skip the BSM round.  The
            controller only skips the round when *all* parties report
            ``True``.
        magic_position : int or None
            Communication-memory position selected for direct magic delivery.
        """
        msg = Message(items={
            'type': 'start_ready',
            'start_label': start_label,
            'qpu_id': self.qpu_id,
            'pool_ready': pool_ready,
            'magic_position': magic_position,
        })
        self.comm_port.tx_output(msg)
        log.debug(
            f"[{self.node.name}] Sent start_ready for label={start_label} "
            f"(pool_ready={pool_ready})"
        )

    def send_end_ready(self, end_label):
        msg = Message(items={
            'type': 'end_ready',
            'end_label': end_label,
            'qpu_id': self.qpu_id,
        })
        self.comm_port.tx_output(msg)
        log.debug(f"[{self.node.name}] Sent end_ready for label={end_label}")

    def send_done(self):
        msg = Message(items={
            'type': 'done',
            'qpu_id': self.qpu_id,
        })
        self.comm_port.tx_output(msg)
        log.debug(f"[{self.node.name}] Sent done signal")

    # ── Port draining ────────────────────────────────────────────────────────

    def _drain_port(self):
        """Drain c_from_* ports and stash classical process messages.

        ``msg_exchange`` messages are stashed in ``_pending_msg_exchange`` so
        ``handle_msg_receiver`` can still find them after drain consumes them
        from the port buffer (``rx_input`` is destructive).
        """
        c_from_ports = [
            (pname, port)
            for pname, port in self.node.ports.items()
            if pname.startswith("c_from_")
        ]
        for port_name, port in c_from_ports:
            n = 0
            while True:
                msg = port.rx_input()
                if msg is None:
                    break
                item = msg.items[0] if msg.items else None
                msg_type = item.get('type') if item else None

                if msg_type in ('starting_process', 'ending_process'):
                    self._pending_classical_msgs.setdefault(port_name, []).append(msg)
                    log.debug(
                        f"[{self.node.name}] DRAIN CLASSICAL: "
                        f"{port_name} type={msg_type}"
                    )
                    n += 1
                elif msg_type == 'msg_exchange':
                    self._pending_msg_exchange.setdefault(port_name, []).append(msg)
                    log.debug(
                        f"[{self.node.name}] DRAIN STASH msg_exchange: "
                        f"{port_name} label={item.get('label')} t={ns.sim_time()}"
                    )
                    n += 1
                else:
                    log.warning(
                        f"[{self.node.name}] DRAIN DROP: port={port_name} "
                        f"type={msg_type!r} item={item!r} t={ns.sim_time()}"
                    )
                    n += 1
            if n > 0:
                log.debug(
                    f"[{self.node.name}] DRAIN: {port_name} consumed "
                    f"{n} msgs t={ns.sim_time()}"
                )

    # ── Gate execution ───────────────────────────────────────────────────────

    def execute_gate(self, op):
        """Execute a gate op from canonical IR.

        Parameters
        ----------
        op : dict
            Canonical IR gate op with ``'gate'`` and ``'qubits'``/``'qubit'``.
        """
        gate_name = op.get('gate') or op.get('op', '')
        qubits = op.get('qubits') or (
            [op['qubit']] if op.get('qubit') is not None else []
        )
        params = op.get('params', [])
        log.debug(
            f"[{self.node.name}] GATE {gate_name} qubits={qubits} params={params}"
        )
        yield from self._apply_gate_by_name(gate_name, qubits, params)

    def _apply_gate_by_name(self, gate_name, qubits, params=None):
        """Apply any gate by name to local memory qubit positions.

        Parameters
        ----------
        gate_name : str
            Gate name (case-insensitive).
        qubits : list[int] or int
            Local memory positions.
        params : list[float] or None
            Angle parameters in units of pi.
        """
        if params is None:
            params = []

        if isinstance(qubits, int):
            qubits = [qubits]

        # Redirect pooled comm qubits to their actual positions.
        qubits = self._resolve_comm_list(qubits)

        g = gate_name.lower()

        def _p(i):
            if len(params) <= i:
                raise ValueError(f"{gate_name} requires parameter {i} in circuit input")
            return float(params[i]) * math.pi

        q0 = qubits[0] if qubits else 0

        # ── 1-qubit gates ──────────────────────────────────────────────────
        if g == 'h':
            self.node.qmemory.execute_instruction(INSTR_H, qubit_mapping=[q0])
            yield self.await_program(self.node.qmemory)
        elif g == 'x':
            self.node.qmemory.execute_instruction(INSTR_X, qubit_mapping=[q0])
            yield self.await_program(self.node.qmemory)
        elif g == 'y':
            self.node.qmemory.execute_instruction(INSTR_Y, qubit_mapping=[q0])
            yield self.await_program(self.node.qmemory)
        elif g == 'z':
            self.node.qmemory.execute_instruction(INSTR_Z, qubit_mapping=[q0])
            yield self.await_program(self.node.qmemory)
        elif g in ('rz', 'u1'):
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=_p(0))
            yield self.await_program(self.node.qmemory)
        elif g == 'rx':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_X, qubit_mapping=[q0], angle=_p(0))
            yield self.await_program(self.node.qmemory)
        elif g == 'ry':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Y, qubit_mapping=[q0], angle=_p(0))
            yield self.await_program(self.node.qmemory)
        elif g == 'sx':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_X, qubit_mapping=[q0], angle=math.pi / 2)
            yield self.await_program(self.node.qmemory)
        elif g == 's':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=math.pi / 2)
            yield self.await_program(self.node.qmemory)
        elif g == 'sdg':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=-math.pi / 2)
            yield self.await_program(self.node.qmemory)
        elif g == 't':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=math.pi / 4)
            yield self.await_program(self.node.qmemory)
        elif g == 'tdg':
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=-math.pi / 4)
            yield self.await_program(self.node.qmemory)
        elif g == 'u2':
            # u2(phi, lam) = rz(lam) · ry(pi/2) · rz(phi)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=_p(1))
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Y, qubit_mapping=[q0], angle=math.pi / 2)
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=_p(0))
            yield self.await_program(self.node.qmemory)
        elif g == 'u3':
            # u3(theta, phi, lam) = rz(lam) · ry(theta) · rz(phi)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=_p(2))
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Y, qubit_mapping=[q0], angle=_p(0))
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[q0], angle=_p(1))
            yield self.await_program(self.node.qmemory)
        elif g == 'reset':
            self.node.qmemory.execute_instruction(INSTR_INIT, qubit_mapping=[q0])
            yield self.await_program(self.node.qmemory)

        # ── 2-qubit gates ──────────────────────────────────────────────────
        elif g in ('cx', 'cnot'):
            if len(qubits) < 2:
                log.error(f"[{self.node.name}] {g} requires 2 qubits, got {qubits}")
                return
            self.node.qmemory.execute_instruction(
                INSTR_CNOT, qubit_mapping=[qubits[0], qubits[1]])
            yield self.await_program(self.node.qmemory)
        elif g == 'cu1':
            if len(qubits) < 2:
                log.error(f"[{self.node.name}] cu1 requires 2 qubits, got {qubits}")
                return
            # cu1(λ) decomposition: rz(λ/2) cx rz(-λ/2) cx rz(λ/2)
            half = _p(0) / 2
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[qubits[0]], angle=half)
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_CNOT, qubit_mapping=[qubits[0], qubits[1]])
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[qubits[1]], angle=-half)
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_CNOT, qubit_mapping=[qubits[0], qubits[1]])
            yield self.await_program(self.node.qmemory)
            self.node.qmemory.execute_instruction(
                INSTR_ROT_Z, qubit_mapping=[qubits[1]], angle=half)
            yield self.await_program(self.node.qmemory)

        # ── 3-qubit gates ──────────────────────────────────────────────────
        elif g in ('ccx', 'toffoli'):
            if len(qubits) < 3:
                raise ValueError(
                    f"[{self.node.name}] {g} requires 3 qubits, got {qubits}"
                )
            self.node.qmemory.execute_instruction(
                INSTR_TOFFOLI, qubit_mapping=[qubits[0], qubits[1], qubits[2]])
            yield self.await_program(self.node.qmemory)

        # ── Multi-qubit gates ──────────────────────────────────────────────
        elif g in ('cnx', 'mcx'):
            if len(qubits) < 3:
                raise ValueError(
                    f"[{self.node.name}] {g} requires 3+ qubits, got {qubits}"
                )
            if len(qubits) == 3:
                # Equivalent to Toffoli
                self.node.qmemory.execute_instruction(
                    INSTR_TOFFOLI, qubit_mapping=[qubits[0], qubits[1], qubits[2]])
                yield self.await_program(self.node.qmemory)
            else:
                # Toffoli-chain decomposition for >3 qubits is not implemented.
                raise NotImplementedError(
                    f"[{self.node.name}] {g} with {len(qubits)} qubits "
                    f"(>3) is not yet supported. Only 3-qubit CnX/MCX "
                    f"(equivalent to Toffoli) is currently implemented."
                )

        else:
            raise ValueError(
                f"[{self.node.name}] _apply_gate_by_name: "
                f"unsupported gate {gate_name!r} on qubits {qubits}. "
                f"Add the gate to instruction_set.py and _apply_gate_by_name()."
            )

    # ── Measurement ──────────────────────────────────────────────────────────

    def _measure_qubit(self, qubit):
        """Execute a physical measurement on a single local qubit.

        Parameters
        ----------
        qubit : int
            Local memory position.

        Returns
        -------
        int
            Measurement outcome (0 or 1).
        """
        prog = QuantumProgram(num_qubits=1)
        prog.apply(INSTR_MEASURE, [0], output_key='m')
        self.node.qmemory.execute_program(prog, qubit_mapping=[qubit])
        yield self.await_program(self.node.qmemory)
        result = int(prog.output['m'][0])
        log.debug(f"[{self.node.name}] _measure_qubit qubit={qubit} → {result}")
        return result

    def _execute_measure(self, op):
        """Measure a qubit into ``classical_memory[clbit]``.

        The position must be resolved through the comm-remap table.  A
        pooled pair does not necessarily land on the position the compiler
        nominated, and the QASM3 (cisco) frontend teleports via
        ``measure`` + ``if_gate`` rather than the eJPP ops, so this is its
        only release point.  Measuring the nominated position instead of
        the pooled one reads an untouched qubit — a random bit — and leaves
        the real half of the pair pinned forever, which then presents as
        pool exhaustion.
        """
        nominated = (
            op.get('qubit') if op.get('qubit') is not None
            else op.get('qubits', [0])[0]
        )
        qubit = (
            self._resolve_comm(nominated)
            if isinstance(nominated, int) and nominated < self.NUM_COMM_QUBITS
            else nominated
        )
        clbit = op['clbit']
        log.debug(
            f"[{self.node.name}] _execute_measure ENTER qubit={qubit} "
            f"(nominated {nominated}) clbit={clbit}"
        )

        outcome = yield from self._measure_qubit(qubit)
        self.classical_memory[clbit] = outcome
        log.debug(
            f"[{self.node.name}] MEASURE qubit={qubit} clbit={clbit} → {outcome}"
        )

        if qubit < self.NUM_COMM_QUBITS:
            self.occupied_comm_qubits.discard(qubit)
            # Measuring consumes the pair half, so retire its remap entry
            # and return the slot to refill.
            self._release_comm_remap(qubit)
            log.debug(
                f"[{self.node.name}] measure: freed comm qubit {qubit}"
            )

    def _execute_measure_final(self, op):
        """Measure a qubit and store result in ``final_measurements[final_key]``.

        Resolved through the comm-remap table for the same reason as
        :meth:`_execute_measure`.  Final measurements normally name data
        qubits, where this is a no-op, but a circuit is free to report a
        comm position and must then read the pooled one.
        """
        nominated = (
            op.get('qubit') if op.get('qubit') is not None
            else op.get('qubits', [0])[0]
        )
        qubit = (
            self._resolve_comm(nominated)
            if isinstance(nominated, int) and nominated < self.NUM_COMM_QUBITS
            else nominated
        )
        final_key = op.get('final_key') or f"m_auto_{nominated}"
        log.debug(
            f"[{self.node.name}] _execute_measure_final ENTER "
            f"qubit={qubit} final_key={final_key}"
        )

        outcome = yield from self._measure_qubit(qubit)
        self.final_measurements[final_key] = outcome
        log.debug(
            f"[{self.node.name}] MEASURE_FINAL qubit={qubit} "
            f"key={final_key} → {outcome}  "
            f"final_measurements={self.final_measurements}"
        )

    def _execute_if_gate(self, op):
        """Conditionally apply a gate based on a classical bit value.

        Parameters
        ----------
        op : dict
            Canonical IR op with ``'gate'``, ``'qubit'``/``'qubits'``,
            ``'params'``, ``'clbit'``, and ``'cond_value'``.
        """
        gate_name = op['gate']
        qubits = op.get('qubits') or (
            [op['qubit']] if op.get('qubit') is not None else []
        )
        params = op.get('params', [])
        clbit = op['clbit']
        cond_value = op.get('cond_value', 1)

        current = self.classical_memory.get(clbit, 0)
        log.debug(
            f"[{self.node.name}] IF clbit={clbit} "
            f"(={current}) == {cond_value} → gate={gate_name} qubits={qubits}"
        )

        if current == cond_value:
            yield from self._apply_gate_by_name(gate_name, qubits, params)

    # ── Classical message exchange ───────────────────────────────────────────

    def handle_msg_sender(self, cmd):
        """Handle the sender side of a QPU-to-QPU classical bit exchange."""
        peer_qpu_id = cmd['peer_qpu_id']
        clbit_name = cmd.get('clbit')
        label = cmd.get('label', '')

        log.debug(
            f"[{self.node.name}] handle_msg_sender: "
            f"label={label}, clbit={clbit_name}, peer=QPU_{peer_qpu_id}"
        )

        bell_key = cmd.get('bell_pair_key')
        actual_emit = cmd.get('comm_qubit')
        if bell_key is not None:
            worker = self._bsm_workers.get(bell_key)
            while bell_key not in self.bell_pair_buffer:
                yield self.await_signal(
                    worker, EntanglementWorkerProtocol.ENTANGLEMENT_DONE
                )
            result = self.bell_pair_buffer.pop(bell_key)
            self._bsm_workers.pop(bell_key, None)
            actual_emit = result['actual_emit']
            log.debug(
                f"[{self.node.name}] msg_sender: consumed Bell pair "
                f"key={bell_key}, actual_emit={actual_emit}"
            )

        # Nested eJPP can make a comm qubit the data side, so resolve here
        # too; a no-op for genuine data qubits.
        cnot_data = self._resolve_comm(cmd.get('cnot_data_qubit'))
        if cnot_data is not None and actual_emit is not None:
            num_q = self.node.qmemory.num_positions
            prog = QuantumProgram(num_qubits=num_q)
            prog.apply(INSTR_CNOT, [cnot_data, actual_emit])
            prog.apply(INSTR_MEASURE, actual_emit, output_key="m")
            self.node.qmemory.execute_program(prog, qubit_mapping=list(range(num_q)))
            yield self.await_program(self.node.qmemory)
            m = prog.output["m"][0]
            self.classical_memory[clbit_name] = m
            log.debug(f"[{self.node.name}] msg_sender: CNOT+measure → m={m}")
        elif cmd.get('h_measure_qubit') is not None:
            hq = self._resolve_comm(cmd['h_measure_qubit'])
            num_q = self.node.qmemory.num_positions
            prog = QuantumProgram(num_qubits=num_q)
            prog.apply(INSTR_H, hq)
            prog.apply(INSTR_MEASURE, hq, output_key="m")
            self.node.qmemory.execute_program(prog, qubit_mapping=list(range(num_q)))
            yield self.await_program(self.node.qmemory)
            m = prog.output["m"][0]
            self.classical_memory[clbit_name] = m
            log.debug(f"[{self.node.name}] msg_sender: H+measure → m={m}")
        else:
            m = self.classical_memory.get(clbit_name, 0)

        free_q = self._resolve_comm(cmd.get('free_comm_qubit'))
        if free_q is None and bell_key is not None and actual_emit is not None:
            free_q = actual_emit
        if free_q is None:
            free_q = self._resolve_comm(
                cmd.get('qubits', [None])[0] if cmd.get('qubits') else cmd.get('qubit')
            )
        if free_q is not None and free_q in self.occupied_comm_qubits:
            self.occupied_comm_qubits.discard(free_q)
            self._release_comm_remap(free_q)
            log.debug(
                f"[{self.node.name}] msg_sender: freed qubit "
                f"{free_q} from occupied_comm_qubits"
            )

        c_port_name = f"c_to_{peer_qpu_id}"
        if c_port_name in self.node.ports:
            payload = {
                'type': 'msg_exchange',
                'label': label,
                'clbit': clbit_name,
                'value': m,
            }
            msg = Message(items=[payload])
            self.node.ports[c_port_name].tx_output(msg)
            log.debug(
                f"[{self.node.name}] msg_sender: "
                f"sent {clbit_name}={m} to QPU_{peer_qpu_id} "
                f"via {c_port_name} (label={label})"
            )
        else:
            log.error(f"[{self.node.name}] Port {c_port_name} not found")

        mark_q = cmd.get('mark_comm_occupied')
        if mark_q is not None:
            self.occupied_comm_qubits.add(mark_q)
            log.debug(
                f"[{self.node.name}] msg_sender: marked qubit {mark_q} as occupied"
            )

        return
        yield  # make this a generator for uniform yield from usage

    def handle_msg_receiver(self, cmd):
        """Handle the receiver side of a QPU-to-QPU classical bit exchange."""
        peer_qpu_id = cmd['peer_qpu_id']
        clbit_name = cmd.get('clbit')
        label = cmd.get('label', '')

        c_port_name = f"c_from_{peer_qpu_id}"
        if c_port_name not in self.node.ports:
            log.error(f"[{self.node.name}] Port {c_port_name} not found")
            return
            yield  # make generator

        port = self.node.ports[c_port_name]

        log.debug(
            f"[{self.node.name}] handle_msg_receiver: "
            f"label={label}, clbit={clbit_name}, peer=QPU_{peer_qpu_id}, "
            f"port={c_port_name} t={ns.sim_time()}"
        )

        bell_key = cmd.get('bell_pair_key')
        if bell_key is not None:
            worker = self._bsm_workers.get(bell_key)
            while bell_key not in self.bell_pair_buffer:
                yield self.await_signal(
                    worker, EntanglementWorkerProtocol.ENTANGLEMENT_DONE
                )
            self.bell_pair_buffer.pop(bell_key)
            self._bsm_workers.pop(bell_key, None)
            log.debug(
                f"[{self.node.name}] msg_receiver: consumed Bell pair key={bell_key}"
            )

        _queue = self._pending_msg_exchange.get(c_port_name)
        if _queue:
            raw = _queue.pop(0)
            if not _queue:
                del self._pending_msg_exchange[c_port_name]
            log.debug(
                f"[{self.node.name}] msg_receiver: stash hit for {c_port_name}"
            )
        else:
            raw = port.rx_input()
            if raw is None:
                log.debug(
                    f"[{self.node.name}] msg_receiver: "
                    f"waiting on {c_port_name} (label={label})"
                )
                yield self.await_port_input(port)
                _queue2 = self._pending_msg_exchange.get(c_port_name)
                if _queue2:
                    raw = _queue2.pop(0)
                    if not _queue2:
                        del self._pending_msg_exchange[c_port_name]
                    log.debug(
                        f"[{self.node.name}] msg_receiver: post-wait stash hit"
                    )
                else:
                    raw = port.rx_input()

        item = raw.items[0] if (raw and raw.items) else {}
        m = item.get('value', 0)
        recv_clbit = item.get('clbit', clbit_name)
        self.classical_memory[recv_clbit] = m
        log.debug(
            f"[{self.node.name}] msg_receiver: "
            f"got {recv_clbit}={m} from QPU_{peer_qpu_id} (label={label})"
        )

        if_gate = cmd.get('if_gate')
        if if_gate is not None:
            yield from self._execute_if_gate(if_gate)

        mark_q = self._resolve_comm(cmd.get('mark_comm_occupied'))
        if mark_q is not None:
            self.occupied_comm_qubits.add(mark_q)
            log.debug(
                f"[{self.node.name}] msg_receiver: marked qubit {mark_q} as occupied"
            )
        free_q = self._resolve_comm(cmd.get('free_comm_qubit'))
        if free_q is not None:
            self.occupied_comm_qubits.discard(free_q)
            self._release_comm_remap(free_q)
            log.debug(
                f"[{self.node.name}] msg_receiver: freed qubit {free_q}"
            )

        self._log_qubit_state("after msg_receiver")
        log.debug(f"[{self.node.name}] handle_msg_receiver done")

    def handle_msg_exchange(self, op):
        """Dispatch to sender or receiver based on ``op['role']``."""
        role = op.get('role', 'sender')
        if role == 'sender':
            yield from self.handle_msg_sender(op)
        else:
            yield from self.handle_msg_receiver(op)

    # ── EJPP handlers ────────────────────────────────────────────────────────

    def handle_ejpp_start_data(self, op):
        """EJPP start correction — data QPU side.

        The payload qubit is resolved through the remap table because it may
        itself be a pooled comm qubit: in chained eJPP the link half of one
        pair becomes the data side of the next.
        """
        label = op['label']
        start_label = op['start_label']
        qubit = self._resolve_comm(op['qubit'])
        clbit = op['clbit']
        peer_id = op['peer_qpu_id']

        log.debug(
            f"[{self.node.name}] EJPP_START_DATA label={label} "
            f"start_label={start_label} qubit={qubit} clbit={clbit}"
        )

        self.send_start_ready(start_label)
        while True:
            yield self.await_port_input(self.clk_port)
            tick_item = self.clk_port.rx_input().items[0]
            if tick_item.get('start_label') == start_label:
                break
            log.debug(
                f"[{self.node.name}] ejpp_start_data: ignoring tick, "
                f"waiting for start_label={start_label}"
            )

        send_op = {
            'label': label,
            'role': 'sender',
            'clbit': clbit,
            'msg_type': 'ejpp_start',
            'peer_qpu_id': peer_id,
            'bell_pair_key': start_label,
            'cnot_data_qubit': qubit,
        }
        yield from self.handle_msg_exchange(send_op)

    def handle_ejpp_start_link(self, op):
        """EJPP start correction — link QPU side.

        This QPU holds the link-register half of the Bell pair.  The remap
        registered at consumption time (see the ``entanglement_gen``
        handler) redirects the compiler's nominated comm qubit to wherever
        the pooled pair actually lives, keeping the correction, the
        intervening gates, and the eventual ``ejpp_end_link`` release all
        pointing at the same physical qubit.
        """
        label = op['label']
        start_label = op['start_label']
        qubit = self._resolve_comm(op['qubit'])
        clbit = op['clbit']
        peer_id = op['peer_qpu_id']

        log.debug(
            f"[{self.node.name}] EJPP_START_LINK label={label} "
            f"start_label={start_label} qubit={qubit} clbit={clbit}"
        )

        self.send_start_ready(start_label)
        while True:
            yield self.await_port_input(self.clk_port)
            tick_item = self.clk_port.rx_input().items[0]
            if tick_item.get('start_label') == start_label:
                break
            log.debug(
                f"[{self.node.name}] ejpp_start_link: ignoring tick, "
                f"waiting for start_label={start_label}"
            )

        recv_op = {
            'label': label,
            'role': 'receiver',
            'clbit': clbit,
            'msg_type': 'ejpp_start',
            'peer_qpu_id': peer_id,
            'bell_pair_key': start_label,
            'mark_comm_occupied': qubit,
            'if_gate': {
                'gate': 'X',
                'qubit': qubit,
                'params': [],
                'clbit': clbit,
                'cond_value': 1,
            },
        }
        yield from self.handle_msg_exchange(recv_op)

    def handle_ejpp_end_data(self, op):
        """EJPP end correction — data QPU side."""
        label = op['label']
        end_label = op['end_label']
        comm_qubit = self._resolve_comm(op['comm_qubit'])
        data_qubit = self._resolve_comm(op['data_qubit'])
        clbit = op['clbit']
        peer_id = op['peer_qpu_id']

        log.debug(
            f"[{self.node.name}] EJPP_END_DATA label={label} "
            f"comm_qubit={comm_qubit} data_qubit={data_qubit} clbit={clbit}"
        )

        self.send_end_ready(end_label)
        while True:
            yield self.await_port_input(self.clk_port)
            tick_item = self.clk_port.rx_input().items[0]
            if tick_item.get('end_label') == end_label:
                break
            log.debug(
                f"[{self.node.name}] ejpp_end_data: ignoring tick, "
                f"waiting for end_label={end_label}"
            )

        recv_op = {
            'label': label,
            'role': 'receiver',
            'clbit': clbit,
            'msg_type': 'ejpp_end',
            'peer_qpu_id': peer_id,
            'if_gate': {
                'gate': 'Z',
                'qubit': data_qubit,
                'params': [],
                'clbit': clbit,
                'cond_value': 1,
            },
        }
        yield from self.handle_msg_exchange(recv_op)

    def handle_ejpp_end_link(self, op):
        """EJPP end correction — link QPU side.

        Resolves the compiler's position through the remap table so the
        measurement and release act on the pooled qubit, then clears the
        mapping now that the position is free again.
        """
        label = op['label']
        end_label = op['end_label']
        qubit = self._resolve_comm(op['qubit'])
        clbit = op['clbit']
        peer_id = op['peer_qpu_id']

        log.debug(
            f"[{self.node.name}] EJPP_END_LINK label={label} "
            f"qubit={qubit} clbit={clbit}"
        )

        self.send_end_ready(end_label)
        while True:
            yield self.await_port_input(self.clk_port)
            tick_item = self.clk_port.rx_input().items[0]
            if tick_item.get('end_label') == end_label:
                break
            log.debug(
                f"[{self.node.name}] ejpp_end_link: ignoring tick, "
                f"waiting for end_label={end_label}"
            )

        send_op = {
            'label': label,
            'role': 'sender',
            'clbit': clbit,
            'msg_type': 'ejpp_end',
            'peer_qpu_id': peer_id,
            'h_measure_qubit': qubit,
            'free_comm_qubit': qubit,
        }
        yield from self.handle_msg_exchange(send_op)

        # The pooled qubit is free again — retire its remap entry.
        self._release_comm_remap(qubit)

    # ── Main run loop ────────────────────────────────────────────────────────

    def run(self):
        log.debug(f"[{self.node.name}] Starting at time:{ns.sim_time()}")
        log.debug(f"[{self.node.name}] Protocol started, waiting for commands...")

        yield self.await_port_input(self.ctrl_port)
        log.debug(f"Received QPU commands from control node at {self.node.name}")
        msg = self.ctrl_port.rx_input()
        item = msg.items[0]
        self.commands = item.get('commands', [])
        log.debug(f"[{self.node.name}] Received {len(self.commands)} commands")

        # Reset the register, skipping factory-reserved positions so
        # pre-filled pairs survive.
        reserved = (
            self.epr_factory.reserved_positions
            if self.epr_factory is not None else set()
        )
        if reserved:
            positions = [
                p for p in range(self.node.qmemory.num_positions)
                if p not in reserved
            ]
            self.node.qmemory.execute_instruction(IInit(), positions)
            yield self.await_program(self.node.qmemory)
            log.debug(
                f"[{self.node.name}] Initialized qubits, preserving "
                f"factory-reserved positions {sorted(reserved)}"
            )
        else:
            self.node.qmemory.execute_instruction(IInit())
            yield self.await_program(self.node.qmemory)
            log.debug(f"[{self.node.name}] Initialized all qubits")

        global EXECUTION_START_TIME, EXECUTION_END_TIME, EXECUTION_DURATION, MAX_EXECUTION_TIME
        global SYNC_START_TIME, SYNC_END_TIME, SYNC_PROCESS_DURATION, MAX_SYNC_PROCESS_TIME
        EXECUTION_START_TIME = ns.sim_time()

        # Gate op names from the instruction-set registry (GATE_OPS).
        _GATE_OPS = GATE_OPS

        for op in self.commands:
            op_name = op['op']

            if op_name != 'msg_receiver':
                self._drain_port()
            op_name_lower = op_name.lower()

            if op_name_lower == 'gate':
                yield from self.execute_gate(op)

            elif op_name_lower in _GATE_OPS:
                qubits = op.get('qubits') or (
                    [op['qubit']] if op.get('qubit') is not None else []
                )
                params = op.get('params', [])
                log.debug(
                    f"[{self.node.name}] GATE {op_name_lower} "
                    f"qubits={qubits} params={params}"
                )
                yield from self._apply_gate_by_name(op_name_lower, qubits, params)

            elif op_name == 'measure':
                yield from self._execute_measure(op)

            elif op_name == 'measure_final':
                yield from self._execute_measure_final(op)

            elif op_name == 'if_gate':
                yield from self._execute_if_gate(op)

            elif op_name == 'msg_sender':
                end_label = op.get('end_label')
                if end_label is not None:
                    self.send_end_ready(end_label)
                    while True:
                        yield self.await_port_input(self.clk_port)
                        tick_msg = self.clk_port.rx_input()
                        tick_item = tick_msg.items[0]
                        recv_end_label = tick_item.get('end_label')
                        if recv_end_label == end_label:
                            log.debug(
                                f"[{self.node.name}] msg_sender: "
                                f"clock tick for end_label={end_label}"
                            )
                            break
                        else:
                            log.debug(
                                f"[{self.node.name}] msg_sender: "
                                f"ignoring tick, waiting for end_label={end_label}"
                            )
                log.debug(
                    f"[{self.node.name}] STEP msg_sender: "
                    f"label={op.get('label')}, time={ns.sim_time()}"
                )
                yield from self.handle_msg_sender(op)

            elif op_name == 'msg_receiver':
                end_label = op.get('end_label')
                if end_label is not None:
                    self.send_end_ready(end_label)
                    while True:
                        yield self.await_port_input(self.clk_port)
                        tick_msg = self.clk_port.rx_input()
                        tick_item = tick_msg.items[0]
                        recv_end_label = tick_item.get('end_label')
                        if recv_end_label == end_label:
                            log.debug(
                                f"[{self.node.name}] msg_receiver: "
                                f"clock tick for end_label={end_label}"
                            )
                            break
                        else:
                            log.debug(
                                f"[{self.node.name}] msg_receiver: "
                                f"ignoring tick, waiting for end_label={end_label}"
                            )
                log.debug(
                    f"[{self.node.name}] STEP msg_receiver: "
                    f"label={op.get('label')}, time={ns.sim_time()}"
                )
                yield from self.handle_msg_receiver(op)

            elif op_name == 'ejpp_start':
                yield from self.handle_ejpp_start_data(op)

            elif op_name == 'ejpp_start_link':
                yield from self.handle_ejpp_start_link(op)

            elif op_name == 'ejpp_end':
                yield from self.handle_ejpp_end_data(op)

            elif op_name == 'ejpp_end_link':
                yield from self.handle_ejpp_end_link(op)

            elif op_name_lower.startswith('cu1('):
                # TketFrontend emits e.g. "CU1(1)"; strip the suffix since
                # the parameter is already in cmd['params'].
                qubits = op.get('qubits') or (
                    [op['qubit']] if op.get('qubit') is not None else []
                )
                params = op.get('params', [])
                log.debug(
                    f"[{self.node.name}] GATE cu1 "
                    f"qubits={qubits} params={params}"
                )
                yield from self._apply_gate_by_name('cu1', qubits, params)

            elif op_name == 'entanglement_gen':
                ent_label = op.get('entanglement_label')
                buffer_key = op.get('target_start_label', ent_label)
                peer_qpu_id = op.get('peer_qpu_id')

                # Comm qubit named by the compiler; every later op in this
                # eJPP episode refers to it, so it is the remap key.
                nominated = op.get('l_local')
                if nominated is None:
                    _qubits = op.get('qubits') or []
                    nominated = _qubits[0] if _qubits else None

                use_magic = self.cfg.entanglement.method == 'magic'
                magic_position = None
                if use_magic:
                    if nominated is None:
                        raise ValueError(
                            f'Missing communication qubit for {ent_label}'
                        )
                    data_qubit = op.get('data_qubit')
                    exclude = {data_qubit} if data_qubit is not None else set()
                    magic_position = self.find_free_comm_qubit(
                        nominated, exclude=exclude
                    )
                    if (
                        magic_position not in range(min(
                            self.NUM_COMM_QUBITS, self.node.qmemory.num_positions
                        ))
                        or magic_position in self.occupied_comm_qubits
                        or magic_position in exclude
                    ):
                        raise RuntimeError(
                            f'No free communication qubit for {ent_label}'
                        )

                # ── Can this side be served from the factory pool? ─────
                # Query only; the pair is consumed below once the controller
                # confirms both sides can be served.  A nominated qubit still
                # redirected by an earlier pair cannot take a second one.
                pool_ready = (
                    not use_magic
                    and self.epr_factory is not None
                    and self.epr_factory.has_usable_pair(peer_qpu_id, ns.sim_time())
                    and self._comm_remap.get(nominated) is None
                )

                if (
                    self.pool_only
                    and self.epr_factory is not None
                    and not pool_ready
                    and self._comm_remap.get(nominated) is None
                ):
                    # No on-demand fallback here: wait (bounded) for refill.
                    # A refused wait leaves pool_ready False and the vote
                    # sends both sides down the on-demand path together.
                    pool_ready = yield from self._await_pooled_pair(
                        peer_qpu_id, ent_label
                    )

                self.send_start_ready(
                    ent_label, pool_ready=pool_ready,
                    magic_position=magic_position,
                )

                bsm_label = None
                use_pool = False
                pool_slot = None
                while True:
                    yield self.await_port_input(self.clk_port)
                    tick_msg = self.clk_port.rx_input()
                    tick_item = tick_msg.items[0]
                    recv_start_label = tick_item.get('start_label')
                    if recv_start_label == ent_label:
                        bsm_label = tick_item.get('bsm_label')
                        use_pool = bool(tick_item.get('use_pool'))
                        pool_slot = tick_item.get('pool_slot')
                        log.debug(
                            f"[{self.node.name}] entanglement_gen: "
                            f"clock tick for ent_label={ent_label}, "
                            f"bsm_label={bsm_label}, use_pool={use_pool}"
                        )
                        break
                    else:
                        log.debug(
                            f"[{self.node.name}] entanglement_gen: "
                            f"ignoring tick, waiting for ent_label={ent_label}"
                        )

                if use_magic:
                    if not self._register_comm_remap(nominated, magic_position):
                        if op.get('l_local') is None:
                            raise RuntimeError(
                                f'Cannot remap link qubit for {ent_label}'
                            )
                    self.occupied_comm_qubits.add(magic_position)
                    self.bell_pair_buffer[buffer_key] = {
                        'success': True,
                        'bsm_data': None,
                        'retries': 0,
                        'actual_emit': magic_position,
                        'ent_duration_ns': self.cfg.entanglement.magic_state_delay_ns,
                        'generation_time': ns.sim_time(),
                    }
                    continue

                # ── Factory path: consume the pre-generated pair ────────
                if use_pool:
                    # Redirect the nominated comm qubit onto the pooled one
                    # for the lifetime of this pair.  The controller names
                    # the slot so both endpoints take the same one
                    # (see ControllerProtocol.choose_pool_slot).
                    if pool_slot is not None:
                        pair = self.epr_factory.consume_slot(
                            peer_qpu_id, pool_slot, ns.sim_time()
                        )
                    else:
                        pair = self.epr_factory.consume_pair(
                            peer_qpu_id, ns.sim_time()
                        )
                    if pair is not None and self._register_comm_remap(
                        nominated, pair.comm_qubit_local
                    ):
                        log.debug(
                            f"[{self.node.name}] entanglement_gen: consumed "
                            f"pre-generated pair (peer=QPU_{peer_qpu_id}, "
                            f"slot={pair.slot_id}, "
                            f"local_qubit={pair.comm_qubit_local}, "
                            f"remote_qubit={pair.comm_qubit_remote}, "
                            f"age={ns.sim_time() - pair.generation_time_ns:.0f} ns)"
                        )
                        # Record the choice so a desync between the two sides
                        # surfaces as a mismatch rather than bad output.
                        self._record_pool_consumption(
                            ent_label, peer_qpu_id, pair
                        )
                        self.bell_pair_buffer[buffer_key] = pair.to_buffer_entry()
                        self.occupied_comm_qubits.add(pair.comm_qubit_local)
                        self.entanglement_timing.endpoint_ready(
                            ent_label, self.qpu_id, ns.sim_time()
                        )
                        continue

                    if pair is not None:
                        # Remap failure means a malformed position; return
                        # the pair so it is not leaked, then report.
                        self.epr_factory.return_pair(peer_qpu_id, pair)
                        log.error(
                            f"[{self.node.name}] entanglement_gen: could not "
                            f"remap nominated qubit {nominated} onto pooled "
                            f"qubit {pair.comm_qubit_local} "
                            f"(peer=QPU_{peer_qpu_id})"
                        )

                    # Raced with a staleness eviction; the controller already
                    # dispatched the BSM, so fall through to on-demand.
                    log.warning(
                        f"[{self.node.name}] entanglement_gen: pool reported "
                        f"ready but no pair available for peer=QPU_{peer_qpu_id}; "
                        f"falling back to on-demand"
                    )

                # ── On-demand path ─────────────────────────────────────
                worker = self._get_or_create_bsm_worker(bsm_label)
                worker.add_work(buffer_key, op)
                log.debug(
                    f"[{self.node.name}] entanglement_gen: "
                    f"submitted label={ent_label} (buffer_key={buffer_key}) "
                    f"to worker (bsm={bsm_label})"
                )

                while buffer_key not in self.bell_pair_buffer:
                    yield self.await_signal(
                        worker, EntanglementWorkerProtocol.ENTANGLEMENT_DONE
                    )

                log.debug(
                    f"[{self.node.name}] entanglement_gen completed (on-demand): "
                    f"label={ent_label}, buffer_key={buffer_key}, "
                    f"success={self.bell_pair_buffer[buffer_key]['success']}"
                )

            else:
                raise ValueError(f"[{self.node.name}] Unknown op: {op_name!r}")

        EXECUTION_END_TIME = ns.sim_time()
        EXECUTION_DURATION = EXECUTION_END_TIME - EXECUTION_START_TIME
        if EXECUTION_DURATION > MAX_EXECUTION_TIME:
            MAX_EXECUTION_TIME = EXECUTION_DURATION

        for bsm_label, worker in list(self._bsm_workers.items()):
            if worker.is_running:
                worker.stop()
        self._bsm_workers.clear()
        self.bell_pair_buffer.clear()

        self.send_done()
        log.debug(
            f"[{self.node.name}] --- EXECUTION END TIME: {EXECUTION_END_TIME} ---"
        )
        log.debug(
            f"[{self.node.name}] --- EXECUTION DURATION: {EXECUTION_DURATION} ---"
        )
        log.debug(
            f"[{self.node.name}] --- MAX EXECUTION TIME: {MAX_EXECUTION_TIME} ---"
        )
        log.debug(f"[{self.node.name}] Execution completed at time {ns.sim_time()}")
        log.debug(f"[{self.node.name}] All commands executed")

        self.send_signal(Signals.SUCCESS)
