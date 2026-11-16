#!/usr/bin/env python3
"""Distribution-level correctness check for the EPR pool execution path.

Why this exists
---------------
An earlier pooled-execution design passed every structural check — zero
desync, zero refusals, consumption scaling with pool depth — while silently
randomising the circuit's output.  Top-bitstring comparison did not catch
it, because on a flat distribution the *baseline's own* top bitstring varies
between runs.  See ``qnpack/dqc/ARCHITECTURE.md`` §6.

The discriminator is **total variation distance** measured against the
intrinsic run-to-run noise of the baseline itself:

    TVD(p, q) = 1/2 * sum_b |p(b) - q(b)|

Two independent on-demand runs establish a noise floor.  A factory run is a
regression when its distance from the baseline materially exceeds that floor
— the measured signal was 0.725 against a 0.075 floor, so the separation is
not subtle.

Usage:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_pool_tvd.py
"""

import os
import sys
import threading
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
os.chdir(os.path.join(os.path.dirname(__file__), '..', 'qnpack', 'dqc'))

import netsquid as ns  # noqa: E402

# Hard ceiling for the whole test.  A healthy run is a few seconds per
# distribution; anything approaching this is a regression in its own right.
WATCHDOG_SECONDS = 60

# Runs per distribution.  Low enough to stay quick, high enough that the
# baseline-vs-baseline floor is a stable estimate.
RUNS = 20

# A factory distribution may sit at most this multiple of the measured
# baseline noise floor away from the baseline before it counts as a
# regression.  The observed corruption was ~10x the floor.
TOLERANCE_FACTOR = 3.0

# Absolute allowance, so a circuit with a near-deterministic baseline (floor
# ≈ 0) does not fail on ordinary sampling jitter.
TOLERANCE_FLOOR = 0.25

CASES = [
    {
        "name": "grover 4q / 2 QPUs",
        "circuit": "commands/grover_4_2qpu.txt",
        "measure_qubits": "{1: [21, 20], 2: [21, 20]}",
    },
    {
        "name": "grover 4q / 3 QPUs",
        "circuit": "commands/grover_4_3qpu.txt",
        "measure_qubits": "{1: [21, 20], 2: [20], 3: [20]}",
    },
]


def _arm_watchdog():
    """Kill the process if the simulation exceeds the time budget."""
    def _boom():
        sys.stderr.write(
            f"\n*** WATCHDOG: exceeded {WATCHDOG_SECONDS}s — "
            f"simulation likely deadlocked ***\n"
        )
        sys.stderr.flush()
        os._exit(2)

    t = threading.Timer(WATCHDOG_SECONDS, _boom)
    t.daemon = True
    t.start()
    return t


def tvd(counts_a, counts_b):
    """Total variation distance between two bitstring count distributions.

    Parameters
    ----------
    counts_a, counts_b : Mapping[str, int]
        Raw occurrence counts; they are normalised internally, so the two
        distributions need not have been sampled the same number of times.

    Returns
    -------
    float
        A value in ``[0, 1]``.  ``0`` means identical distributions, ``1``
        means disjoint support.
    """
    total_a = sum(counts_a.values()) or 1
    total_b = sum(counts_b.values()) or 1
    keys = set(counts_a) | set(counts_b)
    return 0.5 * sum(
        abs(counts_a.get(k, 0) / total_a - counts_b.get(k, 0) / total_b)
        for k in keys
    )


def run_sim(case, factory_enabled, runs=RUNS, pool_size=4):
    """Run one circuit and return its bitstring distribution plus pool stats."""
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    sim.cfg.entanglement.method = "bsm"

    sim.cfg.epr_factory.enabled = factory_enabled
    sim.cfg.epr_factory.pool_size_per_pair = pool_size
    sim.cfg.epr_factory.comm_qubits_reserved = 4
    sim.cfg.epr_factory.min_fidelity = 0.9

    sim.cfg.sim.iterations = 1
    sim.cfg.circuit.dist_commands_file = case["circuit"]
    sim.cfg.circuit.measure_qubits = case["measure_qubits"]

    results = sim.start(num_runs=runs)

    generated = consumed = 0
    protocol = getattr(sim, "_last_protocol", None)
    if protocol is not None:
        for _, proto in getattr(protocol, "subprotocols", {}).items():
            factory = getattr(proto, "epr_factory", None)
            if factory is None:
                continue
            s = factory.stats
            generated += s["pairs_generated"]
            consumed += s["pairs_consumed"]

    counts = dict(results[0]["counts"]) if results else {}
    return {"counts": counts, "generated": generated, "consumed": consumed}


def main():
    watchdog = _arm_watchdog()
    started = time.time()

    print("\n" + "=" * 68)
    print("  EPR POOL — DISTRIBUTION (TVD) CORRECTNESS TEST")
    print(f"  {len(CASES)} circuit(s) x {RUNS} run(s) x 3 distributions")
    print("=" * 68)

    failures = []

    for case in CASES:
        print(f"\n[{case['name']}]")

        base_a = run_sim(case, factory_enabled=False)
        base_b = run_sim(case, factory_enabled=False)
        fact = run_sim(case, factory_enabled=True)

        floor = tvd(base_a["counts"], base_b["counts"])
        signal = tvd(base_a["counts"], fact["counts"])
        budget = max(TOLERANCE_FLOOR, floor * TOLERANCE_FACTOR)

        print(f"  baseline A          : {base_a['counts']}")
        print(f"  baseline B          : {base_b['counts']}")
        print(f"  factory             : {fact['counts']}")
        print(f"  pairs gen/consumed  : {fact['generated']}/{fact['consumed']}")
        print(f"  TVD base-vs-base    : {floor:.3f}   (noise floor)")
        print(f"  TVD base-vs-factory : {signal:.3f}   (budget {budget:.3f})")

        if signal > budget:
            failures.append(
                f"{case['name']}: factory TVD {signal:.3f} exceeds "
                f"budget {budget:.3f} (noise floor {floor:.3f})"
            )
        if fact["consumed"] == 0:
            failures.append(f"{case['name']}: no pooled pair consumed")

    watchdog.cancel()

    print(f"\n  total wall time      : {time.time() - started:.1f}s")
    print("\n" + "=" * 68)
    if failures:
        for f in failures:
            print(f"  ✗ {f}")
        print("  ✗ TEST FAILED")
        print("=" * 68 + "\n")
        return 1

    print("  ✓ TEST PASSED — pooled execution matches the on-demand baseline")
    print("=" * 68 + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
