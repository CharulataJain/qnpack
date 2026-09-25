#!/usr/bin/env python3
"""Unit tests for EPRPairPool and EPRPairEntry.

Standalone test script (not pytest) — run directly:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_epr_pool.py
"""
import sys

sys.path.insert(0, ".")
from qnpack.dqc.protocols.epr_pool import EPRPairEntry, EPRPairPool
from qnpack.dqc.protocols.fidelity import FidelityTracker

# ---------------------------------------------------------------------------
# Test infrastructure
# ---------------------------------------------------------------------------
_passed = 0
_failed = 0


def _run_test(name, func):
    """Run a single test function; print PASS/FAIL."""
    global _passed, _failed
    try:
        func()
        _passed += 1
        print(f"  PASS  {name}")
    except Exception as e:
        _failed += 1
        print(f"  FAIL  {name}: {e}")


def assert_eq(actual, expected, msg=""):
    if actual != expected:
        raise AssertionError(f"{msg}expected {expected!r}, got {actual!r}")


def assert_true(cond, msg=""):
    if not cond:
        raise AssertionError(msg or "condition is False")


def assert_false(cond, msg=""):
    if cond:
        raise AssertionError(msg or "condition is True")


def assert_none(val, msg=""):
    if val is not None:
        raise AssertionError(f"{msg}expected None, got {val!r}")


def assert_not_none(val, msg=""):
    if val is None:
        raise AssertionError(f"{msg}expected non-None, got None")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_tracker(T1=10000, T2=5000, min_fidelity=0.9):
    return FidelityTracker(T1=T1, T2=T2, min_fidelity=min_fidelity)


def _make_pool(capacity=3, T1=10000, T2=5000, min_fidelity=0.9):
    ft = _make_tracker(T1=T1, T2=T2, min_fidelity=min_fidelity)
    return EPRPairPool(local_qpu_id=1, remote_qpu_id=2, capacity=capacity,
                       fidelity_tracker=ft)


def _make_entry(local_pos=0, remote_pos=0, gen_time=0.0,
                bsm_data=None, bsm_label="bsm_1_2", slot_id=None):
    return EPRPairEntry(
        comm_qubit_local=local_pos,
        comm_qubit_remote=remote_pos,
        generation_time_ns=gen_time,
        bsm_data=bsm_data or [2],
        bsm_label=bsm_label,
        slot_id=slot_id,
    )


# ===========================================================================
# EPRPairEntry tests
# ===========================================================================

def test_entry_creation():
    """EPRPairEntry can be created with expected fields."""
    e = _make_entry(local_pos=3, remote_pos=5, gen_time=1000.0,
                    bsm_data=[3], bsm_label="bsm_x")
    assert_eq(e.comm_qubit_local, 3)
    assert_eq(e.comm_qubit_remote, 5)
    assert_eq(e.generation_time_ns, 1000.0)
    assert_eq(e.bsm_data, [3])
    assert_eq(e.bsm_label, "bsm_x")
    assert_false(e.corrections_applied)


def test_entry_to_buffer_entry():
    """to_buffer_entry() returns dict compatible with QPUProtocol."""
    e = _make_entry(local_pos=2, remote_pos=4, gen_time=5000.0,
                    bsm_data=[2])
    buf = e.to_buffer_entry()
    assert_eq(buf["success"], True)
    assert_eq(buf["bsm_data"], [2])
    assert_eq(buf["retries"], 0)
    assert_eq(buf["actual_emit"], 2, msg="actual_emit should be local pos: ")
    assert_eq(buf["ent_duration_ns"], 0.0)
    assert_eq(buf["generation_time"], 5000.0)


# ===========================================================================
# EPRPairPool — capacity and basic operations
# ===========================================================================

def test_pool_empty_initial():
    """Newly created pool should have 0 pairs."""
    pool = _make_pool(capacity=3)
    assert_eq(pool.available_count(), 0)
    assert_true(pool.needs_refill(), "Empty pool should need refill")
    assert_eq(pool.slots_needed(), 3)


