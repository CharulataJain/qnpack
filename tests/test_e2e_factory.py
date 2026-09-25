#!/usr/bin/env python3
"""End-to-end test: EPR Factory vs On-Demand entanglement generation.

Runs the same circuit (grover 4q 2qpu) with and without the EPR factory,
comparing execution time, correctness, and factory statistics.

Usage:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_e2e_factory.py
"""

import sys
import os
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
os.chdir(os.path.join(os.path.dirname(__file__), '..', 'qnpack', 'dqc'))

import netsquid as ns


def run_simulation(factory_enabled, num_runs=3, label=""):
    """Run a DQC simulation and return results with timing."""
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()

    # Configure factory
    sim.cfg.epr_factory.enabled = factory_enabled
    if factory_enabled:
        sim.cfg.epr_factory.pool_size_per_pair = 3
        sim.cfg.epr_factory.comm_qubits_reserved = 4
        sim.cfg.epr_factory.min_fidelity = 0.9

    # Circuit config
    sim.cfg.sim.iterations = 1
    sim.cfg.circuit.dist_commands_file = "commands/grover_4_2qpu.txt"
    sim.cfg.circuit.measure_qubits = "{1: [21, 20], 2: [21, 20]}"

    wall_start = time.time()
    results = sim.start(num_runs=num_runs)
    wall_end = time.time()

    wall_time = wall_end - wall_start

    # Extract key metrics
    counts = results[0]["counts"] if results else {}
    sim_durations = [r["sim_duration_s"] for r in results[0]["results"]] if results else []
    avg_sim_duration = sum(sim_durations) / len(sim_durations) if sim_durations else 0

    # Extract entanglement durations
    ent_durations_all = []
    for r in results[0].get("results", []):
        ent_durations_all.extend(r.get("entanglement_durations", {}).values())
    avg_ent_duration = (
        sum(ent_durations_all) / len(ent_durations_all)
        if ent_durations_all else 0
    )

    # Collect factory stats if available
    factory_stats = {}
    if factory_enabled and hasattr(sim, '_last_protocol'):
        for name, proto in getattr(sim._last_protocol, 'subprotocols', {}).items():
            if hasattr(proto, 'epr_factory') and proto.epr_factory is not None:
                factory_stats[proto.qpu_id] = proto.epr_factory.stats

    return {
        "label": label,
        "factory_enabled": factory_enabled,
        "wall_time": wall_time,
        "counts": counts,
        "num_runs": num_runs,
        "sim_durations": sim_durations,
        "avg_sim_duration": avg_sim_duration,
        "avg_ent_duration": avg_ent_duration,
        "num_ent_events": len(ent_durations_all),
        "factory_stats": factory_stats,
    }


def print_results(res):
    """Print formatted results."""
    print(f"\n{'=' * 60}")
    print(f"  {res['label']}")
    print(f"{'=' * 60}")
    print(f"  Factory enabled   : {res['factory_enabled']}")
    print(f"  Num runs          : {res['num_runs']}")
    print(f"  Wall-clock time   : {res['wall_time']:.3f} s")
    print(f"  Bitstring counts  : {dict(res['counts'])}")
    print(f"  Avg sim duration  : {res['avg_sim_duration']*1e6:.1f} µs")
    print(f"  Avg ent duration  : {res['avg_ent_duration']*1e6:.3f} µs")
    print(f"  Ent events total  : {res['num_ent_events']}")
    if res['sim_durations']:
        print(f"  Per-run sim times : {[f'{d*1e6:.0f}µs' for d in res['sim_durations']]}")
    if res['factory_stats']:
        print(f"  Factory stats     :")
        for qpu_id, stats in res['factory_stats'].items():
            print(f"    QPU_{qpu_id}: {stats}")
    print(f"{'=' * 60}")


def main():
    # Keep the comparison small: each run drives a full NetSquid simulation
    # of the distributed circuit, so run counts multiply quickly.  For a fast
    # pass/fail signal use tests/test_prefill_smoke.py instead.
    num_runs = 3

    print("\n" + "=" * 60)
    print("  EPR FACTORY END-TO-END COMPARISON TEST")
    print("  Circuit: Grover 4-qubit, 2 QPUs")
    print(f"  Runs per mode: {num_runs}")
    print("=" * 60)

    # ── Baseline (on-demand) ──────────────────────────────────────────
    print("\n>>> Running BASELINE (factory disabled)...")
    baseline = run_simulation(
        factory_enabled=False,
        num_runs=num_runs,
        label="BASELINE (on-demand entanglement)",
    )
    print_results(baseline)

    # ── Factory mode ──────────────────────────────────────────────────
    print("\n>>> Running FACTORY MODE (lazy pool)...")
    factory = run_simulation(
        factory_enabled=True,
        num_runs=num_runs,
        label="FACTORY MODE (lazy pool)",
    )
    print_results(factory)

    # ── Comparison ────────────────────────────────────────────────────
    print("\n" + "=" * 60)
    print("  COMPARISON")
    print("=" * 60)

    # Check correctness — both should produce the same dominant bitstring
    baseline_top = baseline["counts"].most_common(1)[0] if baseline["counts"] else ("?", 0)
    factory_top = factory["counts"].most_common(1)[0] if factory["counts"] else ("?", 0)

    correct = baseline_top[0] == factory_top[0]
    print(f"  Baseline top bitstring  : {baseline_top[0]} ({baseline_top[1]} times)")
    print(f"  Factory top bitstring   : {factory_top[0]} ({factory_top[1]} times)")
    print(f"  Correctness match       : {'✓ PASS' if correct else '✗ FAIL'}")

    print(f"\n  Wall-clock time:")
    print(f"    Baseline : {baseline['wall_time']:.3f} s")
    print(f"    Factory  : {factory['wall_time']:.3f} s")
    speedup = baseline['wall_time'] / factory['wall_time'] if factory['wall_time'] > 0 else 0
    print(f"    Ratio    : {speedup:.2f}x")

    print(f"\n  Avg simulated execution time:")
    print(f"    Baseline : {baseline['avg_sim_duration']*1e6:.1f} µs")
    print(f"    Factory  : {factory['avg_sim_duration']*1e6:.1f} µs")

    print(f"\n  Avg entanglement duration per event:")
    print(f"    Baseline : {baseline['avg_ent_duration']*1e6:.3f} µs")
    print(f"    Factory  : {factory['avg_ent_duration']*1e6:.3f} µs")

    print(f"\n{'=' * 60}")

    # ── Final verdict ─────────────────────────────────────────────────
    if correct:
        print("  ✓ TEST PASSED — Factory mode produces correct results")
    else:
        print("  ✗ TEST FAILED — Factory mode produced different results")
    print("=" * 60 + "\n")

    return 0 if correct else 1


if __name__ == "__main__":
    sys.exit(main())
