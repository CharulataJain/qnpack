#!/usr/bin/env python3
"""Unit tests for FidelityTracker.

Standalone test script (not pytest) — run directly:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_fidelity.py
"""
import sys
import math

sys.path.insert(0, ".")
from qnpack.dqc.protocols.fidelity import FidelityTracker

# ---------------------------------------------------------------------------
# Test infrastructure
# ---------------------------------------------------------------------------
_passed = 0
_failed = 0
_test_names = []


def _run_test(name, func):
    """Run a single test function; print PASS/FAIL."""
    global _passed, _failed
    _test_names.append(name)
    try:
        func()
        _passed += 1
        print(f"  PASS  {name}")
    except Exception as e:
        _failed += 1
        print(f"  FAIL  {name}: {e}")


def assert_close(actual, expected, tol=1e-6, msg=""):
    """Assert that actual ≈ expected within tolerance."""
    if abs(actual - expected) > tol:
        raise AssertionError(
            f"{msg}expected ≈ {expected}, got {actual} "
            f"(diff={abs(actual - expected):.2e}, tol={tol})"
        )


def assert_true(cond, msg=""):
    if not cond:
        raise AssertionError(msg or "condition is False")


def assert_false(cond, msg=""):
    if cond:
        raise AssertionError(msg or "condition is True")


def assert_raises(exc_type, func, *args, **kwargs):
    try:
        func(*args, **kwargs)
    except exc_type:
        return
    raise AssertionError(f"Expected {exc_type.__name__} but no exception raised")


# ===========================================================================
# Test cases
# ===========================================================================

def test_fidelity_at_time_zero():
    """F(0) should always be 1.0."""
    ft = FidelityTracker(T1=10000, T2=5000)
    assert_close(ft.estimated_fidelity(0), 1.0, msg="F(0): ")
    assert_close(ft.estimated_fidelity(-5), 1.0, msg="F(neg): ")


def test_fidelity_decays_over_time():
    """F(t) < 1.0 for t > 0."""
    ft = FidelityTracker(T1=10000, T2=5000)
    for t in [1, 100, 1000, 5000, 10000]:
        f = ft.estimated_fidelity(t)
        assert_true(f < 1.0, f"F({t})={f} should be < 1.0")
        assert_true(f >= 0.25, f"F({t})={f} should be >= 0.25")


def test_fidelity_asymptote():
    """F(t) → 0.25 as t → ∞."""
    ft = FidelityTracker(T1=10000, T2=5000)
    f_large = ft.estimated_fidelity(1e12)
    assert_close(f_large, 0.25, tol=1e-4, msg="F(∞): ")


def test_fidelity_monotone_decreasing():
    """Fidelity should monotonically decrease over time."""
    ft = FidelityTracker(T1=10000, T2=5000)
    times = [0, 10, 100, 500, 1000, 2000, 5000, 10000, 50000, 1e8]
    fidelities = [ft.estimated_fidelity(t) for t in times]
    for i in range(1, len(fidelities)):
        assert_true(
            fidelities[i] <= fidelities[i - 1],
            f"F({times[i]})={fidelities[i]} > F({times[i-1]})={fidelities[i-1]}",
        )


def test_max_useful_age_basic():
    """max_useful_age should give F(t) ≈ min_fidelity at the boundary."""
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    age = ft.max_useful_age_ns()

    # F(max_useful_age) ≈ 0.9
    f_at_age = ft.estimated_fidelity(age)
    assert_close(f_at_age, 0.9, tol=0.01, msg="F(max_age): ")

    # F(max_useful_age - 1) > 0.9
    f_before = ft.estimated_fidelity(max(0, age - 1))
    assert_true(f_before >= 0.9, f"F(age-1)={f_before} should be >= 0.9")

    # F(max_useful_age + 10) < 0.9  (use +10 for numerical safety)
    f_after = ft.estimated_fidelity(age + 10)
    assert_true(f_after < 0.9, f"F(age+10)={f_after} should be < 0.9")


def test_max_useful_age_cached():
    """max_useful_age should be cached after first call."""
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    age1 = ft.max_useful_age_ns()
    age2 = ft.max_useful_age_ns()
    assert_close(age1, age2, tol=0, msg="Cache: ")


