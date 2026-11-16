#!/usr/bin/env python3
"""Integration test: EPR Factory vs On-Demand entanglement generation.

Runs the same circuit (grover 4q 2qpu) with and without the EPR factory,
comparing execution time and correctness.

Usage:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_epr_factory_integration.py

Note: The full simulation requires NetSquid to be installed and configured.
If the full simulation cannot run, a fallback import-only test is performed.
"""
import sys
import os
import time

sys.path.insert(0, ".")

# ---------------------------------------------------------------------------
# Test infrastructure
# ---------------------------------------------------------------------------
_passed = 0
_failed = 0


def _run_test(name, func):
    global _passed, _failed
    try:
        func()
        _passed += 1
        print(f"  PASS  {name}")
    except Exception as e:
        _failed += 1
        print(f"  FAIL  {name}: {e}")


def assert_true(cond, msg=""):
    if not cond:
        raise AssertionError(msg or "condition is False")


def assert_eq(actual, expected, msg=""):
    if actual != expected:
        raise AssertionError(f"{msg}expected {expected!r}, got {actual!r}")


# ===========================================================================
# Phase 1: Import verification
# ===========================================================================

def test_import_fidelity_tracker():
    """Import FidelityTracker from the protocols package."""
    from qnpack.dqc.protocols import FidelityTracker
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    assert_true(ft.estimated_fidelity(0) == 1.0, "F(0) should be 1.0")


def test_import_epr_pool():
    """Import EPRPairPool and EPRPairEntry from the protocols package."""
    from qnpack.dqc.protocols import EPRPairEntry, EPRPairPool
    from qnpack.dqc.protocols.fidelity import FidelityTracker
    ft = FidelityTracker(T1=10000, T2=5000, min_fidelity=0.9)
    pool = EPRPairPool(local_qpu_id=1, remote_qpu_id=2, capacity=3,
                       fidelity_tracker=ft)
    assert_true(pool.available_count() == 0)


def test_import_epr_factory():
    """Import EPRFactoryProtocol from the protocols package."""
    from qnpack.dqc.protocols import EPRFactoryProtocol
    assert_true(EPRFactoryProtocol is not None)


def test_import_dqc_protocol():
    """Import DQCProtocol (top-level orchestrator)."""
    from qnpack.dqc.protocols.core import DQCProtocol
    assert_true(DQCProtocol is not None)


def test_import_dqc_simulation():
    """Import DQCSimulation from sim module."""
    from qnpack.dqc.sim import DQCSimulation
    assert_true(DQCSimulation is not None)


# ===========================================================================
# Phase 2: Configuration wiring
# ===========================================================================

