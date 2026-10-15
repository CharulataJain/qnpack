import sys
from pathlib import Path
sys.path.insert(0, "qnpack/dqc/experiments/plaquette")

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

from plaquette_chain_121 import build_plaquette_circuit_121
from plaquette_2d_121 import build_plaquette_circuit_2d_121
from qiskit.qasm3 import dump as qasm3_dump
from qndk.quantum_network import QPUSpec, build_rack, QubitLayout
from qndk.partition.kl import KernighanLinPartitioner
from qndk.compile.distributed import new_exec_plan

QASM_DIR = Path("qnpack/dqc/qasm/plaquette_sweep")
g, dt = 1.0, 0.1

def run2qpu(qc, filepath):
    network = build_rack(
        num_qpus=2,
        qpu_spec=QPUSpec(comp_qubits=5, comm_qubits=5, connectivity="all2all",
                         layout=QubitLayout(flatten=True)),
    )
    kl = KernighanLinPartitioner(circuit=qc, network=network)
    p = kl.partition()
    network.plot(partition_result=p)
    plt.savefig(str(filepath).replace(".qasm", "_network.png"), dpi=80)
    plt.close()
    ep = new_exec_plan(p)
    with open(filepath, "w") as f:
        qasm3_dump(ep.circuit, f)
    print(f"  wrote {filepath.name}")

for n in [8]:
    qc1d = build_plaquette_circuit_121(9, dt, n, g); qc1d.measure_all()
    run2qpu(qc1d, QASM_DIR / f"9qubit_2qpu_plaq121_obc_L9_g{g:.3f}_dt{dt:.4f}_n{n}.qasm")

    qc2d = build_plaquette_circuit_2d_121(3, 3, dt, n, g); qc2d.measure_all()
    run2qpu(qc2d, QASM_DIR / f"9qubit_2qpu_plaq2d121_obc_Lx3_Ly3_g{g:.3f}_dt{dt:.4f}_n{n}.qasm")
