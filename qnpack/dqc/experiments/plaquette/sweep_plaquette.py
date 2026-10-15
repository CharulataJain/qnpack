# run with:
#     python -m sweep_plaquette

import os

import matplotlib.pyplot as plt
from qiskit.qasm3 import dump as qasm3_dump

from .plaquette_chain_121 import build_plaquette_circuit_121
from .plaquette_2d_121 import build_plaquette_circuit_2d_121

from qndk.quantum_network import QPUSpec, build_rack, QubitLayout
from qndk.partition.kl import KernighanLinPartitioner
from qndk.compile.distributed import new_exec_plan


# more documentation about Cisco's Network-Aware Compiler here:
#     https://outshift.cisco.com/docs/qndk

def run(qc, filename):
    num_qubits = 5
    network = build_rack(
        num_qpus=4,
        qpu_spec=QPUSpec(
            comp_qubits=num_qubits,
            comm_qubits=num_qubits,
            connectivity="all2all",
            layout=QubitLayout(flatten=True),
        ),
    )

    kl = KernighanLinPartitioner(circuit=qc, network=network)
    p = kl.partition()

    network.plot(partition_result=p) # plots the network structure
    plt.show()

    ep = new_exec_plan(p) # compile the circuit for distributed execution

    #with open(filename, "w") as f:
    #    qasm3_dump(ep.circuit, f)


def filename_2d(lx: int, ly: int, g: float, dt: float, n_steps: int) -> str:
    return f"9qubit_2qpu_plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"


def filename_1d(n_plaq: int, g: float, dt: float, n_steps: int) -> str:
    return f"9qubit_2qpu_plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"


if __name__ == '__main__':
    n_plaq = 9
    g = 1.0
    dt = 0.1
    lx = 3
    ly = 3
    for n_steps in [0, 2, 4, 5, 6, 10]:
        path_1d = os.path.abspath(filename_1d(n_plaq, g, dt, n_steps))
        qc_1d = build_plaquette_circuit_121(n_plaq, dt, n_steps, g)
        qc_1d.measure_all()
        run(qc_1d, path_1d)

        path_2d = os.path.abspath(filename_2d(lx, ly, g, dt, n_steps))
        qc_2d = build_plaquette_circuit_2d_121(lx, ly, dt, n_steps, g)
        qc_2d.measure_all()
        run(qc_2d, path_2d)
