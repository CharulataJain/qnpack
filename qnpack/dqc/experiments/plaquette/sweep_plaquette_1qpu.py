# run with:
#     conda run -n qndk python -m qnpack.dqc.experiments.plaquette.sweep_plaquette_1qpu

import os
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from qiskit.qasm3 import dump as qasm3_dump

from .plaquette_chain_121 import build_plaquette_circuit_121
from .plaquette_2d_121 import build_plaquette_circuit_2d_121

from qndk.quantum_network import QPUSpec, build_rack, QubitLayout
from qndk.partition.kl import KernighanLinPartitioner
from qndk.compile.distributed import new_exec_plan

QASM_DIR = Path(__file__).resolve().parent.parent.parent.parent / "qasm" / "plaquette_sweep"


def run(qc, filename):
    # Single QPU with 9 compute qubits — the 9-qubit plaquette fits on one QPU
    # without partitioning, as advised by the Cisco team.
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
    plt.savefig(str(filename).replace(".qasm", "_network.png"), dpi=100)
    plt.close()

    ep = new_exec_plan(p)

    with open(filename, "w") as f:
        qasm3_dump(ep.circuit, f)
    print(f"  wrote {filename}")


def filename_2d(lx: int, ly: int, g: float, dt: float, n_steps: int) -> str:
    return f"9qubit_1qpu_plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"


def filename_1d(n_plaq: int, g: float, dt: float, n_steps: int) -> str:
    return f"9qubit_1qpu_plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"


if __name__ == '__main__':
    QASM_DIR.mkdir(parents=True, exist_ok=True)

    n_plaq = 9
    g = 1.0
    dt = 0.1
    lx = 3
    ly = 3

    for n_steps in [0, 2, 4, 6, 8, 10]:
        print(f"\n=== n_steps={n_steps} ===")

        path_1d = QASM_DIR / filename_1d(n_plaq, g, dt, n_steps)
        qc_1d = build_plaquette_circuit_121(n_plaq, dt, n_steps, g)
        qc_1d.measure_all()
        print(f"1D: {qc_1d.num_qubits} qubits, depth={qc_1d.depth()}")
        run(qc_1d, path_1d)

        path_2d = QASM_DIR / filename_2d(lx, ly, g, dt, n_steps)
        qc_2d = build_plaquette_circuit_2d_121(lx, ly, dt, n_steps, g)
        qc_2d.measure_all()
        print(f"2D: {qc_2d.num_qubits} qubits, depth={qc_2d.depth()}")
        run(qc_2d, path_2d)
