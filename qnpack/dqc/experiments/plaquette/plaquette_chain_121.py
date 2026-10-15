"""
plaquette_chain_121.py — Trotterized time evolution for the (1,2,1) plaquette chain.

Implements Eq. (16) of "Efficient Truncations of SU(N_c) Lattice Gauge Theory
for Quantum Simulation" (arXiv:2503.11888): the (n_p=1, n_l=2, k=1) truncation
in the non-local loop basis (even charge-conjugation sector), one qubit per
plaquette, specialized to a 1D chain with OPEN boundary conditions.

Hamiltonian (n_x = |1><1| = (I - Z)/2,  P_x = |0><0| = (I + Z)/2,
A = g² (N_c - 1/N_c),  a = 1/√2,  b = 1/(2 N_c),  N_c = 3):

  H = Σ_x  A n_x
    - (A/2) Σ_<x,x+1>  n_x n_{x+1}
    - (1/g²) Σ_x  [ a P_{x-1} P_{x+1}
                  + b ( n_{x-1} P_{x+1} + P_{x-1} n_{x+1} ) ] X_x

  (The paper's Σ_n̂ in the nearest-neighbour electric term counts each chain
   bond twice, giving the A/2 per-bond coefficient above.)

Boundary conditions (OBC): missing neighbour factors are dropped (treated as
identity), matching the (1,1,1) code convention.  Edge sites get the dressed
hopping [a P_nb + b n_nb] X_x; for a single plaquette (L=1) the hopping is
just -a/g² X_0 and there are no bond or suppressed terms.

Trotter decomposition (second-order / Strang):
  S(dt) = E(dt/2) · M_odd(dt/2) · M_even(dt) · M_odd(dt/2) · E(dt/2)

  - E: Rz rotations + ZZ bond rotations (all diagonal, commuting: exact
    in one layer)
  - M_even/M_odd: dressed-hopping terms centred on even/odd sites.
    Terms at x and x+2 overlap only on qubit x+1 where both act diagonally
    (Z or I), so each layer is a product of commuting exponentials.

  The palindromic ordering gives per-step error O(dt³), global error O(dt²).
  When steps are chained, the trailing E(dt/2) of one step and the leading
  E(dt/2) of the next are merged into a single E(dt) layer (the rotation
  angles simply add), so interior steps carry only one electric layer —
  the two-qubit ZZ gadgets between neighbouring steps cancel exactly.

Each dressed-hopping term exp(-i τ D X_x) is compiled as a multiplexed Rz
between Hadamards on x (Gray-code CX pattern), costing 4 CX / two-qubit
depth 4 per interior plaquette (2 CX at the chain edges) instead of the
8 CX a term-by-term Pauli exponential would need.

Setting b = 0 and dropping the ZZ bond terms recovers the (1,1,1) Hamiltonian
of plaquette_chain.py (up to an identity constant).

Usage:
  python plaquette_chain_121.py --g 1.0 --dt 0.1 --n-plaq 6 --n-steps 10
"""

import argparse
import os

import numpy as np
from qiskit import QuantumCircuit
from qiskit.quantum_info import SparsePauliOp, Statevector

N_C = 3  # hardcoded number of colours


# ─────────────────────────────────────────────────────────────────────────────
# 1.  Pauli-string exponential gadget  (copied verbatim from pxp_trotter.py)
# ─────────────────────────────────────────────────────────────────────────────

