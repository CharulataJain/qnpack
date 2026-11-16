"""
protocols/epr_factory.py
------------------------
EPR Pair Factory — pre-generates entangled Bell pairs on a QPU node and
stores them in per-peer pools for later consumption by circuit commands.

The factory runs on a **dedicated classical plane** that is completely
independent of the circuit-execution entanglement path:

======================  ====================================  ==================
Plane                   QPU ports                             BSM ports
======================  ====================================  ==================
Circuit (on-demand)     ``clk_from_{bsm}``                    ``clk_to_{side}``
                        ``bsm_res_from_{bsm}``                ``BSM_res_to_{side}``
Factory (pre-fill)      ``factory_clk_from_{bsm}``            ``factory_clk_to_{side}``
                        ``factory_bsm_res_from_{bsm}``        ``factory_BSM_res_to_{side}``
======================  ====================================  ==================

Because the two planes use disjoint NetSquid ports, the
:class:`FactoryEntanglementWorker` and the circuit-execution
``EntanglementWorkerProtocol`` can never contend for the same port — which
was the root cause of the pre-fill deadlock in the first design.

Coordination
~~~~~~~~~~~~
Entanglement generation is still **controller-mediated**, exactly like the
on-demand ``entanglement_gen`` path.  During the pre-fill phase the
controller walks a deterministic schedule of ``(qpu_lo, qpu_hi, slot)``
jobs.  For each job it:

1. Arms the factory worker on *both* QPUs via :meth:`EPRFactoryProtocol.arm_prefill`.
2. Sends a ``factory_start_entanglement`` message to the shared BSM node.
3. Waits for both factory workers to report ``ENTANGLEMENT_DONE``.

Because the controller sequences jobs one at a time, there is no barrier
negotiation and therefore no possibility of circular waits.

Pair tracking
~~~~~~~~~~~~~
Each successfully generated pair is recorded as an
:class:`~qnpack.dqc.protocols.epr_pool.EPRPairEntry` holding **both** the
local and the remote communication-qubit positions, so a labelled remote
gate can address either end of the pair.

Classes
-------
    FactoryEntanglementWorker — Per-BSM emission worker on the factory plane.
    EPRFactoryProtocol        — Pool owner / public API for a QPU node.
"""

from __future__ import annotations

import logging
import random
from typing import Optional

import netsquid as ns
from netsquid.protocols.nodeprotocols import NodeProtocol
from netsquid.qubits import operators as ops
from netsquid.qubits import qubitapi as qapi

from qnpack.dqc.protocols.epr_pool import EPRPairEntry, EPRPairPool
from qnpack.dqc.protocols.fidelity import FidelityTracker

log = logging.getLogger(__name__)

# BSM detector output values that indicate successful Bell measurement
# (mirrors the constant in qpu.py)
BSM_SUCCESS = [[2], [3]]


# ---------------------------------------------------------------------------
# Factory-plane entanglement worker
# ---------------------------------------------------------------------------

