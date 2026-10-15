"""Shot-based Aer simulation of the 1QPU plaquette circuits.
Writes CSVs matching the format expected by the updated plot script.
"""
import sys, csv
from pathlib import Path
sys.path.insert(0, "qnpack/dqc/experiments/plaquette")
import numpy as np
from plaquette_chain_121 import build_plaquette_circuit_121
from plaquette_2d_121 import build_plaquette_circuit_2d_121
from qiskit_aer import AerSimulator
from qiskit_aer.noise import NoiseModel, depolarizing_error
from qiskit import transpile

OUT = Path("qnpack/dqc/results/plaquette_sweep")
N_STEPS = [0, 2, 4, 6, 8, 10]
SHOTS = 500

def make_noise_model(p2=1e-4, p1=1e-5):
    nm = NoiseModel()
    nm.add_all_qubit_quantum_error(depolarizing_error(p1, 1), ["u", "p", "rz", "h", "x", "s", "sdg"])
    nm.add_all_qubit_quantum_error(depolarizing_error(p2, 2), ["cx"])
    return nm

def run_circuit(qc, sim, shots):
    qc_m = qc.copy()
    qc_m.measure_all()
    t = transpile(qc_m, sim)
    result = sim.run(t, shots=shots).result()
    counts = result.get_counts()
    rows = []
    for bitstring, count in counts.items():
        bits = [int(b) for b in reversed(bitstring)]  # qubit 0 = index 0
        for _ in range(count):
            rows.append(bits)
    return rows

def write_csv(path, rows, n_qubits):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="") as f:
        cols = [f"meas_{i}" for i in range(n_qubits)]
        w = csv.DictWriter(f, fieldnames=cols)
        w.writeheader()
        for bits in rows:
            w.writerow({f"meas_{i}": bits[i] for i in range(n_qubits)})

for noise_key, nm in [("ideal", None), ("noisy", make_noise_model())]:
    sim = AerSimulator(noise_model=nm)
    for lattice in ["1d", "2d"]:
        tag = f"1qpu_{lattice}_{noise_key}"
        outdir = OUT / tag
        for n in N_STEPS:
            out_path = outdir / f"{tag}_n{n}.csv"
            if out_path.exists():
                print(f"SKIP {out_path.name}")
                continue
            if lattice == "1d":
                qc = build_plaquette_circuit_121(9, 0.1, n, 1.0)
            else:
                qc = build_plaquette_circuit_2d_121(3, 3, 0.1, n, 1.0)
            rows = run_circuit(qc, sim, SHOTS)
            write_csv(out_path, rows, qc.num_qubits)
            # compute center P(1) on the fly
            center = 4
            p1 = sum(r[center] for r in rows) / len(rows)
            print(f"  {tag} n={n}: P(center=1)={p1:.4f}  ({len(rows)} shots)")
print("DONE")