def apply_pauli_exp(qc: QuantumCircuit, qubits: list, paulis: list, theta: float):
    """
    Append exp(-i * theta * ⊗_k paulis[k]) to qc, acting on qubits.

    Implements the standard CNOT-ladder gadget:
      1. Rotate each qubit into the Z basis  (H for X, S†H for Y)
      2. CNOT chain:  cx(q[k], q[k+1])  for k = 0 … len-2
      3. Rz(2*theta) on the last qubit  [Rz(λ) = exp(-i λ/2 Z)]
      4. Reverse CNOT chain
      5. Undo basis rotations

    Parameters
    ----------
    qubits : qubit indices (any order, any length ≥ 1)
    paulis : matching Pauli characters ('X', 'Y', 'Z')
    theta  : rotation angle for exp(-i theta P)
    """
    # 1. Basis change into Z
    for q, p in zip(qubits, paulis):
        if p == "X":
            qc.h(q)
        elif p == "Y":
            qc.sdg(q); qc.h(q)

    # 2. CNOT chain toward last qubit
    for k in range(len(qubits) - 1):
        qc.cx(qubits[k], qubits[k + 1])

    # 3. Rz on last qubit: Rz(2θ) = exp(-i θ Z)
    qc.rz(2.0 * theta, qubits[-1])

    # 4. Reverse CNOT chain
    for k in reversed(range(len(qubits) - 1)):
        qc.cx(qubits[k], qubits[k + 1])

    # 5. Undo basis change
    for q, p in zip(qubits, paulis):
        if p == "X":
            qc.h(q)
        elif p == "Y":
            qc.h(q); qc.s(q)


# ─────────────────────────────────────────────────────────────────────────────
# 2.  Term builders (single source of truth for Hamiltonian AND circuit)
# ─────────────────────────────────────────────────────────────────────────────

def magnetic_site_terms(x: int, n_plaq: int) -> list:
    """
    Pauli decomposition of the dressed hopping at site x, WITHOUT the overall
    -1/g² prefactor.

    The operator is  D ⊗ X_x  with
      D = a Π_nb P_nb  +  b Σ_k n_k Π_{nb≠k} P_nb        (nb over OBC neighbours)
    expanded via P = (I+Z)/2 → {I: +1/2, Z: +1/2} and
                 n = (I-Z)/2 → {I: +1/2, Z: -1/2}.

    Returns a list of (pauli_map, coeff) with pauli_map = {qubit: 'X'/'Z'}.
    Every term contains X_x; equal Pauli maps from different D-contributions
    are merged.
    """
    a = 1.0 / np.sqrt(2)   # leading (all-neighbours-in-|0>) coefficient
    b = 1.0 / (2 * N_C)    # 1/N_c-suppressed (one neighbour excited) coefficient

    neighbours = [nb for nb in (x - 1, x + 1) if 0 <= nb < n_plaq]

    # Each contribution to D: (coefficient, {neighbour: 'P' or 'n'})
    contributions = [(a, {nb: "P" for nb in neighbours})]
    for k in neighbours:
        contributions.append(
            (b, {nb: ("n" if nb == k else "P") for nb in neighbours})
        )

    # Expand each contribution into {I, Z} strings on the neighbours.
    collected = {}  # frozenset of Z-neighbours -> coefficient
    for coeff, proj_map in contributions:
        expansions = [(coeff, frozenset())]
        for nb, kind in proj_map.items():
            sign = 1.0 if kind == "P" else -1.0
            expansions = [
                new
                for c, zs in expansions
                for new in ((0.5 * c, zs), (0.5 * sign * c, zs | {nb}))
            ]
        for c, zs in expansions:
            collected[zs] = collected.get(zs, 0.0) + c

    terms = []
    for zs, coeff in sorted(collected.items(), key=lambda kv: sorted(kv[0])):
        pauli_map = {x: "X"}
        for nb in zs:
            pauli_map[nb] = "Z"
        terms.append((pauli_map, coeff))
    return terms