class FactoryEntanglementWorker(NodeProtocol):
    """Emission worker for the dedicated EPR-factory classical plane.

    Functionally a mirror of
    :class:`~qnpack.dqc.protocols.qpu.EntanglementWorkerProtocol`, but it
    listens on the ``factory_*`` ports instead of the circuit-plane ports
    and writes its results into an :class:`EPRPairPool` rather than the
    QPU's ``bell_pair_buffer``.

    There is exactly **one instance per QPU node**, and each queued job
    names the BSM it targets.  A single worker is both necessary and
    sufficient:

    * *Necessary* — in switched mode every BSM's factory traffic arrives on
      the same ``factory_*_from_switch`` port, so two workers on one node
      would contend for it and steal each other's clock ticks and results.
    * *Sufficient* — the controller serialises pre-fill jobs globally, so a
      node is never mid-round for two BSMs at once.

    Parameters
    ----------
    node : Node
        The QPU node (shared with ``QPUProtocol`` and ``EPRFactoryProtocol``).
    factory : EPRFactoryProtocol
        Owning factory, used for config access and result hand-off.
    q_switch : FullMeshOpticalSwitch or None
        Optical switch component when running in switched-network mode.
    qpu_label : str or None
        Topology label of this QPU (e.g. ``'LBNL-A'``), needed for switch
        route configuration.
    name : str or None
        Protocol name (auto-generated when ``None``).
    """

    ENTANGLEMENT_DONE = "FACTORY_ENTANGLEMENT_DONE"
    NEW_WORK = "FACTORY_NEW_WORK"

    def __init__(
        self,
        node,
        factory,
        q_switch=None,
        qpu_label: str | None = None,
        name=None,
    ):
        if name is None:
            name = f"FactoryEntWorker_{node.name}"
        super().__init__(node, name=name)

        self.factory = factory
        self.q_switch = q_switch
        self.qpu_label = qpu_label

        self._work_queue: list[dict] = []
        self.add_signal(self.ENTANGLEMENT_DONE)
        self.add_signal(self.NEW_WORK)

        cfg = factory.qpu_protocol.cfg
        self._one_q_gate_duration = float(cfg.gate_durations.one_q_gate_duration)
        self._one_q_depolar_prob = float(cfg.qpu.one_q_depolar_prob)

    # ── Work submission ───────────────────────────────────────────────────

    def add_work(self, job: dict) -> None:
        """Queue a pre-fill job.

        Parameters
        ----------
        job : dict
            Must contain ``job_id`` (str), ``position`` (int, local comm
            qubit), ``peer_position`` (int, remote comm qubit),
            ``peer_qpu_id`` (int), ``bsm_label`` (str), ``bsm_side``
            (``'left'``/``'right'``) and ``apply_corrections`` (bool).
        """
        self._work_queue.append(job)
        self.send_signal(self.NEW_WORK)

    # ── Qubit primitives (mirrors EntanglementWorkerProtocol) ─────────────

    def _position_free(self, position: int) -> bool:
        """Whether *position* can be read and written right now.

        NetSquid locks memory **per position**, not per processor: a running
        gate marks only the positions it operates on, and every other
        position stays readable.  That is exactly the property continuous
        refill needs — pool storage lives on communication qubits the
        circuit never names, so refill can regenerate a pair while the QPU
        is busy running gates on its data qubits.

        The guard therefore asks about this one position rather than about
        ``qmemory.busy``.  Using the processor-wide flag would serialise
        refill behind the entire circuit and, worse, deadlock: the circuit
        only advances when the controller ticks it, and the controller may
        be waiting on this very refill round to release its BSM.

        A position can still be legitimately busy — for instance while the
        circuit measures out a pooled qubit it has just consumed — so this
        is a test, not a wait.  Callers treat a busy position as a failed
        attempt and retry on the next clock tick.
        """
        try:
            return not self.node.qmemory.mem_positions[position].busy
        except (IndexError, AttributeError):
            return True

    def _init_qubit(self, position: int) -> None:
        """Re-initialise a memory qubit to |0⟩ without locking the processor."""
        [qubit] = self.node.qmemory.peek(position)
        if qubit is not None:
            qapi.assign_qstate([qubit], ns.qubits.ketstates.s0)
        else:
            [qubit] = qapi.create_qubits(1)
            self.node.qmemory.put(qubit, positions=[position])

    def _apply_emission_noise(self, matter_qubit, photon_qubit, fidelity) -> None:
        """Apply depolarising noise modelling imperfect emission fidelity."""
        qapi.depolarize(photon_qubit, 4 / 3 * (1 - fidelity))

    def _emit_photon(self, position: int) -> bool:
        """Create a Bell pair between the memory qubit and a fresh photon."""
        [memory_qubit] = self.node.qmemory.peek(position)
        [emission_qubit] = qapi.create_qubits(1)

        qapi.operate(memory_qubit, ops.H)
        qapi.operate([memory_qubit, emission_qubit], ops.CNOT)

        cfg = self.factory.qpu_protocol.cfg
        emission_fidelity = cfg.qpu.emission_fidelity
        if emission_fidelity < 1.0:
            self._apply_emission_noise(
                memory_qubit, emission_qubit, emission_fidelity
            )

        collection_efficiency = cfg.qpu.collection_efficiency
        if collection_efficiency < 1.0 and random.random() > collection_efficiency:
            log.debug(
                "[%s|FactoryWorker] Photon lost (collection_efficiency=%s)",
                self.node.name, collection_efficiency,
            )
            qapi.discard(emission_qubit)
            qapi.assign_qstate([memory_qubit], ns.qubits.ketstates.s0)
            return False

        qout_port = self.node.qmemory.ports.get(f"qout{position}")
        if qout_port is None:
            qout_port = self.node.qmemory.ports.get("qout")
        if qout_port is None:
            log.error(
                "[%s|FactoryWorker] No qout port for position %d",
                self.node.name, position,
            )
            qapi.discard(emission_qubit)
            return False

        qout_port.tx_output(emission_qubit)
        return True

    def _apply_correction(self, position: int, gate_op):
        """Apply a single-qubit Pauli correction with realistic timing/noise.

        Pool storage is disjoint from the positions the circuit names, so
        this position is not under a running gate; the correction proceeds
        regardless of what the rest of the processor is doing.
        """
        [qubit] = self.node.qmemory.peek(position)
        qapi.operate(qubit, gate_op)

        if self._one_q_gate_duration > 0:
            yield self.await_timer(duration=self._one_q_gate_duration)

        if self._one_q_depolar_prob > 0 and random.random() < self._one_q_depolar_prob:
            pauli_r = random.random()
            if pauli_r < 1.0 / 3.0:
                qapi.operate(qubit, ops.X)
            elif pauli_r < 2.0 / 3.0:
                qapi.operate(qubit, ops.Y)
            else:
                qapi.operate(qubit, ops.Z)

    @staticmethod
    def _drain(port) -> int:
        """Drain any stale messages sitting in a port's input buffer."""
        drained = 0
        while port.rx_input() is not None:
            drained += 1
        return drained

    def _configure_switch_route(self, bsm_label: str, bsm_side: str) -> None:
        """Point the optical switch from this QPU towards the target BSM."""
        if self.q_switch is None:
            return

        qpu_port = f"q_from_{self.qpu_label}"
        bsm_port = f"q_to_{bsm_label}_{bsm_side}"

        for (src, dst) in list(self.q_switch.routing_table.keys()):
            if src == qpu_port:
                self.q_switch.configure_route(src, dst, active=False)

        if (qpu_port, bsm_port) in self.q_switch.routing_table:
            self.q_switch.configure_route(qpu_port, bsm_port, active=True)
        else:
            log.warning(
                "[%s|FactoryWorker] No switch route %s -> %s",
                self.node.name, qpu_port, bsm_port,
            )

    # ── Port resolution ───────────────────────────────────────────────────

    def _resolve_ports(self, bsm_label: str):
        """Return ``(clk_port, res_port)`` on the dedicated factory plane.

        In switched mode all BSMs share the single pair of switch-facing
        factory ports; in direct mode each BSM has its own pair.
        """
        if self.q_switch is not None:
            clk = self.node.ports.get("factory_clk_from_switch")
            res = self.node.ports.get("factory_bsm_res_from_switch")
        else:
            clk = self.node.ports.get(f"factory_clk_from_{bsm_label}")
            res = self.node.ports.get(f"factory_bsm_res_from_{bsm_label}")
        return clk, res

    # ── Main loop ─────────────────────────────────────────────────────────

    def run(self):
        parent = self.factory.qpu_protocol

        max_retries = parent.cfg.bsm.max_emission_retries
        retry_duration = parent.cfg.bsm.retry_duration

        while True:
            while not self._work_queue:
                yield self.await_signal(self, self.NEW_WORK)

            job = self._work_queue.pop(0)
            position = job["position"]
            job_id = job["job_id"]
            bsm_label = job["bsm_label"]
            bsm_side = job["bsm_side"]

            # Resolved per job: jobs may target different BSMs, and in direct
            # mode each BSM has its own port pair.
            clk_port, res_port = self._resolve_ports(bsm_label)
            if clk_port is None or res_port is None:
                log.error(
                    "[%s|FactoryWorker] Missing factory ports for BSM %s "
                    "(clk=%s, res=%s) — skipping job %s",
                    self.node.name, bsm_label, clk_port, res_port, job_id,
                )
                self.factory.record_failure(job["peer_qpu_id"])
                self.factory.record_job_outcome(job_id, success=False)
                self.send_signal(self.ENTANGLEMENT_DONE, result=job_id)
                continue

            log.debug(
                "[%s|FactoryWorker] Job %s: emitting on comm qubit %d "
                "(bsm=%s, peer=QPU_%s)",
                self.node.name, job_id, position,
                bsm_label, job.get("peer_qpu_id"),
            )

            self._drain(res_port)
            self._configure_switch_route(bsm_label, bsm_side)
            parent._forward_qout_to_bsm(bsm_label, position)

            # Wait for the BSM's opening clock tick for this round.
            yield self.await_port_input(clk_port)
            clk_port.rx_input()
            self._drain(res_port)

            start_time = ns.sim_time()
            retries = 0
            success = False
            bsm_data = None

            while retries <= max_retries:
                if retries > 0:
                    yield self.await_port_input(clk_port)
                    clk_port.rx_input()
                    self._drain(res_port)

                # Refill uses comm qubits the circuit never names, so the
                # position is normally free.  It can be transiently busy, so
                # retry next tick; blocking would deadlock against the
                # controller waiting on this round (see _position_free).
                if not self._position_free(position):
                    log.debug(
                        "[%s|FactoryWorker] Job %s: position %d busy, "
                        "deferring attempt %d",
                        self.node.name, job_id, position, retries,
                    )
                    retries += 1
                    continue

                self._init_qubit(position)

                if retries != 0 and retry_duration > 0:
                    yield self.await_timer(duration=retry_duration)

                self._configure_switch_route(bsm_label, bsm_side)
                parent._forward_qout_to_bsm(bsm_label, position)

                if not self._emit_photon(position):
                    retries += 1
                    continue

                yield self.await_port_input(res_port)
                res = res_port.rx_input()

                if res is None or not res.items:
                    retries += 1
                    continue

                item = res.items[0] if isinstance(res.items, list) else res.items
                bsm_data = item.get("data") if isinstance(item, dict) else item

                if bsm_data in BSM_SUCCESS:
                    success = True
                    break
                retries += 1

            end_time = ns.sim_time()

            if success:
                # Exactly one side of the pair applies the Pauli corrections
                # implied by the Bell-state measurement outcome.
                if job.get("apply_corrections") and bsm_data is not None:
                    if bsm_data in ([2], [3]):
                        yield from self._apply_correction(position, ops.X)
                    if bsm_data == [3]:
                        yield from self._apply_correction(position, ops.Z)

                self.factory.record_pair(
                    peer_qpu_id=job["peer_qpu_id"],
                    comm_qubit_local=position,
                    comm_qubit_remote=job["peer_position"],
                    slot_id=job.get("slot_id"),
                    generation_time_ns=end_time,
                    bsm_data=bsm_data,
                    bsm_label=bsm_label,
                    corrections_applied=bool(job.get("apply_corrections")),
                    committed=bool(job.get("committed", True)),
                )
                log.debug(
                    "[%s|FactoryWorker] Job %s SUCCESS: pos=%d retries=%d "
                    "bsm_data=%s duration=%.0f ns",
                    self.node.name, job_id, position, retries,
                    bsm_data, end_time - start_time,
                )
            else:
                self.factory.record_failure(job["peer_qpu_id"])
                log.warning(
                    "[%s|FactoryWorker] Job %s FAILED after %d retries",
                    self.node.name, job_id, retries,
                )

            self.factory.record_job_outcome(job_id, success=success)
            self.send_signal(self.ENTANGLEMENT_DONE, result=job_id)