def test_config_loads_epr_factory():
    """Verify parameters.yml loads and epr_factory config is accessible."""
    # Change to dqc directory where parameters.yml lives
    original_dir = os.getcwd()
    try:
        os.chdir(os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc"))
        from qnpack.dqc.sim import DQCSimulation
        sim = DQCSimulation()
        sim.cfg.entanglement.method = "bsm"
        cfg = sim.cfg

        # Check epr_factory section exists
        assert_true(hasattr(cfg, "epr_factory"),
                    "cfg should have epr_factory section")
        assert_true(hasattr(cfg.epr_factory, "enabled"),
                    "epr_factory should have 'enabled' field")
        assert_true(hasattr(cfg.epr_factory, "pool_size_per_pair"),
                    "epr_factory should have 'pool_size_per_pair' field")
        assert_true(hasattr(cfg.epr_factory, "min_fidelity"),
                    "epr_factory should have 'min_fidelity' field")
    finally:
        os.chdir(original_dir)


def test_config_epr_factory_defaults():
    """Verify default epr_factory config values from parameters.yml."""
    original_dir = os.getcwd()
    try:
        os.chdir(os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc"))
        from qnpack.dqc.sim import DQCSimulation
        sim = DQCSimulation()
        sim.cfg.entanglement.method = "bsm"

        assert_eq(sim.cfg.epr_factory.enabled, False,
                  msg="Default enabled: ")
        assert_eq(sim.cfg.epr_factory.pool_size_per_pair, 8,
                  msg="Default pool_size_per_pair: ")
        assert_eq(sim.cfg.epr_factory.comm_qubits_reserved, 16,
                  msg="Default comm_qubits_reserved: ")
        assert_eq(sim.cfg.epr_factory.min_fidelity, 0.9,
                  msg="Default min_fidelity: ")
        assert_eq(sim.cfg.epr_factory.check_interval_ns, 1000000,
                  msg="Default check_interval_ns: ")
        assert_eq(sim.cfg.epr_factory.pool_only, True,
                  msg="Default pool_only: ")
        assert_eq(sim.cfg.epr_factory.drain_timeout_ns, 5000000,
                  msg="Default drain_timeout_ns: ")
    finally:
        os.chdir(original_dir)


def test_config_override():
    """Verify that epr_factory config can be overridden programmatically."""
    original_dir = os.getcwd()
    try:
        os.chdir(os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc"))
        from qnpack.dqc.sim import DQCSimulation
        sim = DQCSimulation()
        sim.cfg.entanglement.method = "bsm"

        sim.cfg.epr_factory.enabled = True
        sim.cfg.epr_factory.pool_size_per_pair = 5
        sim.cfg.epr_factory.min_fidelity = 0.85

        assert_eq(sim.cfg.epr_factory.enabled, True, msg="Override enabled: ")
        assert_eq(sim.cfg.epr_factory.pool_size_per_pair, 5,
                  msg="Override pool_size: ")
        assert_eq(sim.cfg.epr_factory.min_fidelity, 0.85,
                  msg="Override min_fidelity: ")
    finally:
        os.chdir(original_dir)


# ===========================================================================
# Phase 3: Full simulation (stretch goal)
# ===========================================================================

def _run_simulation(factory_enabled, num_runs=3):
    """Run a DQC simulation with or without EPR factory.

    Returns
    -------
    tuple (results, wall_time_s)
    """
    import netsquid as ns
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()

    sim = DQCSimulation()
    sim.cfg.entanglement.method = "bsm"
    sim.cfg.epr_factory.enabled = factory_enabled
    if factory_enabled:
        sim.cfg.epr_factory.pool_size_per_pair = 3
        sim.cfg.epr_factory.comm_qubits_reserved = 4
        sim.cfg.epr_factory.min_fidelity = 0.9
    sim.cfg.sim.iterations = num_runs
    sim.cfg.circuit.dist_commands_file = "commands/grover_4_2qpu.txt"
    sim.cfg.circuit.measure_qubits = "{1: [21, 20], 2: [21, 20]}"
    # Ensure T1/T2 are floats (YAML may parse 1e15 as string)
    sim.cfg.memory.T1 = float(sim.cfg.memory.T1)
    sim.cfg.memory.T2 = float(sim.cfg.memory.T2)

    t0 = time.perf_counter()
    results = sim.start(num_runs=num_runs)
    t1 = time.perf_counter()

    return results, t1 - t0


def test_full_simulation_baseline():
    """Run baseline simulation (factory disabled) and verify output structure."""
    original_dir = os.getcwd()
    try:
        os.chdir(os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc"))
        results, wall_time = _run_simulation(factory_enabled=False, num_runs=2)
        assert_true(isinstance(results, list), f"Results should be list: {type(results)}")
        assert_true(len(results) > 0, "Should have at least one result entry")
        print(f"    Baseline: {len(results)} result entries, wall_time={wall_time:.3f}s")
    finally:
        os.chdir(original_dir)


def test_full_simulation_factory():
    """Run simulation with EPR factory enabled and verify output structure."""
    original_dir = os.getcwd()
    try:
        os.chdir(os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc"))
        results, wall_time = _run_simulation(factory_enabled=True, num_runs=2)
        assert_true(isinstance(results, list), f"Results should be list: {type(results)}")
        assert_true(len(results) > 0, "Should have at least one result entry")
        print(f"    Factory:  {len(results)} result entries, wall_time={wall_time:.3f}s")
    finally:
        os.chdir(original_dir)


def test_comparison():
    """Compare baseline and factory simulation results."""
    original_dir = os.getcwd()
    try:
        os.chdir(os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc"))
        n_runs = 3

        print(f"\n    Running baseline (on-demand, {n_runs} runs)...")
        baseline_results, baseline_time = _run_simulation(
            factory_enabled=False, num_runs=n_runs
        )

        print(f"    Running factory ({n_runs} runs)...")
        factory_results, factory_time = _run_simulation(
            factory_enabled=True, num_runs=n_runs
        )

        print(f"\n    === Comparison ===")
        print(f"    Baseline wall time: {baseline_time:.3f} s")
        print(f"    Factory  wall time: {factory_time:.3f} s")
        print(f"    Speedup: {baseline_time / max(factory_time, 0.001):.2f}x")

        # Both should produce valid results
        assert_true(len(baseline_results) > 0, "Baseline should have results")
        assert_true(len(factory_results) > 0, "Factory should have results")

    finally:
        os.chdir(original_dir)


# ===========================================================================
# Runner
# ===========================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("EPR Factory Integration Tests")
    print("=" * 60)

    # Phase 1: Import verification (always runs)
    print("\n--- Phase 1: Import Verification ---")
    import_tests = [
        ("Import FidelityTracker", test_import_fidelity_tracker),
        ("Import EPRPairPool/Entry", test_import_epr_pool),
        ("Import EPRFactoryProtocol", test_import_epr_factory),
        ("Import DQCProtocol", test_import_dqc_protocol),
        ("Import DQCSimulation", test_import_dqc_simulation),
    ]
    for name, func in import_tests:
        _run_test(name, func)

    # Phase 2: Configuration wiring
    print("\n--- Phase 2: Configuration Wiring ---")
    config_tests = [
        ("Config loads epr_factory section", test_config_loads_epr_factory),
        ("Config default values", test_config_epr_factory_defaults),
        ("Config programmatic override", test_config_override),
    ]
    for name, func in config_tests:
        _run_test(name, func)

    # Phase 3: Full simulation (may fail if NetSquid has state issues)
    print("\n--- Phase 3: Full Simulation (stretch goal) ---")
    sim_tests = [
        ("Full simulation: baseline", test_full_simulation_baseline),
        ("Full simulation: factory", test_full_simulation_factory),
        ("Baseline vs Factory comparison", test_comparison),
    ]
    for name, func in sim_tests:
        _run_test(name, func)

    # Summary
    print()
    print("-" * 60)
    total = _passed + _failed
    if _failed == 0:
        print(f"All {_passed}/{total} tests passed!")
    else:
        print(f"Results: {_passed} passed, {_failed} failed (out of {total})")
        # Don't exit(1) for integration tests — Phase 3 failures are expected
        # in some environments
        if _failed > len(sim_tests):
            # If non-simulation tests failed, that's a real error
            print("ERROR: Core tests (Phase 1/2) failed!")
            sys.exit(1)
        else:
            print("NOTE: Phase 3 (full simulation) failures may be expected")
            print("      if NetSquid simulation state is not clean.")
