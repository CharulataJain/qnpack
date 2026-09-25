#!/usr/bin/env python3
"""Regression test: the pool desync cross-check must detect a broken invariant.

Runs the same circuit twice:
  1. unmodified   -> expect zero DESYNC reports
  2. sabotaged    -> one QPU ignores the slot it was told to take, so the two
                     sides consume mismatched halves; expect DESYNC

The slot is chosen by the controller and consumed via
``EPRPairPool.consume_slot``.  An earlier design had each side apply
"lowest usable slot" independently; that agreed only while the pool was
static, and continuous refill broke it — the two sides consume at slightly
different instants, so a slot committed in between is visible to one and not
the other.  The sabotage therefore targets the *directed* consumption path,
which is what the two endpoints now rely on.

Runnable from anywhere; the config lives in ``qnpack/dqc``.
"""
import logging
import os
import sys
import threading

sys.path.insert(
    0, os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
)
# parameters.yml and the topology are resolved relative to the cwd.
os.chdir(
    os.path.join(
        os.path.dirname(os.path.abspath(__file__)), '..', 'qnpack', 'dqc'
    )
)

CASE = "grover_4_3qpu"


def _watchdog(sec=300):
    def boom():
        print("WATCHDOG", flush=True)
        os._exit(2)
    t = threading.Timer(sec, boom)
    t.daemon = True
    t.start()


class _Counter(logging.Handler):
    def __init__(self):
        super().__init__()
        self.hits = []

    def emit(self, record):
        msg = record.getMessage()
        if "POOL DESYNC" in msg:
            self.hits.append(msg)


def run(sabotage):
    import netsquid as ns
    from qnpack.dqc.protocols.epr_pool import EPRPairPool

    counter = _Counter()
    logging.getLogger().addHandler(counter)
    qpu_log = logging.getLogger("qnpack.dqc.protocols.qpu")
    qpu_log.addHandler(counter)
    qpu_log.setLevel(logging.ERROR)

    original = EPRPairPool.consume_slot
    if sabotage:
        # Disregard the controller's instruction on exactly one side of one
        # pairing: QPU 2 takes the HIGHEST available slot instead of the one
        # it was told to take, so its half no longer matches its peer's.
        def patched(self, slot_id, current_time_ns):
            if self.local_qpu_id == 2 and len(self._pairs) > 1:
                slotted = [
                    p for p in self._pairs
                    if p.slot_id is not None and p.committed
                ]
                if slotted:
                    worst = max(slotted, key=lambda p: p.slot_id)
                    if worst.slot_id != slot_id:
                        self._pairs.remove(worst)
                        return worst
            return original(self, slot_id, current_time_ns)

        EPRPairPool.consume_slot = patched

    try:
        from qnpack.dqc.sim import DQCSimulation

        ns.sim_reset()
        sim = DQCSimulation()
        sim.cfg.entanglement.method = "bsm"
        sim.cfg.epr_factory.enabled = True
        sim.cfg.epr_factory.pool_size_per_pair = 2
        sim.cfg.epr_factory.comm_qubits_reserved = 4
        sim.cfg.epr_factory.min_fidelity = 0.9
        sim.cfg.sim.iterations = 1
        sim.cfg.circuit.dist_commands_file = f"commands/{CASE}.txt"
        sim.start(num_runs=1)
    finally:
        EPRPairPool.consume_slot = original
        logging.getLogger().removeHandler(counter)
        qpu_log.removeHandler(counter)

    return counter.hits


def main():
    _watchdog()

    clean = run(sabotage=False)
    print(f"\nCLEAN    desync_reports={len(clean)}", flush=True)

    broken = run(sabotage=True)
    print(f"SABOTAGE desync_reports={len(broken)}", flush=True)
    for h in broken[:3]:
        print(f"   {h}", flush=True)

    print()
    if clean:
        print("FAIL: desync reported on an unmodified run", flush=True)
        sys.exit(1)
    if not broken:
        print(
            "FAIL: sabotaged run went undetected — the cross-check is "
            "vacuous and would not catch a real pool desync",
            flush=True,
        )
        sys.exit(1)
    print("PASS: slot agreement holds, and violations are detected", flush=True)


if __name__ == "__main__":
    main()