# ---------------------------------------------------------------------------
# Factory protocol
# ---------------------------------------------------------------------------

class EPRFactoryProtocol(NodeProtocol):
    """Owns the per-peer EPR pair pools for a single QPU node.

    The protocol itself is passive: pool creation happens in :meth:`run`
    (or eagerly via :meth:`setup_pools`), generation is driven by the
    controller during the pre-fill phase, and the only periodic activity is
    a freshness sweep that evicts decohered pairs.

    Parameters
    ----------
    node : Node
        The QPU node this factory runs on.
    qpu_protocol : QPUProtocol
        Parent protocol, used for ``cfg``, ``_forward_qout_to_bsm`` and
        ``occupied_comm_qubits``.
    peer_configs : dict
        ``{peer_qpu_id: {'pool_size': int, 'bsm_label': str,
        'comm_positions': list[int]}}``.  ``comm_positions`` starts empty
        and is filled in by the controller via :meth:`set_peer_positions`
        once the compiled circuit is known.
    fidelity_tracker : FidelityTracker
        Shared fidelity model used for staleness decisions.
    q_switch : FullMeshOpticalSwitch or None
        Present when the network runs in switched mode.
    bsm_info : dict or None
        BSM topology metadata (``bsm_label -> {left_qpu, right_qpu, ...}``).
    check_interval_ns : float
        Freshness sweep period during the MAINTAIN phase.
    """

    POOLS_READY = "epr_factory_pools_ready"
    PAIR_GENERATED = "epr_factory_pair_generated"

    def __init__(
        self,
        node,
        qpu_protocol,
        peer_configs: dict,
        fidelity_tracker: FidelityTracker,
        check_interval_ns: float,
        max_maintain_rounds: int,
        q_switch=None,
        bsm_info: dict | None = None,
    ):
        super().__init__(node, name=f"EPRFactory_{node.name}")

        self.qpu_protocol = qpu_protocol
        self.peer_configs = peer_configs
        self.fidelity_tracker = fidelity_tracker
        self.q_switch = q_switch
        self.bsm_info = bsm_info or {}
        self.check_interval_ns = check_interval_ns
        # Safety valve bounding the maintenance sweep; see run().
        self.max_maintain_rounds = max_maintain_rounds

        self.add_signal(self.POOLS_READY)
        self.add_signal(self.PAIR_GENERATED)

        self._pools: dict[int, EPRPairPool] = {}
        # job_id -> did this side's emission produce a pair.  The controller
        # reads and clears it once both endpoints report.
        self.job_outcomes: dict[str, bool] = {}
        # Single worker per node (see _get_or_create_factory_worker).
        self._worker: Optional[FactoryEntanglementWorker] = None
        # Consumption cross-check scratch shared by all factories in a run
        # (installed by DQCProtocol).  Diagnostic only.
        self.shared_consumption_log: dict | None = None
        # qpu_id -> QPUProtocol (installed by DQCProtocol), letting a QPU see
        # whether its peer pins the slots it waits on.  Diagnostic only.
        self.peer_qpu_protocols: dict = {}

        self._stats = {
            "pairs_generated": 0,
            "pairs_consumed": 0,
            "pairs_discarded": 0,
            "generation_failures": 0,
        }

        self.setup_pools()

        log.info(
            "[%s] EPRFactoryProtocol created with %d peer(s): %s",
            node.name, len(peer_configs), sorted(peer_configs),
        )

    # ══════════════════════════════════════════════════════════════════════
    # Pool lifecycle
    # ══════════════════════════════════════════════════════════════════════

    @property
    def qpu_id(self) -> int:
        """1-based identifier of the QPU owning this factory."""
        return self.qpu_protocol.qpu_id

    def set_peer_positions(self, peer_qpu_id: int, positions: list) -> None:
        """Assign the communication qubits this peer's pool is stored on.

        The controller calls this before pre-fill.  The positions are chosen
        to be disjoint from every comm qubit the compiled circuit names, so
        pooled pairs cannot be clobbered by the circuit's own use of the
        register; ``QPUProtocol`` bridges the gap at consumption time with
        its comm-qubit remap table.  Capacity is clamped to the number of
        positions supplied, since each live pair occupies one qubit.

        Parameters
        ----------
        peer_qpu_id : int
            The peer whose pool storage is being assigned.
        positions : list[int]
            Communication-qubit positions reserved for this pairing.
        """
        cfg = self.peer_configs.get(peer_qpu_id)
        if cfg is None or not positions:
            return

        capacity = min(cfg["pool_size"], len(positions))
        cfg["comm_positions"] = list(positions[:capacity])
        cfg["pool_size"] = capacity

        # Rebuild the pool so its capacity matches the new allocation.
        self._pools[peer_qpu_id] = EPRPairPool(
            local_qpu_id=self.qpu_id,
            remote_qpu_id=peer_qpu_id,
            capacity=capacity,
            fidelity_tracker=self.fidelity_tracker,
        )

    def drop_peer(self, peer_qpu_id: int) -> None:
        """Remove a peer's pool and stop reserving its communication qubits.

        Called by the controller before pre-fill for QPU pairings the
        circuit never entangles, so those comm qubits stay available to the
        circuit-execution path.

        Parameters
        ----------
        peer_qpu_id : int
            The peer whose pool should be discarded.
        """
        self._pools.pop(peer_qpu_id, None)
        self.peer_configs.pop(peer_qpu_id, None)

    def has_usable_pair(self, peer_qpu_id: int, current_time_ns: float) -> bool:
        """Non-destructively test whether a usable pair exists for *peer_qpu_id*.

        ``QPUProtocol`` calls this *before* announcing readiness so it can
        tell the controller whether this side can be served from the pool.
        Only when **every** party to an entanglement label reports ``True``
        does the controller skip the BSM round entirely.

        Unlike :meth:`consume_pair` this leaves the pool untouched.

        Parameters
        ----------
        peer_qpu_id : int
            Remote QPU the pair must be shared with.
        current_time_ns : float
            Current simulation time, used for the fidelity check.

        Returns
        -------
        bool
        """
        if peer_qpu_id is None:
            return False

        pool = self._pools.get(peer_qpu_id)
        if pool is None:
            return False

        return pool.usable_count(current_time_ns) > 0

    # ── Slot bookkeeping (used by the refill scheduler) ───────────────────

    def holds_slot(self, peer_qpu_id: int, slot_id: int) -> bool:
        """Whether this pool still holds the pair for *slot_id*.

        Counts uncommitted halves too, so the scheduler never refills a slot
        whose round is only half-recorded.
        """
        pool = self._pools.get(peer_qpu_id)
        return pool is not None and slot_id in pool.occupied_slots()

    def commit_slot(self, peer_qpu_id: int, slot_id: int) -> bool:
        """Publish the half holding *slot_id* to consumption.

        Called by the controller once **both** endpoints have recorded the
        round, so the pair becomes selectable on the two sides at the same
        instant and the lowest-slot rule cannot diverge.

        Emits ``PAIR_GENERATED``, because *this* is the moment the pair
        becomes usable — a QPU blocked on an empty pool is waiting for
        availability, not for the herald that preceded it.
        """
        pool = self._pools.get(peer_qpu_id)
        if pool is None or not pool.commit_slot(slot_id):
            return False
        self.send_signal(self.PAIR_GENERATED, result=peer_qpu_id)
        return True

    def drop_slot(self, peer_qpu_id: int, slot_id: int) -> bool:
        """Discard the half holding *slot_id* after its partner failed.

        A half whose counterpart never arrived is entangled with nothing;
        leaving it in the pool would hand out a broken pair.
        """
        pool = self._pools.get(peer_qpu_id)
        if pool is None:
            return False
        removed = pool.drop_slot(slot_id)
        if removed is not None:
            self._stats["pairs_discarded"] += 1
            return True
        return False

    def usable_count(self, peer_qpu_id: int, current_time_ns: float) -> int:
        """Number of consumable pairs held for *peer_qpu_id*."""
        pool = self._pools.get(peer_qpu_id)
        return 0 if pool is None else pool.usable_count(current_time_ns)

    def usable_slots(self, peer_qpu_id: int, current_time_ns: float) -> set:
        """Slot ids currently consumable for *peer_qpu_id*.

        The controller intersects this across both endpoints to choose the
        slot they will consume together.
        """
        pool = self._pools.get(peer_qpu_id)
        return set() if pool is None else pool.usable_slots(current_time_ns)

    def consume_slot(
        self, peer_qpu_id: int, slot_id: int, current_time_ns: float
    ) -> Optional[EPRPairEntry]:
        """Take the specific pair *slot_id*, as directed by the controller.

        Consuming a *named* slot rather than independently selecting one is
        what keeps the two endpoints in step.  The original rule — "lowest
        available slot wins, applied identically on both sides" — held only
        while the pool was static.  Under continuous refill the two sides
        consume at slightly different instants, and a slot committed in
        between makes them choose differently; that surfaced as POOL DESYNC
        and randomised the output.
        """
        pool = self._pools.get(peer_qpu_id)
        if pool is None:
            return None
        pair = pool.consume_slot(slot_id, current_time_ns)
        if pair is not None:
            self._stats["pairs_consumed"] += 1
        return pair

    def setup_pools(self) -> None:
        """Create one :class:`EPRPairPool` per configured peer (idempotent)."""
        for peer_qpu_id, cfg in self.peer_configs.items():
            if peer_qpu_id in self._pools:
                continue
            self._pools[peer_qpu_id] = EPRPairPool(
                local_qpu_id=self.qpu_id,
                remote_qpu_id=peer_qpu_id,
                capacity=cfg["pool_size"],
                fidelity_tracker=self.fidelity_tracker,
            )
            log.info(
                "[%s|Factory] Pool ready: peer QPU_%d, capacity=%d, bsm=%s, "
                "comm_positions=%s",
                self.node.name, peer_qpu_id, cfg["pool_size"],
                cfg["bsm_label"], cfg["comm_positions"],
            )

    # ══════════════════════════════════════════════════════════════════════
    # Controller-driven pre-fill
    # ══════════════════════════════════════════════════════════════════════

    def _get_or_create_factory_worker(self) -> FactoryEntanglementWorker:
        """Return the node's single factory worker, creating it on first use.

        One worker per node — not per BSM — because in switched mode all
        BSMs deliver factory clock ticks and results on the same pair of
        switch-facing ports, and concurrent workers would steal each other's
        messages.
        """
        if self._worker is None:
            self._worker = FactoryEntanglementWorker(
                node=self.node,
                factory=self,
                q_switch=self.q_switch,
                qpu_label=self.qpu_protocol.qpu_label,
            )
            self._worker.start()
            log.debug(
                "[%s|Factory] Started FactoryEntanglementWorker",
                self.node.name,
            )
        return self._worker

    def _bsm_side(self, bsm_label: str) -> str:
        """Return whether this QPU feeds the BSM's left or right input."""
        bsm_inf = self.bsm_info.get(bsm_label, {})
        return (
            "left" if bsm_inf.get("left_qpu") == self.qpu_protocol.qpu_label
            else "right"
        )

    def arm_prefill(
        self,
        peer_qpu_id: int,
        job_id: str,
        position: int,
        peer_position: int,
        apply_corrections: bool,
        slot_id: int | None = None,
        bsm_label: str | None = None,
    ) -> FactoryEntanglementWorker:
        """Queue one pre-fill emission and return the worker that will run it.

        The controller calls this on *both* QPUs of a pair before triggering
        the shared BSM, then waits on the returned workers'
        ``ENTANGLEMENT_DONE`` signals.

        Parameters
        ----------
        peer_qpu_id : int
            The remote QPU of this pair.
        job_id : str
            Unique identifier for the round (used as the signal result).
        position : int
            Local communication-qubit memory position to emit from.
        peer_position : int
            Remote communication-qubit memory position (recorded for pair
            tracking so remote gates can address either end).
        apply_corrections : bool
            Whether this side applies the BSM-implied Pauli corrections.
        slot_id : int or None
            Shared index identifying this pair.  The controller passes the
            *same* value to both endpoints, which is how the two sides later
            agree on which pair they are consuming without exchanging any
            messages.
        bsm_label : str or None
            The BSM leased for this round.  A pairing may be served by
            several BSMs, in which case the scheduler picks whichever is
            free and both endpoints must be armed for *that* one.  Falls
            back to the peer's configured default when omitted.

        Returns
        -------
        FactoryEntanglementWorker
        """
        if bsm_label is None:
            bsm_label = self.peer_configs[peer_qpu_id]["bsm_label"]
        worker = self._get_or_create_factory_worker()
        worker.add_work({
            "job_id": job_id,
            "position": position,
            "peer_position": peer_position,
            "peer_qpu_id": peer_qpu_id,
            "bsm_label": bsm_label,
            "bsm_side": self._bsm_side(bsm_label),
            "apply_corrections": apply_corrections,
            "slot_id": slot_id,
        })
        return worker

    # ── Worker callbacks ──────────────────────────────────────────────────

    def record_pair(
        self,
        peer_qpu_id: int,
        comm_qubit_local: int,
        comm_qubit_remote: int,
        generation_time_ns: float,
        bsm_data,
        bsm_label: str,
        corrections_applied: bool,
        slot_id: int | None = None,
        committed: bool = True,
    ) -> None:
        """Store a freshly generated pair in the appropriate pool.

        Parameters
        ----------
        committed : bool
            ``False`` for mid-circuit refill, where the two halves are
            recorded at different times and must only become selectable
            together (see :attr:`EPRPairEntry.committed`).  Pre-fill sets
            ``True``: that phase finishes before any circuit command runs,
            so there is no window in which the sides could disagree.
        """
        pool = self._pools.get(peer_qpu_id)
        if pool is None:
            log.warning(
                "[%s|Factory] No pool for peer QPU_%s — discarding pair",
                self.node.name, peer_qpu_id,
            )
            return

        pool.add_pair(EPRPairEntry(
            comm_qubit_local=comm_qubit_local,
            comm_qubit_remote=comm_qubit_remote,
            generation_time_ns=generation_time_ns,
            bsm_data=bsm_data,
            bsm_label=bsm_label,
            corrections_applied=corrections_applied,
            slot_id=slot_id,
            committed=committed,
        ))
        self._stats["pairs_generated"] += 1
        self.send_signal(self.PAIR_GENERATED, result=peer_qpu_id)

    def record_failure(self, peer_qpu_id: int) -> None:
        """Account for a generation round that exhausted its retries."""
        self._stats["generation_failures"] += 1

    def record_job_outcome(self, job_id: str, success: bool) -> None:
        """Note whether *job_id* produced a pair on this side.

        The controller reads this after both endpoints signal completion.  A
        round only yields a usable pair when *both* sides succeeded, and the
        ``ENTANGLEMENT_DONE`` signal alone does not say which happened.
        """
        self.job_outcomes[job_id] = bool(success)

    def take_job_outcome(self, job_id: str) -> bool | None:
        """Consume and return the recorded outcome for *job_id*."""
        return self.job_outcomes.pop(job_id, None)

    # ══════════════════════════════════════════════════════════════════════
    # Public API — used by QPUProtocol during circuit execution
    # ══════════════════════════════════════════════════════════════════════

    def get_pool(self, peer_qpu_id: int) -> Optional[EPRPairPool]:
        """Return the pool for *peer_qpu_id*, or ``None`` if not configured."""
        return self._pools.get(peer_qpu_id)

    def consume_pair(
        self, peer_qpu_id: int, current_time_ns: float
    ) -> Optional[EPRPairEntry]:
        """Take the freshest usable pair for *peer_qpu_id*.

        Parameters
        ----------
        peer_qpu_id : int
            Remote QPU the pair must be shared with.  ``None`` or an
            unconfigured peer yields ``None`` so the caller falls back to
            on-demand generation.
        current_time_ns : float
            Current simulation time, used for the fidelity check.

        Returns
        -------
        EPRPairEntry or None
        """
        if peer_qpu_id is None:
            return None

        pool = self._pools.get(peer_qpu_id)
        if pool is None:
            return None

        pair = pool.consume_best(current_time_ns)
        if pair is not None:
            self._stats["pairs_consumed"] += 1
        return pair

    def return_pair(self, peer_qpu_id: int, pair: EPRPairEntry) -> None:
        """Put an unused pair back into its pool.

        Called when consumption is aborted after the pair was already taken
        — for instance when the compiler's nominated comm qubit is still
        redirected by an earlier, un-released pair.  The returned pair is
        undamaged, so restoring it keeps it available for a later request
        rather than leaking the qubit for the rest of the run.

        Parameters
        ----------
        peer_qpu_id : int
            Pool the pair was taken from.
        pair : EPRPairEntry
            The previously consumed entry.
        """
        pool = self._pools.get(peer_qpu_id)
        if pool is None:
            return
        pool.add_pair(pair)
        self._stats["pairs_consumed"] -= 1

    @property
    def reserved_positions(self) -> set:
        """Comm-qubit positions currently holding un-consumed pool pairs."""
        reserved: set[int] = set()
        for pool in self._pools.values():
            reserved |= pool.reserved_local_positions()
        return reserved

    @property
    def stats(self) -> dict:
        """Snapshot of factory counters plus live pool occupancy."""
        snapshot = dict(self._stats)
        snapshot["pool_sizes"] = {
            peer: pool.available_count() for peer, pool in self._pools.items()
        }
        return snapshot

    # ══════════════════════════════════════════════════════════════════════
    # Maintenance
    # ══════════════════════════════════════════════════════════════════════

    def _maintain_pools(self) -> None:
        """Evict pairs whose estimated fidelity dropped below threshold."""
        now = ns.sim_time()
        for pool in self._pools.values():
            discarded = pool.discard_stale(now)
            if discarded:
                self._stats["pairs_discarded"] += discarded

    def stop_workers(self) -> None:
        """Stop and forget the factory worker (called during teardown)."""
        if self._worker is not None:
            if self._worker.is_running:
                self._worker.stop()
            self._worker = None

    def run(self):
        """Publish the pools, then sweep them for staleness until torn down.

        The sweep is bounded.  Teardown normally stops this protocol, but it
        only runs once every QPU has reported done — and a QPU with no work
        never does.  An unbounded loop would then keep re-arming a timer, so
        the event queue never empties and ``sim_run()`` spins forever with no
        diagnostic.  ``max_maintain_rounds`` turns that into a bounded run and
        a warning naming the likely cause.
        """
        self.setup_pools()
        self.send_signal(self.POOLS_READY)

        rounds = 0
        while rounds < self.max_maintain_rounds:
            yield self.await_timer(duration=self.check_interval_ns)
            self._maintain_pools()
            rounds += 1

        log.warning(
            "[%s] EPR factory maintenance stopped after %d rounds (%.3g ns). "
            "Teardown never reached this protocol, which usually means a QPU "
            "never finished — e.g. a circuit that leaves one of the "
            "topology's QPUs idle.",
            self.node.name, rounds, ns.sim_time(),
        )

    # ── Representation ────────────────────────────────────────────────────

    def __repr__(self) -> str:
        pools = ", ".join(
            f"QPU_{peer}:{pool.available_count()}/{pool.capacity}"
            for peer, pool in sorted(self._pools.items())
        )
        return f"EPRFactoryProtocol({self.node.name}, pools=[{pools}])"