def test_pool_add_pairs():
    """Adding pairs should increment available_count."""
    pool = _make_pool(capacity=3)
    pool.add_pair(_make_entry(local_pos=0, gen_time=100))
    assert_eq(pool.available_count(), 1)
    assert_true(pool.needs_refill(), "1/3 should still need refill")

    pool.add_pair(_make_entry(local_pos=1, gen_time=200))
    pool.add_pair(_make_entry(local_pos=2, gen_time=300))
    assert_eq(pool.available_count(), 3)
    assert_false(pool.needs_refill(), "3/3 should not need refill")
    assert_eq(pool.slots_needed(), 0)


def test_pool_capacity_eviction():
    """Adding beyond capacity evicts the oldest pair."""
    pool = _make_pool(capacity=2)
    e1 = _make_entry(local_pos=0, gen_time=100)
    e2 = _make_entry(local_pos=1, gen_time=200)
    e3 = _make_entry(local_pos=2, gen_time=300)

    pool.add_pair(e1)
    pool.add_pair(e2)
    assert_eq(pool.available_count(), 2)

    pool.add_pair(e3)  # should evict e1 (oldest)
    assert_eq(pool.available_count(), 2)

    # The remaining pairs should be e3 (newest) and e2
    positions = pool.reserved_local_positions()
    assert_true(2 in positions, f"e3 (pos=2) should be in pool: {positions}")
    assert_true(1 in positions, f"e2 (pos=1) should be in pool: {positions}")
    assert_false(0 in positions, f"e1 (pos=0) should have been evicted: {positions}")


# ===========================================================================
# EPRPairPool — consume_best
# ===========================================================================

def test_consume_best_returns_freshest():
    """consume_best should return the most recently generated pair."""
    pool = _make_pool(capacity=5)
    pool.add_pair(_make_entry(local_pos=0, gen_time=100))
    pool.add_pair(_make_entry(local_pos=1, gen_time=300))
    pool.add_pair(_make_entry(local_pos=2, gen_time=200))

    # At current_time=310, all pairs are very fresh (T1=10000, T2=5000)
    best = pool.consume_best(current_time_ns=310)
    assert_not_none(best, "Should return a pair")
    assert_eq(best.comm_qubit_local, 1, msg="Freshest pair (gen_time=300): ")
    assert_eq(pool.available_count(), 2, msg="Pool size after consume: ")


def test_consume_best_removes_pair():
    """Consumed pair should no longer be in the pool."""
    pool = _make_pool(capacity=3)
    pool.add_pair(_make_entry(local_pos=5, gen_time=100))

    pair = pool.consume_best(current_time_ns=100)
    assert_not_none(pair)
    assert_eq(pool.available_count(), 0)
    assert_false(5 in pool.reserved_local_positions())


def test_consume_best_empty_pool():
    """consume_best on an empty pool should return None."""
    pool = _make_pool(capacity=3)
    assert_none(pool.consume_best(current_time_ns=1000))


def test_consume_best_all_stale():
    """consume_best should return None when all pairs are stale."""
    # Use very short T2 so pairs go stale quickly
    pool = _make_pool(capacity=3, T1=10, T2=5, min_fidelity=0.9)
    pool.add_pair(_make_entry(local_pos=0, gen_time=0))
    pool.add_pair(_make_entry(local_pos=1, gen_time=1))

    # max_useful_age for T1=10,T2=5,min_fid=0.9 should be very small
    max_age = pool.fidelity_tracker.max_useful_age_ns()

    # Consume at a time well past the max useful age
    result = pool.consume_best(current_time_ns=max_age + 1000)
    assert_none(result, "All pairs should be stale")
    # Pool should be emptied
    assert_eq(pool.available_count(), 0, msg="Stale pairs should be cleared: ")


def test_consume_best_skips_stale():
    """consume_best should skip stale pairs and return a fresh one."""
    pool = _make_pool(capacity=5, T1=10000, T2=5000, min_fidelity=0.9)
    max_age = pool.fidelity_tracker.max_useful_age_ns()

    # Add an old pair and a fresh pair
    old_time = 0.0
    fresh_time = max_age + 100  # generated at a later time

    pool.add_pair(_make_entry(local_pos=0, gen_time=old_time))
    pool.add_pair(_make_entry(local_pos=1, gen_time=fresh_time))

    # Consume at time = fresh_time + 10 (so old is stale, new is fresh)
    current = fresh_time + 10
    best = pool.consume_best(current_time_ns=current)
    assert_not_none(best, "Fresh pair should be returned")
    assert_eq(best.comm_qubit_local, 1, msg="Should get the fresh pair: ")


