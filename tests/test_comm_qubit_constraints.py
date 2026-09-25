#!/usr/bin/env python3
"""Regression test: EPR-factory pool storage must respect real hardware.

The topology is authoritative for how many communication qubits a QPU has.
Pool storage is allocated from that same pool of qubits, so an over-large
``comm_qubits_reserved`` must be clamped rather than silently addressing
memory positions the hardware does not declare.

Three scenarios:
  1. normal   — reservation fits; expect no warnings, full depth
  2. oversize — comm_qubits_reserved far exceeds capacity; expect a clamp
                warning and allocation bounded by real hardware
  3. tiny HW  — topology patched down to 2 comm qubits per QPU; expect
                allocation to respect that, never addressing position >= 2

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


class _Capture(logging.Handler):
    def __init__(self):
        super().__init__()
        self.warnings = []

    def emit(self, record):
        if record.levelno >= logging.WARNING:
            msg = record.getMessage()
            if "EPR factory" in msg or "EPR pool" in msg:
                self.warnings.append(msg)


def _watchdog(sec=900):
    def boom():
        print("@@ WATCHDOG", flush=True)
        os._exit(2)
    t = threading.Timer(sec, boom)
    t.daemon = True
    t.start()


def main():
    _watchdog()

    import netsquid as ns
    from qnpack.dqc.protocols.controller import ControllerProtocol
    from qnpack.dqc.sim import DQCSimulation

    layouts = {}
    orig_align = ControllerProtocol._align_pools_with_circuit

    def align(self):
        orig_align(self)
        out = {}
        for q, f in sorted(self.factory_by_qpu.items()):
            for p, c in sorted(f.peer_configs.items()):
                out[f"{q}->{p}"] = c["comm_positions"]
        layouts["last"] = out
        layouts["capacity"] = self._topology_comm_capacity()

    ControllerProtocol._align_pools_with_circuit = align

    def run(label, reserved, pool, shrink_to=None):
        layouts.clear()
        cap = _Capture()
        clog = logging.getLogger("qnpack.dqc.protocols.controller")
        clog.addHandler(cap)
        ns.sim_reset()
        sim = DQCSimulation()
        sim.cfg.entanglement.method = "bsm"

        if shrink_to is not None:
            # Patch the loaded topology down to a small comm count.
            orig_load = sim.load_topology

            def patched(topology_file=None):
                data = orig_load(topology_file)
                nodes = data[0]["nodes"] if isinstance(data, list) else data["nodes"]
                for n in nodes:
                    qs = n.get("qubitSettings", {}).get("qubits")
                    if not qs:
                        continue
                    kept, ncomm = [], 0
                    for q in qs:
                        if q.get("type") == "communication":
                            if ncomm >= shrink_to:
                                continue
                            ncomm += 1
                        kept.append(q)
                    n["qubitSettings"]["qubits"] = kept
                return data

            sim.load_topology = patched

        sim.cfg.epr_factory.enabled = True
        sim.cfg.epr_factory.pool_size_per_pair = pool
        sim.cfg.epr_factory.comm_qubits_reserved = reserved
        sim.cfg.epr_factory.min_fidelity = 0.9
        sim.cfg.sim.iterations = 1
        sim.cfg.circuit.dist_commands_file = f"commands/{CASE}.txt"
        try:
            res = sim.start(num_runs=1)
        except Exception as e:
            print(f"@@ {label}: EXCEPTION {type(e).__name__}: {e}", flush=True)
            return None
        finally:
            clog.removeHandler(cap)

        counts = dict(res[0]["counts"]) if res else {}
        print(f"@@ {label}: capacity={layouts.get('capacity')}", flush=True)
        print(f"@@ {label}: layout={layouts.get('last')}", flush=True)
        print(f"@@ {label}: counts={counts}", flush=True)
        for w in cap.warnings[:4]:
            print(f"@@ {label}: WARN {w}", flush=True)
        if not cap.warnings:
            print(f"@@ {label}: (no warnings)", flush=True)

        # Assert nothing was allocated beyond hardware.
        capm = layouts.get("capacity", {})
        bad = []
        for key, positions in (layouts.get("last") or {}).items():
            qid = int(key.split("->")[0])
            hw = capm.get(qid)
            if hw is not None and positions and max(positions) >= hw:
                bad.append((key, positions, hw))
        print(f"@@ {label}: over-capacity allocations = "
              f"{bad if bad else 'none'}", flush=True)
        return {"over_capacity": bad, "warnings": cap.warnings}

    print("@@ === 1. normal (reserved=16, pool=8) ===", flush=True)
    r1 = run("normal", 16, 8)
    print("@@ === 2. oversize (reserved=500, pool=100) ===", flush=True)
    r2 = run("oversize", 500, 100)
    print("@@ === 3. tiny hardware (2 comm qubits/QPU) ===", flush=True)
    r3 = run("tinyhw", 16, 8, shrink_to=2)

    failures = []
    for label, res in (("normal", r1), ("oversize", r2), ("tinyhw", r3)):
        if res is None:
            failures.append(f"{label}: simulation raised")
            continue
        if res["over_capacity"]:
            failures.append(
                f"{label}: allocated beyond hardware {res['over_capacity']}"
            )
    if r1 is not None and r1["warnings"]:
        failures.append("normal: unexpected warnings on a fitting config")
    if r2 is not None and not r2["warnings"]:
        failures.append("oversize: no warning for an impossible reservation")
    if r3 is not None and not r3["warnings"]:
        failures.append("tinyhw: no warning when hardware cannot host pools")

    print()
    if failures:
        for f in failures:
            print(f"FAIL {f}", flush=True)
        sys.exit(1)
    print("PASS: pool storage is bounded by topology comm-qubit capacity",
          flush=True)


if __name__ == "__main__":
    main()