def test_is_stale_fresh_pair():
    """A just-created pair should not be stale."""
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    assert_false(
        ft.is_stale(generation_time_ns=1000, current_time_ns=1000),
        "Pair at age=0 should not be stale",
    )
    assert_false(
        ft.is_stale(generation_time_ns=1000, current_time_ns=1001),
        "Pair at age=1 should not be stale",
    )


def test_is_stale_old_pair():
    """A very old pair should be stale."""
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    age = ft.max_useful_age_ns()
    assert_true(
        ft.is_stale(generation_time_ns=0, current_time_ns=age + 100),
        f"Pair at age={age + 100} should be stale",
    )


def test_is_stale_negative_age():
    """Negative age (generation in the future) should not be stale."""
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    assert_false(
        ft.is_stale(generation_time_ns=2000, current_time_ns=1000),
        "Negative age should not be stale",
    )


def test_asymmetric_equal_params():
    """Asymmetric formula with equal params should match symmetric formula."""
    ft = FidelityTracker(T1=10000, T2=5000)
    for t in [0, 100, 1000, 5000, 10000]:
        sym = ft.estimated_fidelity(t)
        asym = FidelityTracker.estimated_fidelity_asymmetric(
            age_ns_A=t, age_ns_B=t,
            T1_A=10000, T2_A=5000,
            T1_B=10000, T2_B=5000,
        )
        assert_close(sym, asym, tol=1e-10, msg=f"t={t}: ")


def test_asymmetric_different_params():
    """Asymmetric formula with different T1/T2 per side."""
    # Side A: T1=20000, T2=10000; Side B: T1=10000, T2=5000
    # At t=0 for both, F should be 1.0
    f0 = FidelityTracker.estimated_fidelity_asymmetric(
        age_ns_A=0, age_ns_B=0,
        T1_A=20000, T2_A=10000,
        T1_B=10000, T2_B=5000,
    )
    assert_close(f0, 1.0, msg="Asym F(0,0): ")

    # At large time, should approach 0.25
    f_inf = FidelityTracker.estimated_fidelity_asymmetric(
        age_ns_A=1e12, age_ns_B=1e12,
        T1_A=20000, T2_A=10000,
        T1_B=10000, T2_B=5000,
    )
    assert_close(f_inf, 0.25, tol=1e-4, msg="Asym F(∞,∞): ")

    # With only one side aging, fidelity should be between 0.25 and 1.0
    f_half = FidelityTracker.estimated_fidelity_asymmetric(
        age_ns_A=5000, age_ns_B=0,
        T1_A=20000, T2_A=10000,
        T1_B=10000, T2_B=5000,
    )
    assert_true(0.25 < f_half < 1.0, f"Asym half-aged: F={f_half}")


def test_asymmetric_different_ages():
    """Asymmetric formula with different storage durations."""
    # Side A stored for 1000 ns, Side B stored for 5000 ns
    f = FidelityTracker.estimated_fidelity_asymmetric(
        age_ns_A=1000, age_ns_B=5000,
        T1_A=10000, T2_A=5000,
        T1_B=10000, T2_B=5000,
    )
    # Should be between fully fresh and fully stale
    assert_true(0.25 < f < 1.0, f"Different ages: F={f}")

    # Should be worse than same-time symmetric at 1000 ns
    f_sym_short = FidelityTracker.estimated_fidelity_asymmetric(
        age_ns_A=1000, age_ns_B=1000,
        T1_A=10000, T2_A=5000,
        T1_B=10000, T2_B=5000,
    )
    assert_true(f < f_sym_short, f"Longer B should lower fidelity: {f} vs {f_sym_short}")


def test_edge_very_large_t1_t2():
    """Very large T1/T2 (effectively infinite coherence)."""
    ft = FidelityTracker(T1=1e15, T2=1e15, min_fidelity=0.9)
    # Even at 1 second = 1e9 ns, fidelity should be ~1.0
    f = ft.estimated_fidelity(1e9)
    assert_close(f, 1.0, tol=1e-4, msg="Large T1/T2 at 1s: ")

    # max_useful_age should be very large
    age = ft.max_useful_age_ns()
    assert_true(age > 1e12, f"max_useful_age={age} should be > 1e12 ns")