# ===========================================================================
# EPRPairPool — discard_stale
# ===========================================================================

def test_discard_stale_removes_old():
    """discard_stale should remove pairs below fidelity threshold."""
    pool = _make_pool(capacity=5, T1=10, T2=5, min_fidelity=0.9)
    pool.add_pair(_make_entry(local_pos=0, gen_time=0))
    pool.add_pair(_make_entry(local_pos=1, gen_time=1))

    max_age = pool.fidelity_tracker.max_useful_age_ns()
    discarded = pool.discard_stale(current_time_ns=max_age + 1000)
    assert_eq(discarded, 2, msg="Both pairs should be discarded: ")
    assert_eq(pool.available_count(), 0)


def test_discard_stale_keeps_fresh():
    """discard_stale should keep pairs above fidelity threshold."""
    pool = _make_pool(capacity=5, T1=10000, T2=5000, min_fidelity=0.9)
    pool.add_pair(_make_entry(local_pos=0, gen_time=1000))
    pool.add_pair(_make_entry(local_pos=1, gen_time=1000))

    discarded = pool.discard_stale(current_time_ns=1001)
    assert_eq(discarded, 0, msg="Fresh pairs should not be discarded: ")
    assert_eq(pool.available_count(), 2)


def test_discard_stale_mixed():
    """discard_stale with a mix of fresh and stale pairs."""
    pool = _make_pool(capacity=5, T1=10000, T2=5000, min_fidelity=0.9)
    max_age = pool.fidelity_tracker.max_useful_age_ns()

    # Old pair
    pool.add_pair(_make_entry(local_pos=0, gen_time=0))
    # Fresh pair
    pool.add_pair(_make_entry(local_pos=1, gen_time=max_age + 100))

    current = max_age + 110
    discarded = pool.discard_stale(current_time_ns=current)
    assert_eq(discarded, 1, msg="Only old pair should be discarded: ")
    assert_eq(pool.available_count(), 1)
    assert_true(1 in pool.reserved_local_positions(),
                "Fresh pair (pos=1) should remain")


# ===========================================================================
# EPRPairPool — reserved_local_positions
# ===========================================================================

def test_reserved_local_positions():
    """reserved_local_positions should track comm qubit positions."""
    pool = _make_pool(capacity=5)
    assert_eq(pool.reserved_local_positions(), set())

    pool.add_pair(_make_entry(local_pos=3, gen_time=100))
    pool.add_pair(_make_entry(local_pos=7, gen_time=200))
    assert_eq(pool.reserved_local_positions(), {3, 7})

    # After consuming, position should be freed
    pool.consume_best(current_time_ns=200)
    positions = pool.reserved_local_positions()
    assert_eq(len(positions), 1, msg="One position should remain: ")


def test_reserved_positions_after_eviction():
    """Evicted pair's position should no longer be reserved."""
    pool = _make_pool(capacity=2)
    pool.add_pair(_make_entry(local_pos=0, gen_time=100))
    pool.add_pair(_make_entry(local_pos=1, gen_time=200))
    pool.add_pair(_make_entry(local_pos=2, gen_time=300))  # evicts pos=0

    positions = pool.reserved_local_positions()
    assert_false(0 in positions, f"Evicted pos=0 should not be reserved: {positions}")
    assert_true(1 in positions and 2 in positions,
                f"Remaining should be {{1, 2}}: {positions}")


# ===========================================================================
# EPRPairPool — ordering
# ===========================================================================

