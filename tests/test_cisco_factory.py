#!/usr/bin/env python3
"""The EPR factory must be correct under the cisco (QASM3) frontend.

Two properties, both of which were broken:

1. **Termination.** The cisco frontend maps a 2-QPU circuit onto the bundled
   3-QPU topology, so QPU_3 receives no commands.  An idle QPU never emits
   SUCCESS, so teardown never ran, so the factory's maintenance loop kept
   re-arming a timer and the event queue never emptied.  The run consumed the
   machine rather than failing.

2. **Correctness.** cisco teleports with ``entanglement_gen`` + ``measure`` +
   ``if_gate`` and emits no ``ejpp_*`` ops at all.  ``_execute_measure`` did
   not resolve its position through the comm-remap table, so when a pooled
   pair landed somewhere other than the nominated position the circuit
   measured an untouched qubit — a random bit — and never released the real
   one.  Measured 78 wrong-qubit measurements in a single run, output TVD
   0.900 against a 0.100 noise floor.

Correctness is checked by total variation distance against two independent
baselines, per qnpack/dqc/ARCHITECTURE.md §6: on flat distributions a
top-bitstring match is not a reliable discriminator.
"""
import io
import contextlib
import os
import sys
import threading
import time
import warnings

sys.path.insert(
    0, os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
)
os.chdir(
    os.path.join(
        os.path.dirname(os.path.abspath(__file__)), '..', 'qnpack', 'dqc'
    )
)

import logging
logging.disable(logging.CRITICAL)
# Warning suppression is handled centrally via [tool.pytest.ini_options]
# filterwarnings in pyproject.toml; a blanket ignore here would mask warnings
# session-wide for every other test module too.

WATCHDOG_SECONDS = 180
QASM = "qasm/grover4_2qpu.qasm"
RUNS = 12
TOLERANCE_FACTOR = 3.0
TOLERANCE_FLOOR = 0.25


def _watchdog():
    def boom():
        print(
            f"\n  FAIL — did not finish within {WATCHDOG_SECONDS}s.\n"
            "  An idle QPU is probably holding the event queue open again;\n"
            "  see DQCProtocol.run() and EPRFactoryProtocol.run().",
            flush=True,
        )
        os._exit(1)

    t = threading.Timer(WATCHDOG_SECONDS, boom)
    t.daemon = True
    t.start()


def run(factory_enabled, runs=RUNS):
    import netsquid as ns
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    sim.cfg.entanglement.method = "bsm"
    sim.cfg.circuit.mode = "cisco"
    sim.cfg.circuit.qasm_file = QASM
    sim.cfg.epr_factory.enabled = factory_enabled

    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        rows = sim.start(num_runs=runs)

    counts = {}
    for row in rows:
        for bits, n in dict(row.get("counts", {})).items():
            counts[bits] = counts.get(bits, 0) + n
    return counts


def tvd(a, b):
    ta = sum(a.values()) or 1
    tb = sum(b.values()) or 1
    return 0.5 * sum(
        abs(a.get(k, 0) / ta - b.get(k, 0) / tb) for k in set(a) | set(b)
    )


def main():
    _watchdog()
    print("=" * 68)
    print("  CISCO (QASM3) FRONTEND + EPR FACTORY")
    print("=" * 68)
    print(f"\n  circuit: {QASM}  ({RUNS} shots per configuration)")
    print("  a 2-QPU circuit on the 3-QPU topology, so QPU_3 stays idle\n")

    t0 = time.time()
    base_a = run(False)
    base_b = run(False)
    factory = run(True)
    elapsed = time.time() - t0

    floor = tvd(base_a, base_b)
    delta = tvd(base_a, factory)
    budget = max(TOLERANCE_FLOOR, floor * TOLERANCE_FACTOR)

    print(f"  baseline A          : {base_a}")
    print(f"  baseline B          : {base_b}")
    print(f"  factory             : {factory}")
    print(f"  TVD base-vs-base    : {floor:.3f}   (noise floor)")
    print(f"  TVD base-vs-factory : {delta:.3f}   (budget {budget:.3f})")
    print(f"\n  total wall time     : {elapsed:.1f}s")

    failures = []
    if not factory:
        failures.append("factory run produced no measurements")
    if delta > budget:
        failures.append(
            f"factory distribution differs from baseline "
            f"(TVD {delta:.3f} > budget {budget:.3f})"
        )

    print()
    print("=" * 68)
    if failures:
        for f in failures:
            print(f"  ✗ {f}")
        print("  TEST FAILED")
        print("=" * 68)
        return 1

    print("  ✓ TEST PASSED — cisco terminates and matches the baseline")
    print("=" * 68)
    return 0


if __name__ == "__main__":
    sys.exit(main())