def test_edge_very_small_t1_t2():
    """Very small T1/T2 (rapid decoherence)."""
    ft = FidelityTracker(T1=10, T2=5, min_fidelity=0.9)
    # At t=100 ns, fidelity should be essentially 0.25
    f = ft.estimated_fidelity(100)
    assert_close(f, 0.25, tol=0.01, msg="Small T1/T2 at 100ns: ")

    # max_useful_age should be very small
    age = ft.max_useful_age_ns()
    assert_true(age < 100, f"max_useful_age={age} should be < 100 ns")


def test_edge_min_fidelity_near_025():
    """min_fidelity just above 0.25 — max_useful_age should be much larger than
    for higher thresholds."""
    ft_high = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    ft_low = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.26)
    age_high = ft_high.max_useful_age_ns()
    age_low = ft_low.max_useful_age_ns()
    # Lower threshold → longer useful life (at least 3x longer)
    assert_true(
        age_low > age_high * 3,
        f"min_fid=0.26 age ({age_low:.1f}) should be >> min_fid=0.9 age ({age_high:.1f})",
    )


def test_validation_t1_negative():
    """Negative T1 should raise ValueError."""
    assert_raises(ValueError, FidelityTracker, T1=-100, T2=50)


def test_validation_t2_too_large():
    """T2 > 2*T1 should raise ValueError."""
    assert_raises(ValueError, FidelityTracker, T1=100, T2=300)


def test_validation_min_fidelity_out_of_range():
    """min_fidelity outside (0, 1) should raise ValueError."""
    assert_raises(ValueError, FidelityTracker, T1=100, T2=50, min_fidelity=0.0)
    assert_raises(ValueError, FidelityTracker, T1=100, T2=50, min_fidelity=1.0)
    assert_raises(ValueError, FidelityTracker, T1=100, T2=50, min_fidelity=-0.1)
    assert_raises(ValueError, FidelityTracker, T1=100, T2=50, min_fidelity=1.5)


def test_repr():
    """__repr__ should include T1, T2, min_fidelity."""
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    r = repr(ft)
    assert_true("10000" in r, f"T1 not in repr: {r}")
    assert_true("5000" in r, f"T2 not in repr: {r}")
    assert_true("0.9" in r, f"min_fidelity not in repr: {r}")


def test_t2_equals_2t1():
    """T2 = 2*T1 is the boundary — should be accepted."""
    ft = FidelityTracker(T1=5000, T2=10000, min_fidelity=0.9)
    f = ft.estimated_fidelity(1000)
    assert_true(0.25 < f < 1.0, f"T2=2*T1 boundary: F={f}")


# ===========================================================================
# Runner
# ===========================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("FidelityTracker Unit Tests")
    print("=" * 60)

    tests = [
        ("F(0) = 1.0", test_fidelity_at_time_zero),
        ("F(t) decays over time", test_fidelity_decays_over_time),
        ("F(t) → 0.25 as t → ∞", test_fidelity_asymptote),
        ("F(t) monotone decreasing", test_fidelity_monotone_decreasing),
        ("max_useful_age basic", test_max_useful_age_basic),
        ("max_useful_age cached", test_max_useful_age_cached),
        ("is_stale: fresh pair", test_is_stale_fresh_pair),
        ("is_stale: old pair", test_is_stale_old_pair),
        ("is_stale: negative age", test_is_stale_negative_age),
        ("asymmetric: equal params match symmetric", test_asymmetric_equal_params),
        ("asymmetric: different T1/T2 per side", test_asymmetric_different_params),
        ("asymmetric: different ages", test_asymmetric_different_ages),
        ("edge: very large T1/T2", test_edge_very_large_t1_t2),
        ("edge: very small T1/T2", test_edge_very_small_t1_t2),
        ("edge: min_fidelity near 0.25", test_edge_min_fidelity_near_025),
        ("validation: negative T1", test_validation_t1_negative),
        ("validation: T2 > 2*T1", test_validation_t2_too_large),
        ("validation: min_fidelity out of range", test_validation_min_fidelity_out_of_range),
        ("__repr__", test_repr),
        ("T2 = 2*T1 boundary", test_t2_equals_2t1),
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