def electric_z_coeffs(n_plaq: int, g: float):
    """
    Pauli decomposition of the diagonal electric part
      H_E = A Σ_x n_x - (A/2) Σ_<x,x+1> n_x n_{x+1},   A = g²(N_c - 1/N_c).

    Returns (z_coeffs, zz_coeff, identity_const):
      z_coeffs[x]    = A (deg(x)/8 - 1/2)   coefficient of Z_x
      zz_coeff       = -A/8                 coefficient of each Z_x Z_{x+1}
      identity_const = A [L/2 - (L-1)/8]    (kept in the SparsePauliOp only;
                                             a global phase in the circuit)
    """
    A = g**2 * (N_C - 1.0 / N_C)
    z_coeffs = []
    for x in range(n_plaq):
        deg = int(x > 0) + int(x < n_plaq - 1)
        z_coeffs.append(A * (deg / 8.0 - 0.5))
    zz_coeff = -A / 8.0
    identity_const = A * (n_plaq / 2.0 - (n_plaq - 1) / 8.0)
    return z_coeffs, zz_coeff, identity_const


# ─────────────────────────────────────────────────────────────────────────────
# 3.  Hamiltonian
# ─────────────────────────────────────────────────────────────────────────────

def plaquette_hamiltonian_121(n_plaq: int, g: float) -> SparsePauliOp:
    """
    Build the (1,2,1) plaquette chain Hamiltonian (OBC) as a SparsePauliOp,
    INCLUDING the identity constant from the electric part, so that
    <0...0| H |0...0> = 0 (electric vacuum).

    Qiskit Pauli string convention: qubit 0 is the RIGHTMOST character.
    """
    terms = []

    def pauli_str(pauli_map):
        pauli_list = ["I"] * n_plaq
        for q, p in pauli_map.items():
            pauli_list[q] = p
        return "".join(reversed(pauli_list))

    # ── Electric part (diagonal) ────────────────────────────────────────────
    z_coeffs, zz_coeff, identity_const = electric_z_coeffs(n_plaq, g)
    terms.append(("I" * n_plaq, identity_const))
    for x in range(n_plaq):
        terms.append((pauli_str({x: "Z"}), z_coeffs[x]))
    for x in range(n_plaq - 1):
        terms.append((pauli_str({x: "Z", x + 1: "Z"}), zz_coeff))

    # ── Magnetic part (dressed hopping, overall -1/g²) ──────────────────────
    mag_prefactor = -1.0 / g**2
    for x in range(n_plaq):
        for pauli_map, coeff in magnetic_site_terms(x, n_plaq):
            terms.append((pauli_str(pauli_map), mag_prefactor * coeff))

    return SparsePauliOp.from_list(terms).simplify()


# ─────────────────────────────────────────────────────────────────────────────
# 4.  Trotter step
# ─────────────────────────────────────────────────────────────────────────────

def apply_dressed_hopping(qc: QuantumCircuit, x: int, n_plaq: int, tau: float):
    """
    Append exp(-i * tau * D ⊗ X_x) to qc, where D is the diagonal neighbour
    operator whose Pauli decomposition is given by magnetic_site_terms(x).

    Compiled as a multiplexed Rz conjugated by H on x:
      H_x · [Rz(2φ1) CX(L,x) Rz(2φ2) CX(R,x) Rz(2φ3) CX(L,x) Rz(2φ4) CX(R,x)] · H_x

    In the control subspace with Z-eigenvalues (z_L, z_R), each CX(c, x)
    flips the sign of every later Rz when z_c = -1, so the net rotation is
    exp(-i [φ1 + φ2 z_L + φ3 z_L z_R + φ4 z_R] Z_x) — the Walsh expansion of
    D — giving (φ1, φ2, φ3, φ4) = tau · (θ_II, θ_L, θ_LR, θ_R).

    Cost: 4 CX (two-qubit depth 4) per interior plaquette, 2 CX at an edge,
    0 CX for a single-plaquette chain.
    """
    coeff = {
        frozenset(q for q, p in pauli_map.items() if p == "Z"): c
        for pauli_map, c in magnetic_site_terms(x, n_plaq)
    }
    neighbours = [nb for nb in (x - 1, x + 1) if 0 <= nb < n_plaq]

    qc.h(x)
    if len(neighbours) == 0:
        qc.rz(2.0 * tau * coeff[frozenset()], x)
    elif len(neighbours) == 1:
        nb = neighbours[0]
        qc.rz(2.0 * tau * coeff[frozenset()], x)
        qc.cx(nb, x)
        qc.rz(2.0 * tau * coeff[frozenset({nb})], x)
        qc.cx(nb, x)
    else:
        left, right = neighbours
        qc.rz(2.0 * tau * coeff[frozenset()], x)
        qc.cx(left, x)
        qc.rz(2.0 * tau * coeff[frozenset({left})], x)
        qc.cx(right, x)
        qc.rz(2.0 * tau * coeff[frozenset({left, right})], x)
        qc.cx(left, x)
        qc.rz(2.0 * tau * coeff[frozenset({right})], x)
        qc.cx(right, x)
    qc.h(x)