def test_pairs_sorted_newest_first():
    """Pairs should be stored newest-first after insertion."""
    pool = _make_pool(capacity=5)
    pool.add_pair(_make_entry(local_pos=0, gen_time=300))
    pool.add_pair(_make_entry(local_pos=1, gen_time=100))
    pool.add_pair(_make_entry(local_pos=2, gen_time=200))

    # Consuming should always return the newest available
    p1 = pool.consume_best(current_time_ns=301)
    assert_eq(p1.generation_time_ns, 300.0, msg="First consume: ")

    p2 = pool.consume_best(current_time_ns=301)
    assert_eq(p2.generation_time_ns, 200.0, msg="Second consume: ")

    p3 = pool.consume_best(current_time_ns=301)
    assert_eq(p3.generation_time_ns, 100.0, msg="Third consume: ")


# ===========================================================================
# EPRPairPool — repr
# ===========================================================================

def test_pool_repr():
    """__repr__ should include QPU ids and size/capacity."""
    pool = _make_pool(capacity=3)
    pool.add_pair(_make_entry(local_pos=0, gen_time=100))
    r = repr(pool)
    assert_true("1" in r and "2" in r, f"QPU ids not in repr: {r}")
    assert_true("1/3" in r, f"Size/capacity not in repr: {r}")


# ===========================================================================
# Slot-based two-sided agreement
# ===========================================================================

def test_entry_slot_id_defaults_none():
    """slot_id is optional and defaults to None."""
    assert_none(_make_entry().slot_id)
    assert_eq(_make_entry(slot_id=2).slot_id, 2)


def test_consume_best_prefers_lowest_slot():
    """Slot order wins over freshness, so both QPUs pick the same pair."""
    pool = _make_pool(capacity=3)
    # Deliberately add the newest pair with the highest slot: if selection
    # went by freshness this would be returned first.
    pool.add_pair(_make_entry(local_pos=19, gen_time=300.0, slot_id=2))
    pool.add_pair(_make_entry(local_pos=17, gen_time=100.0, slot_id=0))
    pool.add_pair(_make_entry(local_pos=18, gen_time=200.0, slot_id=1))

    got = pool.consume_best(current_time_ns=310.0)
    assert_not_none(got)
    assert_eq(got.slot_id, 0, msg="lowest slot should win: ")
    assert_eq(got.comm_qubit_local, 17)


def test_consume_best_slot_order_sequence():
    """Repeated consumption walks slots in ascending order."""
    pool = _make_pool(capacity=3)
    pool.add_pair(_make_entry(local_pos=19, gen_time=300.0, slot_id=2))
    pool.add_pair(_make_entry(local_pos=17, gen_time=100.0, slot_id=0))
    pool.add_pair(_make_entry(local_pos=18, gen_time=200.0, slot_id=1))

    order = [pool.consume_best(current_time_ns=310.0).slot_id
             for _ in range(3)]
    assert_eq(order, [0, 1, 2])


def test_consume_best_two_sides_agree():
    """Two independently-drained pools select counterpart halves.

    Mirrors the real topology: each side stores the pair on its own comm
    qubit and records the peer's.  The sides are filled in *different*
    orders and with different timestamps — as would happen under
    concurrent refill — so only slot ordering can keep them in step.
    """
    side_a = _make_pool(capacity=3)
    side_b = _make_pool(capacity=3)

    # slot -> (position on A, position on B); intentionally asymmetric.
    layout = {0: (19, 15), 1: (18, 16), 2: (17, 14)}

    for slot in (0, 1, 2):
        a_pos, b_pos = layout[slot]
        side_a.add_pair(_make_entry(local_pos=a_pos, remote_pos=b_pos,
                                    gen_time=100.0 * (slot + 1),
                                    slot_id=slot))
    for slot in (2, 0, 1):  # different insertion order
        a_pos, b_pos = layout[slot]
        side_b.add_pair(_make_entry(local_pos=b_pos, remote_pos=a_pos,
                                    gen_time=100.0 * (slot + 1) + 7.0,
                                    slot_id=slot))

    for _ in range(3):
        a = side_a.consume_best(current_time_ns=400.0)
        b = side_b.consume_best(current_time_ns=400.0)
        assert_eq(a.slot_id, b.slot_id, msg="slot agreement: ")
        assert_eq(a.comm_qubit_local, b.comm_qubit_remote,
                  msg="A's local must be B's remote: ")
        assert_eq(b.comm_qubit_local, a.comm_qubit_remote,
                  msg="B's local must be A's remote: ")


