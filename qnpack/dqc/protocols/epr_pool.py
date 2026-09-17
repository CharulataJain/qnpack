"""
protocols/epr_pool.py
---------------------
Pre-generated EPR (Bell) pair storage for the EPR Pair Factory.

This module provides two data structures:

Classes
-------
    EPRPairEntry   — Immutable record for a single entangled Bell pair.
    EPRPairPool    — Bounded pool of Bell pairs between two QPUs, with
                     fidelity-aware consumption and automatic staleness
                     eviction.

An ``EPRPairPool`` is owned by a single QPU and holds pairs that have
been pre-generated with a specific remote QPU.  During circuit execution,
the QPU can *consume* the freshest available pair instead of performing
a blocking entanglement generation round.

The pool delegates fidelity estimation to a ``FidelityTracker`` instance
(see :mod:`qnpack.dqc.protocols.fidelity`).
"""

from __future__ import annotations

import logging
from dataclasses import dataclass, field
from typing import Optional

from qnpack.dqc.protocols.fidelity import FidelityTracker

log = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# EPR pair record
# ---------------------------------------------------------------------------

@dataclass
class EPRPairEntry:
    """Record for a single pre-generated entangled Bell pair.

    Attributes
    ----------
    comm_qubit_local : int
        Local communication-qubit memory position (0–19).
    comm_qubit_remote : int
        Remote QPU's communication-qubit memory position (0–19).
    generation_time_ns : float
        Simulation time (``ns.sim_time()``) when the pair was created.
    bsm_data : list
        Bell-state measurement outcome from the BSM detector (e.g. ``[2]``
        or ``[3]``).
    bsm_label : str
        Identifier of the BSM channel that was used for generation.
    corrections_applied : bool
        Whether Pauli corrections corresponding to the BSM outcome have
        already been applied to the local qubit.
    slot_id : int or None
        Index of the generation round that produced this pair.  **Both
        halves of the same Bell pair carry the same ``slot_id``**, which is
        what lets the two QPUs agree on which pair they are consuming
        without exchanging any messages: each side selects the lowest
        available ``slot_id`` and is guaranteed to pick its partner's
        counterpart.

        This makes explicit an agreement that was previously implicit in
        generation-time ordering — a property that only held because
        pre-fill is strictly serialised, and which would silently break
        under concurrent mid-circuit refill (the two sides record slightly
        different ``generation_time_ns`` for the same pair, so freshness
        ordering can diverge).  ``None`` means "unslotted", in which case
        selection falls back to freshest-first.
    committed : bool
        Whether this half may be consumed yet.

        The two halves of a refilled pair are recorded at slightly
        different times, because each side's herald travels its own
        classical channel.  In that window one pool holds the new slot and
        the other does not, so the independent "lowest slot wins" rule
        would pick *different* slots on the two sides — a desync produced
        purely by timing.

        A refilled pair therefore enters its pool uncommitted and invisible
        to selection.  The controller, which learns when **both** halves
        have been recorded, commits the two of them together, so the pair
        appears on both sides at the same instant.  Pre-fill pairs are
        committed on arrival: that phase completes entirely before any
        circuit command runs.
    """

    comm_qubit_local: int
    comm_qubit_remote: int
    generation_time_ns: float
    bsm_data: list
    bsm_label: str
    corrections_applied: bool = False
    slot_id: int | None = None
    committed: bool = True

    def to_buffer_entry(self) -> dict:
        """Convert to the dict format expected by ``QPUProtocol.bell_pair_buffer``.

        Returns
        -------
        dict
            A dictionary compatible with the existing entanglement result
            format used throughout the DQC simulation.
        """
        return {
            "success": True,
            "bsm_data": self.bsm_data,
            "retries": 0,
            "actual_emit": self.comm_qubit_local,
            "ent_duration_ns": 0.0,  # pre-generated, no blocking latency
            "generation_time": self.generation_time_ns,
        }