def _electric_layer(qc: QuantumCircuit, n_plaq: int, g: float, dt: float):
    """
    Append exp(-i dt H_E) — the diagonal electric part (identity constant
    dropped as a global phase).  All terms commute, so the layer is exact:
      exp(-i dt c Z) = Rz(2 c dt)   [Rz(λ) = exp(-i λ Z / 2)]
    """
    z_coeffs, zz_coeff, _ = electric_z_coeffs(n_plaq, g)
    for x in range(n_plaq):
        qc.rz(2.0 * z_coeffs[x] * dt, x)
    for x in range(n_plaq - 1):
        apply_pauli_exp(qc, [x, x + 1], ["Z", "Z"], zz_coeff * dt)


def _magnetic_layer(qc: QuantumCircuit, n_plaq: int, g: float, dt: float,
                    parity: int):
    """
    Append exp(-i dt Σ_{x ≡ parity (mod 2)} dressed hopping at x).
    Terms centred on x and x+2 overlap only on qubit x+1 where both act
    diagonally, so the layer is a product of commuting exponentials (exact).
    """
    for x in range(parity, n_plaq, 2):
        apply_dressed_hopping(qc, x, n_plaq, (-1.0 / g**2) * dt)


def trotter_step_121(n_plaq: int, dt: float, g: float) -> QuantumCircuit:
    """
    One second-order (Strang) Trotter step for the (1,2,1) chain (OBC):

      S(dt) = E(dt/2) · M_odd(dt/2) · M_even(dt) · M_odd(dt/2) · E(dt/2)

    Per-step error O(dt³), global error O(dt²).  Note that
    build_plaquette_circuit_121 does NOT compose this function directly:
    it merges the adjacent E(dt/2) half-layers of neighbouring steps into
    single E(dt) layers (unitarily identical, fewer gates).
    """
    qc = QuantumCircuit(n_plaq)
    _electric_layer(qc, n_plaq, g, 0.5 * dt)
    _magnetic_layer(qc, n_plaq, g, 0.5 * dt, 1)
    _magnetic_layer(qc, n_plaq, g, dt, 0)
    _magnetic_layer(qc, n_plaq, g, 0.5 * dt, 1)
    _electric_layer(qc, n_plaq, g, 0.5 * dt)
    return qc


# ─────────────────────────────────────────────────────────────────────────────
# 5.  Full evolution circuit
# ─────────────────────────────────────────────────────────────────────────────