def test_consume_best_unslotted_falls_back_to_freshest():
    """Without slot ids the old freshest-first behaviour is preserved."""
    pool = _make_pool(capacity=3)
    pool.add_pair(_make_entry(local_pos=1, gen_time=100.0))
    pool.add_pair(_make_entry(local_pos=2, gen_time=300.0))
    pool.add_pair(_make_entry(local_pos=3, gen_time=200.0))

    got = pool.consume_best(current_time_ns=310.0)
    assert_eq(got.generation_time_ns, 300.0)


def test_consume_best_slotted_precedes_unslotted():
    """Slotted pairs are consumed before unslotted ones."""
    pool = _make_pool(capacity=3)
    pool.add_pair(_make_entry(local_pos=1, gen_time=500.0))          # newest
    pool.add_pair(_make_entry(local_pos=2, gen_time=100.0, slot_id=7))

    got = pool.consume_best(current_time_ns=510.0)
    assert_eq(got.slot_id, 7, msg="slotted pair should win despite age: ")


def test_consume_best_skips_stale_slot():
    """A stale low slot is discarded, not returned."""
    pool = _make_pool(capacity=3, T1=1000, T2=500, min_fidelity=0.9)
    pool.add_pair(_make_entry(local_pos=1, gen_time=0.0, slot_id=0))
    pool.add_pair(_make_entry(local_pos=2, gen_time=9000.0, slot_id=1))

    got = pool.consume_best(current_time_ns=9010.0)
    assert_not_none(got)
    assert_eq(got.slot_id, 1, msg="stale slot 0 should be skipped: ")
    assert_eq(pool.available_count(), 0, msg="stale pair should be evicted: ")


# ===========================================================================
# Runner
# ===========================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("EPRPairPool & EPRPairEntry Unit Tests")
    print("=" * 60)

    tests = [
        # EPRPairEntry
        ("EPRPairEntry creation", test_entry_creation),
        ("EPRPairEntry.to_buffer_entry()", test_entry_to_buffer_entry),
        # Pool basics
        ("Pool: empty initial state", test_pool_empty_initial),
        ("Pool: add pairs", test_pool_add_pairs),
        ("Pool: capacity eviction", test_pool_capacity_eviction),
        # consume_best
        ("consume_best: returns freshest", test_consume_best_returns_freshest),
        # slot-based agreement
        ("EPRPairEntry slot_id default", test_entry_slot_id_defaults_none),
        ("consume_best: prefers lowest slot", test_consume_best_prefers_lowest_slot),
        ("consume_best: slot order sequence", test_consume_best_slot_order_sequence),
        ("consume_best: two sides agree", test_consume_best_two_sides_agree),
        ("consume_best: unslotted -> freshest", test_consume_best_unslotted_falls_back_to_freshest),
        ("consume_best: slotted before unslotted", test_consume_best_slotted_precedes_unslotted),
        ("consume_best: skips stale slot", test_consume_best_skips_stale_slot),
        ("consume_best: removes pair", test_consume_best_removes_pair),
        ("consume_best: empty pool", test_consume_best_empty_pool),
        ("consume_best: all stale", test_consume_best_all_stale),
        ("consume_best: skips stale", test_consume_best_skips_stale),
        # discard_stale
        ("discard_stale: removes old", test_discard_stale_removes_old),
        ("discard_stale: keeps fresh", test_discard_stale_keeps_fresh),
        ("discard_stale: mixed", test_discard_stale_mixed),
        # reserved_local_positions
        ("reserved_local_positions", test_reserved_local_positions),
        ("reserved_positions after eviction", test_reserved_positions_after_eviction),
        # ordering
        ("pairs sorted newest-first", test_pairs_sorted_newest_first),
        # repr
        ("__repr__", test_pool_repr),
    ]

    for name, func in tests:
        _run_test(name, func)

    print()
    print("-" * 60)
    total = _passed + _failed
    if _failed == 0:
        print(f"All {_passed}/{total} tests passed!")
    else:
        print(f"FAILED: {_failed}/{total} tests failed")
        sys.exit(1)
