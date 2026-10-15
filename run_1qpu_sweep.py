# Standalone runner — does not import the qnpack package.
# Run with: conda run -n qndk python run_1qpu_sweep.py

import sys
from pathlib import Path

# Point directly at the plaquette source files
plaq_dir = Path(__file__).resolve().parent / "qnpack" / "dqc" / "experiments" / "plaquette"
sys.path.insert(0, str(plaq_dir))

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

from plaquette_chain_121 import build_plaquette_circuit_121
from plaquette_2d_121 import build_plaquette_circuit_2d_121
from qiskit.qasm3 import dump as qasm3_dump
from qndk.quantum_network import QPUSpec, build_rack, QubitLayout
from qndk.partition.kl import KernighanLinPartitioner
from qndk.compile.distributed import new_exec_plan

QASM_DIR = Path(__file__).resolve().parent / "qnpack" / "dqc" / "qasm" / "plaquette_sweep"


def run(qc, filepath):
    network = build_rack(
        num_qpus=1,
        qpu_spec=QPUSpec(
            comp_qubits=9,
            comm_qubits=9,
            connectivity="all2all",
            layout=QubitLayout(flatten=True),
        ),
    )
    kl = KernighanLinPartitioner(circuit=qc, network=network)
    p = kl.partition()
    network.plot(partition_result=p)
    plt.savefig(str(filepath).replace(".qasm", "_network.png"), dpi=100)
    plt.close()
    ep = new_exec_plan(p)
    with open(filepath, "w") as f:
        qasm3_dump(ep.circuit, f)
    print(f"  wrote {filepath.name}")


if __name__ == "__main__":
    QASM_DIR.mkdir(parents=True, exist_ok=True)
    n_plaq, g, dt, lx, ly = 9, 1.0, 0.1, 3, 3

    for n_steps in [0, 2, 4, 6, 8, 10]:
        print(f"\n=== n_steps={n_steps} ===")

        qc_1d = build_plaquette_circuit_121(n_plaq, dt, n_steps, g)
        qc_1d.measure_all()
        print(f"1D: {qc_1d.num_qubits} qubits, depth={qc_1d.depth()}")
        path_1d = QASM_DIR / f"9qubit_1qpu_plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"
        run(qc_1d, path_1d)

        qc_2d = build_plaquette_circuit_2d_121(lx, ly, dt, n_steps, g)
        qc_2d.measure_all()
        print(f"2D: {qc_2d.num_qubits} qubits, depth={qc_2d.depth()}")
        path_2d = QASM_DIR / f"9qubit_1qpu_plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"
        run(qc_2d, path_2d)