def build_plaquette_circuit_121(
    n_plaq: int,
    dt: float,
    n_steps: int,
    g: float,
    initial_state: str = "Zero",
) -> QuantumCircuit:
    """
    Initial-state preparation followed by n_steps second-order Trotter steps
    (total evolution time T = n_steps * dt).

    Adjacent electric half-layers of neighbouring steps are merged, so the
    circuit is
      E(dt/2) · [M_odd(dt/2) M_even(dt) M_odd(dt/2) · E(dt)]^(n-1)
              ·  M_odd(dt/2) M_even(dt) M_odd(dt/2) · E(dt/2)
    which equals S(dt)^n exactly (the diagonal rotation angles simply add)
    while saving one full electric layer — 2(L-1) CX — per step boundary.

    initial_state: "Zero" (electric vacuum |0...0>), "Neel", or "Plus".
    """
    qc = QuantumCircuit(n_plaq)

    if initial_state == "Zero":
        pass
    elif initial_state == "Neel":
        for q in range(0, n_plaq, 2):
            qc.x(q)
    elif initial_state == "Plus":
        qc.h(range(n_plaq))
    else:
        raise ValueError(f"Unknown initial_state: {initial_state!r}")

    if n_steps > 0:
        _electric_layer(qc, n_plaq, g, 0.5 * dt)
        for k in range(n_steps):
            _magnetic_layer(qc, n_plaq, g, 0.5 * dt, 1)
            _magnetic_layer(qc, n_plaq, g, dt, 0)
            _magnetic_layer(qc, n_plaq, g, 0.5 * dt, 1)
            is_last = (k == n_steps - 1)
            _electric_layer(qc, n_plaq, g, 0.5 * dt if is_last else dt)
    return qc


# ─────────────────────────────────────────────────────────────────────────────
# 6.  Command-line interface
# ─────────────────────────────────────────────────────────────────────────────

def qasm_filename(n_plaq: int, g: float, dt: float, n_steps: int) -> str:
    return f"plaq121_obc_L{n_plaq}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"


def main():
    parser = argparse.ArgumentParser(
        description="Trotterized time evolution circuit for the (1,2,1) "
                    "plaquette chain (Eq. 16 of arXiv:2503.11888), OBC, N_c=3."
    )
    parser.add_argument("--g", type=float, required=True,
                        help="gauge coupling g")
    parser.add_argument("--dt", type=float, required=True,
                        help="Trotter step size dt")
    parser.add_argument("--n-plaq", type=int, required=True,
                        help="number of plaquettes in the chain (= qubits)")
    parser.add_argument("--n-steps", type=int, required=True,
                        help="number of second-order (Strang) Trotter steps")
    parser.add_argument("--validate", action="store_true",
                        help="compare the circuit against exact expm evolution "
                             "(small chains only)")
    args = parser.parse_args()

    if args.g == 0:
        parser.error("g must be nonzero (magnetic coefficients ~ 1/g²)")
    if args.n_plaq < 1:
        parser.error("--n-plaq must be >= 1")
    if args.n_steps < 0:
        parser.error("--n-steps must be >= 0")

    qc = build_plaquette_circuit_121(args.n_plaq, args.dt, args.n_steps, args.g)

    path = os.path.abspath(qasm_filename(args.n_plaq, args.g, args.dt, args.n_steps))
    from qiskit import qasm2
    with open(path, "w") as f:
        qasm2.dump(qc, f)

    print(f"(1,2,1) plaquette chain, OBC, N_c = {N_C}")
    print(f"  g = {args.g},  dt = {args.dt},  L = {args.n_plaq},  "
          f"steps = {args.n_steps}  (T = {args.n_steps * args.dt})")
    print(f"  qubits = {qc.num_qubits},  depth = {qc.depth()},  "
          f"gates = {dict(qc.count_ops())}")
    print(f"  QASM written to {path}")

    if args.validate:
        if args.n_plaq > 10:
            print("  [validate] skipped: --n-plaq > 10")
        else:
            from scipy.linalg import expm
            H = plaquette_hamiltonian_121(args.n_plaq, args.g).to_matrix()
            psi0 = Statevector.from_label("0" * args.n_plaq)
            exact = expm(-1j * args.n_steps * args.dt * H) @ psi0.data
            trotter = Statevector(qc)
            fidelity = np.abs(np.vdot(exact, trotter.data)) ** 2
            print(f"  [validate] |<exact|trotter>|² = {fidelity:.10f}")


if __name__ == "__main__":
    main()