# ---------------------------------------------------------------------------
# EPR pair pool
# ---------------------------------------------------------------------------

class EPRPairPool:
    """Bounded pool of pre-generated Bell pairs between two QPUs.

    Pairs are stored in order of generation time (newest first) so that
    ``consume_best`` always returns the freshest available pair.  Stale
    pairs (those whose estimated fidelity has dropped below the tracker's
    ``min_fidelity``) can be bulk-evicted with ``discard_stale``.

    Parameters
    ----------
    local_qpu_id : int
        Identifier of the QPU that owns this pool.
    remote_qpu_id : int
        Identifier of the remote QPU this pool is paired with.
    capacity : int
        Maximum number of pairs the pool should hold.
    fidelity_tracker : FidelityTracker
        Tracker used to evaluate pair freshness.
    """

    def __init__(
        self,
        local_qpu_id: int,
        remote_qpu_id: int,
        capacity: int,
        fidelity_tracker: FidelityTracker,
    ):
        self.local_qpu_id = local_qpu_id
        self.remote_qpu_id = remote_qpu_id
        self.capacity = capacity
        self.fidelity_tracker = fidelity_tracker

        # Pairs sorted newest-first (descending generation_time_ns)
        self._pairs: list[EPRPairEntry] = []

        log.info(
            "EPRPairPool created: QPU %d ↔ QPU %d, capacity=%d, "
            "min_fidelity=%.3f",
            local_qpu_id, remote_qpu_id, capacity,
            fidelity_tracker.min_fidelity,
        )

    # ------------------------------------------------------------------
    # Mutators
    # ------------------------------------------------------------------

    def add_pair(self, entry: EPRPairEntry) -> None:
        """Add a newly generated pair to the pool.

        The pair is inserted in generation-time order (newest first).
        If the pool is already at capacity, the oldest pair is silently
        evicted to make room.

        Parameters
        ----------
        entry : EPRPairEntry
            The Bell-pair record to add.
        """
        if len(self._pairs) >= self.capacity:
            evicted = self._pairs.pop()  # remove oldest (last element)
            log.debug(
                "Pool QPU %d↔%d at capacity; evicted oldest pair "
                "(gen_time=%.1f, local_pos=%d)",
                self.local_qpu_id, self.remote_qpu_id,
                evicted.generation_time_ns, evicted.comm_qubit_local,
            )

        # Keep sorted newest-first; typically the new pair lands at index 0.
        inserted = False
        for i, existing in enumerate(self._pairs):
            if entry.generation_time_ns >= existing.generation_time_ns:
                self._pairs.insert(i, entry)
                inserted = True
                break
        if not inserted:
            self._pairs.append(entry)

        log.debug(
            "Pool QPU %d↔%d: added pair (gen_time=%.1f, local_pos=%d, "
            "bsm=%s); pool_size=%d",
            self.local_qpu_id, self.remote_qpu_id,
            entry.generation_time_ns, entry.comm_qubit_local,
            entry.bsm_data, len(self._pairs),
        )

    def consume_best(self, current_time_ns: float) -> Optional[EPRPairEntry]:
        """Remove and return the next usable pair, discarding stale ones.

        Selection is **slot-ordered**: among the committed pairs still above
        ``min_fidelity``, the one with the lowest ``slot_id`` wins.  Both
        halves of a Bell pair share a ``slot_id``, so two QPUs applying this
        rule independently always choose counterpart halves — the agreement
        needs no negotiation, only a deterministic rule and identical slot
        numbering, both of which the controller establishes at generation.

        Uncommitted pairs are skipped: a refilled pair is only half-visible
        until both endpoints have recorded it, and consuming one side early
        would pair it against nothing (see :attr:`EPRPairEntry.committed`).

        Pairs without a ``slot_id`` sort after all slotted ones and fall
        back to freshest-first among themselves.

        Parameters
        ----------
        current_time_ns : float
            Current simulation time in nanoseconds.

        Returns
        -------
        EPRPairEntry or None
            The next usable pair by slot order, or ``None`` if no pair
            meets the fidelity threshold.
        """
        fresh: list[tuple[int, EPRPairEntry]] = []
        stale_indices: list[int] = []

        for i, pair in enumerate(self._pairs):
            if self.fidelity_tracker.is_stale(
                pair.generation_time_ns, current_time_ns
            ):
                stale_indices.append(i)
            elif pair.committed:
                fresh.append((i, pair))

        # Drop stale entries regardless of whether a usable pair was found.
        for idx in reversed(stale_indices):
            removed = self._pairs.pop(idx)
            log.debug(
                "Pool QPU %d↔%d: discarded stale pair during consume "
                "(gen_time=%.1f, local_pos=%d, slot=%s)",
                self.local_qpu_id, self.remote_qpu_id,
                removed.generation_time_ns, removed.comm_qubit_local,
                removed.slot_id,
            )

        if not fresh:
            log.debug(
                "Pool QPU %d↔%d: no usable pair available at t=%.1f",
                self.local_qpu_id, self.remote_qpu_id, current_time_ns,
            )
            return None

        # Lowest slot first; unslotted pairs last, freshest among them.
        _, chosen = min(
            fresh,
            key=lambda item: (
                item[1].slot_id is None,
                item[1].slot_id if item[1].slot_id is not None else 0,
                -item[1].generation_time_ns,
            ),
        )
        self._pairs.remove(chosen)

        age = current_time_ns - chosen.generation_time_ns
        fidelity = self.fidelity_tracker.estimated_fidelity(age)
        log.info(
            "Pool QPU %d↔%d: consumed pair (slot=%s, gen_time=%.1f, "
            "age=%.1f ns, est_fidelity=%.4f, local_pos=%d, remote_pos=%d); "
            "pool_size=%d",
            self.local_qpu_id, self.remote_qpu_id, chosen.slot_id,
            chosen.generation_time_ns, age, fidelity,
            chosen.comm_qubit_local, chosen.comm_qubit_remote,
            len(self._pairs),
        )
        return chosen

    def discard_stale(self, current_time_ns: float) -> int:
        """Remove all pairs below the fidelity threshold.

        Parameters
        ----------
        current_time_ns : float
            Current simulation time in nanoseconds.

        Returns
        -------
        int
            Number of pairs that were discarded.
        """
        original_count = len(self._pairs)
        self._pairs = [
            p for p in self._pairs
            if not self.fidelity_tracker.is_stale(
                p.generation_time_ns, current_time_ns
            )
        ]
        discarded = original_count - len(self._pairs)
        if discarded > 0:
            log.info(
                "Pool QPU %d↔%d: discarded %d stale pairs at t=%.1f; "
                "pool_size=%d",
                self.local_qpu_id, self.remote_qpu_id,
                discarded, current_time_ns, len(self._pairs),
            )
        return discarded

    # ------------------------------------------------------------------
    # Queries
    # ------------------------------------------------------------------

    def available_count(self) -> int:
        """Number of pairs currently in pool (including potentially stale ones).

        Returns
        -------
        int
            Current pool size.
        """
        return len(self._pairs)

    def usable_count(self, current_time_ns: float) -> int:
        """Number of pairs that :meth:`consume_best` would actually return."""
        return sum(
            1 for p in self._pairs
            if p.committed
            and not self.fidelity_tracker.is_stale(
                p.generation_time_ns, current_time_ns
            )
        )

    def consume_slot(
        self, slot_id: int, current_time_ns: float
    ) -> Optional[EPRPairEntry]:
        """Remove and return the committed pair holding *slot_id*.

        Used when an external authority (the controller) has already chosen
        which slot both endpoints will consume.  That removes the need for
        the two sides to arrive at the same choice independently — a
        property that does not survive continuous refill, because each side
        consumes at a slightly different instant and a slot committed in
        between changes what the later one sees.

        Returns ``None`` if the slot is absent, uncommitted, or stale, so
        the caller can fall back rather than consume a broken pair.
        """
        for i, pair in enumerate(self._pairs):
            if pair.slot_id != slot_id:
                continue
            if not pair.committed:
                return None
            if self.fidelity_tracker.is_stale(
                pair.generation_time_ns, current_time_ns
            ):
                self._pairs.pop(i)
                return None
            chosen = self._pairs.pop(i)
            age = current_time_ns - chosen.generation_time_ns
            log.info(
                "Pool QPU %d↔%d: consumed slot %s (gen_time=%.1f, age=%.1f ns, "
                "est_fidelity=%.4f, local_pos=%d, remote_pos=%d); pool_size=%d",
                self.local_qpu_id, self.remote_qpu_id, slot_id,
                chosen.generation_time_ns, age,
                self.fidelity_tracker.estimated_fidelity(age),
                chosen.comm_qubit_local, chosen.comm_qubit_remote,
                len(self._pairs),
            )
            return chosen
        return None

    def usable_slots(self, current_time_ns: float) -> set[int]:
        """Slot ids that :meth:`consume_slot` would currently return."""
        return {
            p.slot_id for p in self._pairs
            if p.slot_id is not None and p.committed
            and not self.fidelity_tracker.is_stale(
                p.generation_time_ns, current_time_ns
            )
        }

    def commit_slot(self, slot_id: int) -> bool:
        """Make the half holding *slot_id* visible to consumption.

        Returns ``True`` when a pair was committed by this call, so the
        caller can tell a real commit from a repeat.
        """
        for pair in self._pairs:
            if pair.slot_id == slot_id and not pair.committed:
                pair.committed = True
                log.debug(
                    "Pool QPU %d↔%d: committed slot %s (local_pos=%d)",
                    self.local_qpu_id, self.remote_qpu_id,
                    slot_id, pair.comm_qubit_local,
                )
                return True
        return False

    def drop_slot(self, slot_id: int) -> Optional[EPRPairEntry]:
        """Remove the pair holding *slot_id*, committed or not.

        Used when the partner half failed to materialise: a lone half is
        entangled with nothing and must not stay in the pool.
        """
        for i, pair in enumerate(self._pairs):
            if pair.slot_id == slot_id:
                removed = self._pairs.pop(i)
                log.debug(
                    "Pool QPU %d↔%d: dropped slot %s (local_pos=%d)",
                    self.local_qpu_id, self.remote_qpu_id,
                    slot_id, removed.comm_qubit_local,
                )
                return removed
        return None

    def occupied_slots(self) -> set[int]:
        """Slot ids currently held, including uncommitted ones."""
        return {p.slot_id for p in self._pairs if p.slot_id is not None}

    def needs_refill(self) -> bool:
        """True if the pool is below its target capacity.

        Returns
        -------
        bool
        """
        return len(self._pairs) < self.capacity

    def slots_needed(self) -> int:
        """Number of new pairs needed to reach capacity.

        Returns
        -------
        int
            Non-negative count of empty slots.
        """
        return max(0, self.capacity - len(self._pairs))

    def reserved_local_positions(self) -> set[int]:
        """Set of local comm-qubit positions currently held by pool entries.

        These positions should not be used for other entanglement
        operations while their pairs remain in the pool.

        Returns
        -------
        set of int
            Local communication-qubit memory positions in use.
        """
        return {p.comm_qubit_local for p in self._pairs}

    # ------------------------------------------------------------------
    # Representation
    # ------------------------------------------------------------------

    def __repr__(self) -> str:
        return (
            f"EPRPairPool(QPU {self.local_qpu_id}↔{self.remote_qpu_id}, "
            f"size={len(self._pairs)}/{self.capacity})"
        )
