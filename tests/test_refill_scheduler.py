#!/usr/bin/env python3
"""Unit tests for the BSM leasing rules that govern parallel refill.

``EntanglementQueue`` is the single arbiter for entanglement generation:
pre-fill, continuous refill, and the on-demand path all take their BSMs from
it.  Two hardware constraints make that necessary, and they are what these
tests pin down:

* **One round per BSM.**  A BSM has a single detector and a single gated
  window, so two overlapping rounds make the herald unattributable.
* **One emission per QPU.**  A QPU emits from one comm qubit into one
  quantum port, so a QPU cannot take part in two rounds at once.

The bundled topology wires exactly one BSM to each QPU pairing, so added
BSMs cannot be exercised end to end.  They are decidable here: the queue is
pure bookkeeping, and this is where "more BSMs means more parallelism"
either holds or does not.

Usage:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_refill_scheduler.py
"""

import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from qnpack.dqc.models.qswitch import EntanglementQueue  # noqa: E402


results = []


def check(name, condition, detail=""):
    results.append((name, bool(condition), detail))
    mark = "PASS" if condition else "FAIL"
    print(f"  {mark}  {name}" + (f" — {detail}" if detail and not condition else ""))


# ---------------------------------------------------------------------------

def test_one_request_per_bsm():
    """A leased BSM is not handed out again until the round completes."""
    q = EntanglementQueue(["BSM-AB"])
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB"})
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB"})

    first = q.get_next_assignments()
    check("one BSM serves one round at a time", len(first) == 1,
          f"got {len(first)} assignments")

    second = q.get_next_assignments()
    check("second round defers while the BSM is leased", second == [],
          f"got {second}")

    q.complete_request("BSM-AB")
    third = q.get_next_assignments()
    check("round runs once the BSM is released", len(third) == 1,
          f"got {len(third)}")


def test_qpu_conflict_defers():
    """Two rounds sharing a QPU never run together, even with BSMs spare."""
    q = EntanglementQueue(["BSM-AB", "BSM-CA"])
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB"})
    q.add_request("QPU_1", "QPU_3", allowed_bsms={"BSM-CA"})

    batch = q.get_next_assignments()
    check("shared QPU forces serialisation despite a free BSM",
          len(batch) == 1, f"got {len(batch)} assignments")


def test_disjoint_pairs_run_in_parallel():
    """Independent pairings on distinct BSMs are batched together."""
    q = EntanglementQueue(["BSM-AB", "BSM-CD"])
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB"})
    q.add_request("QPU_3", "QPU_4", allowed_bsms={"BSM-CD"})

    batch = q.get_next_assignments()
    check("disjoint pairings run in one batch", len(batch) == 2,
          f"got {len(batch)} assignments")


def test_multiple_bsms_per_pairing_lift_throughput():
    """A pairing wired to several BSMs still serialises — on the QPUs.

    This is the constraint that actually bounds a single pairing: extra BSMs
    do not help it, because both of its QPUs are busy for the whole round.
    Added BSMs pay off across *different* pairings, which
    ``test_disjoint_pairs_run_in_parallel`` covers.
    """
    q = EntanglementQueue(["BSM-AB-1", "BSM-AB-2"])
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB-1", "BSM-AB-2"})
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB-1", "BSM-AB-2"})

    batch = q.get_next_assignments()
    check("one pairing cannot use two BSMs at once", len(batch) == 1,
          f"got {len(batch)} assignments")

    # But it may use *either*, so a busy BSM does not block it.
    leased = batch[0][1]
    q2 = EntanglementQueue(["BSM-AB-1", "BSM-AB-2"])
    q2.available_bsms.discard(leased)          # pretend the circuit took it
    q2.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB-1", "BSM-AB-2"})
    alt = q2.get_next_assignments()
    check("pairing falls back to its other BSM", len(alt) == 1,
          f"got {len(alt)} with {leased} unavailable")
    if alt:
        check("the alternative BSM is the free one", alt[0][1] != leased,
              f"picked {alt[0][1]}, which was meant to be busy")


def test_unreachable_bsm_is_never_assigned():
    """A request is never given a BSM with no path to its endpoints."""
    q = EntanglementQueue(["BSM-CD"])
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB"})

    batch = q.get_next_assignments()
    check("request waits rather than take an unreachable BSM", batch == [],
          f"got {batch}")
    check("request stays pending", q.has_pending())


def test_clear_pending_keeps_active_leases():
    """Dropping stale pending work must not release an in-flight lease."""
    q = EntanglementQueue(["BSM-AB", "BSM-CD"])
    q.add_request("QPU_1", "QPU_2", allowed_bsms={"BSM-AB"})
    active = q.get_next_assignments()

    q.add_request("QPU_3", "QPU_4", allowed_bsms={"BSM-CD"})
    dropped = q.clear_pending()

    check("pending work is discarded", dropped == 1, f"dropped {dropped}")
    check("active lease survives", len(q.active_requests) == len(active) == 1)
    check("leased BSM is still held", "BSM-AB" not in q.available_bsms)


def test_deterministic_bsm_choice():
    """Identical schedules must assign identically across runs."""
    picks = set()
    for _ in range(20):
        q = EntanglementQueue(["BSM-AB-1", "BSM-AB-2", "BSM-AB-3"])
        q.add_request("QPU_1", "QPU_2",
                      allowed_bsms={"BSM-AB-1", "BSM-AB-2", "BSM-AB-3"})
        picks.add(q.get_next_assignments()[0][1])

    check("BSM selection is deterministic", len(picks) == 1,
          f"saw {sorted(picks)} across 20 runs")


def main():
    print("\n" + "=" * 68)
    print("  REFILL SCHEDULER — BSM LEASING RULES")
    print("=" * 68 + "\n")

    for fn in (
        test_one_request_per_bsm,
        test_qpu_conflict_defers,
        test_disjoint_pairs_run_in_parallel,
        test_multiple_bsms_per_pairing_lift_throughput,
        test_unreachable_bsm_is_never_assigned,
        test_clear_pending_keeps_active_leases,
        test_deterministic_bsm_choice,
    ):
        print(f"{fn.__name__}:")
        fn()
        print()

    failed = [r for r in results if not r[1]]
    print("=" * 68)
    if failed:
        print(f"  ✗ {len(failed)}/{len(results)} checks FAILED")
        print("=" * 68 + "\n")
        return 1
    print(f"  ✓ all {len(results)} checks passed")
    print("=" * 68 + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
