# Generate QASM for n=15, 20 — 1QPU, 2QPU, 3QPU, 1D + 2D.
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
# Usage:  conda run -n qndk python gen_qasm_n15_n20.py

import io
import re
import sys
from pathlib import Path

sys.path.insert(0, "qnpack/dqc/experiments/plaquette")

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from qiskit.qasm3 import dump as qasm3_dump

from plaquette_chain_121 import build_plaquette_circuit_121
from plaquette_2d_121 import build_plaquette_circuit_2d_121
from qndk.quantum_network import QPUSpec, build_rack, QubitLayout
from qndk.partition.kl import KernighanLinPartitioner
from qndk.compile.distributed import new_exec_plan

QASM_DIR = Path("qnpack/dqc/qasm/plaquette_sweep")
QASM_DIR.mkdir(parents=True, exist_ok=True)

g, dt = 1.0, 0.1
n_plaq, lx, ly = 9, 3, 3
N_STEPS = [15, 20]


def _to_cisco_gates(s: str) -> str:
    s = re.sub(r"^p\(", "u1(", s, flags=re.MULTILINE)
    s = re.sub(r"^U\(pi/2, 0, pi\) ", "h ", s, flags=re.MULTILINE)
    return s


def make_network(num_qpus, comp, comm):
    return build_rack(
        num_qpus=num_qpus,
        qpu_spec=QPUSpec(
            comp_qubits=comp,
            comm_qubits=comm,
            connectivity="all2all",
            layout=QubitLayout(flatten=True),
        ),
    )


def compile_and_write(qc, path, num_qpus, comp, comm, fix_gates=False):
    if path.exists():
        print(f"  SKIP {path.name} (exists)")
        return
    network = make_network(num_qpus, comp, comm)
    kl = KernighanLinPartitioner(circuit=qc, network=network)
    p = kl.partition()
    network.plot(partition_result=p)
    plt.savefig(str(path).replace(".qasm", "_network.png"), dpi=80)
    plt.close()
    ep = new_exec_plan(p)
    buf = io.StringIO()
    qasm3_dump(ep.circuit, buf)
    content = _to_cisco_gates(buf.getvalue()) if fix_gates else buf.getvalue()
    path.write_text(content)
    print(f"  wrote {path.name}")


for n in N_STEPS:
    print(f"\n=== n={n} ===")

    qc1d = build_plaquette_circuit_121(n_plaq, dt, n, g)
    qc1d.measure_all()
    qc2d = build_plaquette_circuit_2d_121(lx, ly, dt, n, g)
    qc2d.measure_all()

    # 1QPU — single rack, 9 comp/comm qubits (no real partitioning)
    compile_and_write(
        qc1d,
        QASM_DIR / f"9qubit_1qpu_plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n}.qasm",
        num_qpus=1, comp=9, comm=9, fix_gates=True,
    )
    compile_and_write(
        qc2d,
        QASM_DIR / f"9qubit_1qpu_plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n}.qasm",
        num_qpus=1, comp=9, comm=9, fix_gates=True,
    )

    # 2QPU — 5 comp/comm per QPU
    compile_and_write(
        qc1d,
        QASM_DIR / f"9qubit_2qpu_plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n}.qasm",
        num_qpus=2, comp=5, comm=5, fix_gates=True,
    )
    compile_and_write(
        qc2d,
        QASM_DIR / f"9qubit_2qpu_plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n}.qasm",
        num_qpus=2, comp=5, comm=5, fix_gates=True,
    )

    # 3QPU — 3 comp/comm per QPU, needs gate name fix for Cisco sim
    compile_and_write(
        qc1d,
        QASM_DIR / f"9qubit_3qpu_plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n}.qasm",
        num_qpus=3, comp=3, comm=3, fix_gates=True,
    )
    compile_and_write(
        qc2d,
        QASM_DIR / f"9qubit_3qpu_plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n}.qasm",
        num_qpus=3, comp=3, comm=3, fix_gates=True,
    )

print("\nDone — all QASM files in", QASM_DIR)
