#!/usr/bin/env python3
"""Fast smoke test for the EPR factory *pre-fill* mechanism.

Verifies, in well under a minute, that:

1. The dedicated factory classical plane is wired on every QPU/BSM node.
2. The controller-driven pre-fill phase actually fills the pools
   (``pairs_generated > 0``) and terminates without deadlocking.
3. Circuit execution then *consumes* pre-generated pairs
   (``pairs_consumed > 0``) and still produces the correct bitstring.

A watchdog aborts the process if the simulation hangs, so a regression
surfaces as a failure rather than an indefinite stall.

Usage:
    /Users/ezra/.virtualenvs/qn-sim/bin/python3 tests/test_prefill_smoke.py
"""

import os
import sys
import threading
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
os.chdir(os.path.join(os.path.dirname(__file__), '..', 'qnpack', 'dqc'))

import netsquid as ns  # noqa: E402

# Hard ceiling for the whole run.  Healthy runs finish in a few seconds.
WATCHDOG_SECONDS = 45

# Smallest circuits that still perform remote gates (and therefore
# entanglement_gen operations that can draw from the pool).  The 3-QPU case
# exercises multiple concurrent QPU pairings on one node.
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

# Runs per mode.  Entanglement is probabilistic, so correctness is judged by
# comparing the factory distribution against the on-demand baseline rather
# than against a hard-coded bitstring.
RUNS = 5


def _arm_watchdog():
    """Kill the process if the simulation exceeds the time budget."""
    def _boom():
        sys.stderr.write(
            f"\n*** WATCHDOG: exceeded {WATCHDOG_SECONDS}s — "
            f"pre-fill likely deadlocked ***\n"
        )
        sys.stderr.flush()
        os._exit(2)

    t = threading.Timer(WATCHDOG_SECONDS, _boom)
    t.daemon = True
    t.start()
    return t


# ---------------------------------------------------------------------------
# Check 1 — network wiring
# ---------------------------------------------------------------------------

def check_factory_ports():
    """Assert the dedicated factory ports exist and are connected."""
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    sim.cfg.entanglement.method = "bsm"
    topology = sim.load_topology()
    net, qpu_nodes, bsm_nodes, ctrl, qpu_info, bsm_info = (
        sim.setup_network_from_topology(topology)
    )

    problems = []

    for node in bsm_nodes:
        for p in (
            "factory_clk_to_left", "factory_clk_to_right",
            "factory_BSM_res_to_left", "factory_BSM_res_to_right",
        ):
            if p not in node.ports:
                problems.append(f"{node.name} missing port {p}")

    switched = getattr(net, "q_switch", None) is not None

    # In switched mode the factory plane terminates on the switch ports; the
    # per-BSM ports exist but are intentionally unused (mirroring how the
    # circuit plane uses clk_from_switch / bsm_res_from_switch).
    if switched:
        required = ("factory_clk_from_switch", "factory_bsm_res_from_switch")
    else:
        required = None  # every factory_* port must be live

    for node in qpu_nodes:
        factory_ports = [p for p in node.ports if p.startswith("factory_")]
        if not factory_ports:
            problems.append(f"{node.name} has no factory_* ports")
            continue

        to_check = required if required is not None else factory_ports
        for p in to_check:
            if p not in node.ports:
                problems.append(f"{node.name} missing port {p}")
            elif node.ports[p].connected_port is None:
                problems.append(f"{node.name}.{p} is not connected")

    print(f"  network mode        : {'switched' if switched else 'direct'}")
    print(f"  BSM nodes           : {len(bsm_nodes)}")
    print(f"  QPU nodes           : {len(qpu_nodes)}")
    live = sorted(
        p for p in qpu_nodes[0].ports
        if p.startswith("factory_") and qpu_nodes[0].ports[p].connected_port
    )
    print(f"  {qpu_nodes[0].name} live factory ports: {live}")

    if problems:
        for p in problems:
            print(f"  ✗ {p}")
        return False

    print("  ✓ factory classical plane wired on all nodes")
    return True


