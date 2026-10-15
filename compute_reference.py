import sys
sys.path.insert(0, "qnpack/dqc/experiments/plaquette")
import numpy as np
from plaquette_chain_121 import build_plaquette_circuit_121
from plaquette_2d_121 import build_plaquette_circuit_2d_121
from qiskit.quantum_info import Statevector

n_plaq, g, dt = 9, 1.0, 0.1
lx, ly = 3, 3
center_1d = n_plaq // 2   # qubit 4
center_2d = (lx * ly) // 2  # qubit 4

print("n_steps,p1_1d,p1_2d")
for n in range(0, 21):
    qc1d = build_plaquette_circuit_121(n_plaq, dt, n, g)
    sv1d = Statevector(qc1d)
    p1d = sv1d.probabilities([center_1d])[1]

    qc2d = build_plaquette_circuit_2d_121(lx, ly, dt, n, g)
    sv2d = Statevector(qc2d)
    p2d = sv2d.probabilities([center_2d])[1]

    print(f"{n},{p1d:.6f},{p2d:.6f}")