# ---------------------------------------------------------------------------
# Check 2/3 — pre-fill runs, pools are used, result is correct
# ---------------------------------------------------------------------------

def run_sim(case, factory_enabled, runs=RUNS):
    """Run a circuit with the factory either enabled or disabled."""
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    sim.cfg.entanglement.method = "bsm"

    sim.cfg.epr_factory.enabled = factory_enabled
    sim.cfg.epr_factory.pool_size_per_pair = 1   # keep pre-fill short
    sim.cfg.epr_factory.comm_qubits_reserved = 3
    sim.cfg.epr_factory.min_fidelity = 0.9

    sim.cfg.sim.iterations = 1
    sim.cfg.circuit.dist_commands_file = case["circuit"]
    sim.cfg.circuit.measure_qubits = case["measure_qubits"]

    t0 = time.time()
    results = sim.start(num_runs=runs)
    elapsed = time.time() - t0

    generated = consumed = failures = 0
    protocol = getattr(sim, "_last_protocol", None)
    if protocol is not None:
        for _, proto in getattr(protocol, "subprotocols", {}).items():
            factory = getattr(proto, "epr_factory", None)
            if factory is None:
                continue
            s = factory.stats
            generated += s["pairs_generated"]
            consumed += s["pairs_consumed"]
            failures += s["generation_failures"]

    counts = results[0]["counts"] if results else {}
    return {
        "counts": counts,
        "elapsed": elapsed,
        "generated": generated,
        "consumed": consumed,
        "failures": failures,
    }


def main():
    watchdog = _arm_watchdog()

    print("\n" + "=" * 60)
    print("  EPR FACTORY PRE-FILL SMOKE TEST")
    print(f"  {len(CASES)} circuit(s) x {RUNS} run(s), pool_size=1")
    print(f"  Watchdog: {WATCHDOG_SECONDS}s")
    print("=" * 60)

    failures = []

    # ── 1. Wiring ────────────────────────────────────────────────────
    print("\n[1] Factory port wiring")
    if not check_factory_ports():
        failures.append("factory ports not wired correctly")

    # ── 2/3. Pre-fill, consumption, and correctness per circuit ──────
    for idx, case in enumerate(CASES, start=2):
        print(f"\n[{idx}] {case['name']}")

        baseline = run_sim(case, factory_enabled=False)
        factory = run_sim(case, factory_enabled=True)

        print(f"  baseline counts     : {dict(baseline['counts'])} "
              f"({baseline['elapsed']:.1f}s)")
        print(f"  factory counts      : {dict(factory['counts'])} "
              f"({factory['elapsed']:.1f}s)")
        print(f"  pairs generated     : {factory['generated']}")
        print(f"  pairs consumed      : {factory['consumed']}")
        print(f"  generation failures : {factory['failures']}")

        if factory["generated"] == 0:
            failures.append(f"{case['name']}: pre-fill generated no pairs")
        if factory["consumed"] == 0:
            failures.append(f"{case['name']}: no pre-generated pair consumed")
        if factory["failures"]:
            failures.append(
                f"{case['name']}: {factory['failures']} generation failure(s)"
            )

        # Correctness is judged against the on-demand baseline: the factory
        # must not change the circuit's outcome distribution.
        base_top = (
            baseline["counts"].most_common(1)[0][0] if baseline["counts"] else None
        )
        fact_top = (
            factory["counts"].most_common(1)[0][0] if factory["counts"] else None
        )
        print(f"  top bitstring       : baseline={base_top} factory={fact_top}")
        if base_top != fact_top:
            failures.append(
                f"{case['name']}: factory top bitstring {fact_top!r} "
                f"!= baseline {base_top!r}"
            )

    watchdog.cancel()

    print("\n" + "=" * 60)
    if failures:
        for f in failures:
            print(f"  ✗ {f}")
        print("  ✗ TEST FAILED")
        print("=" * 60 + "\n")
        return 1

    print("  ✓ TEST PASSED — pre-fill generates, consumes, and is correct")
    print("=" * 60 + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
