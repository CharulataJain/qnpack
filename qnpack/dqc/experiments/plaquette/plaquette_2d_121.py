"""
plaquette_2d_121.py — Trotterized time evolution for the (1,2,1) truncation on a
two-dimensional square lattice of plaquettes.

Implements Eq. (16) of "Efficient Truncations of SU(N_c) Lattice Gauge Theory
for Quantum Simulation" (arXiv:2503.11888): the (n_p=1, n_l=2, k=1) truncation
in the non-local loop basis (even charge-conjugation sector), one qubit per
plaquette, on an Lx × Ly square lattice with OPEN boundary conditions.

Hamiltonian (n_p = |1><1| = (I - Z)/2,  P_p = |0><0| = (I + Z)/2,
A = g² (N_c - 1/N_c),  a = 1/√2,  b = 1/(2 N_c),  N_c = 3):

  H = Σ_p  A n_p
    - (A/2) Σ_<p,q>  n_p n_q
    - (1/g²) Σ_p  [ a Π_{nb} P_nb
                  + b Σ_k n_k Π_{nb≠k} P_nb ] X_p

  where nb runs over the nearest neighbours (±x, ±y) of plaquette p that
  exist on the open lattice (≤ 4), and <p,q> over nearest-neighbour bonds.
  (The paper's Σ_p Σ_n̂ in the nearest-neighbour electric term counts each
   bond twice, giving the A/2 per-bond coefficient above.)

Boundary conditions (OBC): missing neighbour factors are dropped (treated as
identity), matching the plaquette-chain convention.  Corner plaquettes have 2
neighbours, edge plaquettes 3, interior plaquettes 4.  For Ly = 1 this module
reproduces plaquette_chain_121.py (same gates, unitarily identical; the gates
are emitted in a different order, see "Gate scheduling" below).

Qubit layout: plaquette (i, j) with 0 <= i < Lx, 0 <= j < Ly is qubit
q = i + Lx * j (row-major).

Trotter decomposition (second-order / Strang):
  S(dt) = E(dt/2) · M_odd(dt/2) · M_even(dt) · M_odd(dt/2) · E(dt/2)

  - E: Rz rotations + ZZ bond rotations (all diagonal, commuting: exact
    in one layer)
  - M_even/M_odd: dressed-hopping terms centred on plaquettes with
    (i + j) even / odd (checkerboard colouring).  Two terms in the same
    layer sit on non-adjacent plaquettes, so neither X acts on a qubit the
    other touches; they overlap only on qubits where both act diagonally
    (Z or I), and each layer is a product of commuting exponentials.

  The palindromic ordering gives per-step error O(dt³), global error O(dt²).
  When steps are chained, the trailing E(dt/2) of one step and the leading
  E(dt/2) of the next are merged into a single E(dt) layer (the rotation
  angles simply add), so interior steps carry only one electric layer.

Each dressed-hopping term exp(-i τ D X_p) is compiled as a multiplexed Rz
between Hadamards on p, walking the reflected Gray code over the m ≤ 4
neighbour controls: 2^m CX per plaquette (16 interior, 8 edge, 4 corner)
instead of the 2^m · 2m CX a term-by-term Pauli exponential would need.

Gate scheduling (size-independent depth):
  Qiskit's depth follows the emitted gate order and does not reorder
  commuting gates, so gates are emitted in an order whose dependency depth
  does not grow with the lattice:
  - E: the ZZ bond gadgets are emitted in the four edge-colour classes of
    the square lattice (horizontal bonds with even/odd i, vertical bonds
    with even/odd j).  Bonds of one colour are disjoint, so the layer has
    CX depth 8 for any Lx, Ly.
  - M: the Gray-code sequences of all plaquettes in the layer are emitted
    round by round (interior plaquettes first); in each round every
    plaquette advances one (Rz, CX) step provided its control qubit has not
    been used in that round yet.  Interior plaquettes flip the same
    direction in the same round and therefore never collide, giving CX
    depth 16 (the lower bound); boundary plaquettes with shorter Gray codes
    add at most one round.
  A standalone step therefore has CX depth ≈ 8 + 3·16 + 8 ≈ 66, and an
  interior step (merged electric layers) ≈ 58, for every lattice size.

Usage:
  python plaquette_2d_121.py --g 1.0 --dt 0.1 --lx 3 --ly 3 --n-steps 10

  python examples/utils/esnet/esnet_plaquette_2d_121.py --g 1.0 --dt 0.1 --lx 3 --ly 3 --n-steps 10
"""

import argparse
import os

import numpy as np
from qiskit import QuantumCircuit
from qiskit.quantum_info import SparsePauliOp, Statevector

N_C = 3  # hardcoded number of colours


# ─────────────────────────────────────────────────────────────────────────────
# 0.  Lattice helpers (open boundary conditions)
# ─────────────────────────────────────────────────────────────────────────────

def site_index(i: int, j: int, lx: int) -> int:
    """Row-major qubit index of plaquette (i, j)."""
    return i + lx * j


def site_coords(q: int, lx: int):
    """Inverse of site_index: (i, j) of qubit q."""
    return q % lx, q // lx


def neighbours(q: int, lx: int, ly: int) -> list:
    """
    OBC nearest neighbours of plaquette q in the fixed order [-x, +x, -y, +y]
    (missing ones dropped).  The order fixes the Gray-code gate pattern.
    """
    i, j = site_coords(q, lx)
    out = []
    if i > 0:
        out.append(site_index(i - 1, j, lx))
    if i < lx - 1:
        out.append(site_index(i + 1, j, lx))
    if j > 0:
        out.append(site_index(i, j - 1, lx))
    if j < ly - 1:
        out.append(site_index(i, j + 1, lx))
    return out


def bonds(lx: int, ly: int) -> list:
    """Every nearest-neighbour pair (p, q) exactly once, p < q."""
    out = []
    for j in range(ly):
        for i in range(lx):
            q = site_index(i, j, lx)
            if i < lx - 1:
                out.append((q, site_index(i + 1, j, lx)))
            if j < ly - 1:
                out.append((q, site_index(i, j + 1, lx)))
    return out


def site_parity(q: int, lx: int) -> int:
    """Checkerboard colour (i + j) mod 2 of plaquette q."""
    i, j = site_coords(q, lx)
    return (i + j) % 2


def bond_colour(p: int, q: int, lx: int) -> int:
    """
    Edge colour (0-3) of bond (p, q), p < q: horizontal bonds get 0/1 by
    the parity of i(p), vertical bonds 2/3 by the parity of j(p).  Bonds of
    equal colour share no qubit.
    """
    i, j = site_coords(p, lx)
    if q == p + 1:           # horizontal
        return i % 2
    return 2 + j % 2         # vertical


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

def magnetic_site_terms(q: int, lx: int, ly: int) -> list:
    """
    Pauli decomposition of the dressed hopping at plaquette q, WITHOUT the
    overall -1/g² prefactor.

    The operator is  D ⊗ X_q  with
      D = a Π_nb P_nb  +  b Σ_k n_k Π_{nb≠k} P_nb        (nb over OBC neighbours)
    expanded via P = (I+Z)/2 → {I: +1/2, Z: +1/2} and
                 n = (I-Z)/2 → {I: +1/2, Z: -1/2}.

    Returns a list of (pauli_map, coeff) with pauli_map = {qubit: 'X'/'Z'}.
    Every term contains X_q; equal Pauli maps from different D-contributions
    are merged.  Up to 2^4 = 16 terms for an interior plaquette.
    """
    a = 1.0 / np.sqrt(2)   # leading (all-neighbours-in-|0>) coefficient
    b = 1.0 / (2 * N_C)    # 1/N_c-suppressed (one neighbour excited) coefficient

    nbs = neighbours(q, lx, ly)

    # Each contribution to D: (coefficient, {neighbour: 'P' or 'n'})
    contributions = [(a, {nb: "P" for nb in nbs})]
    for k in nbs:
        contributions.append(
            (b, {nb: ("n" if nb == k else "P") for nb in nbs})
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
        pauli_map = {q: "X"}
        for nb in zs:
            pauli_map[nb] = "Z"
        terms.append((pauli_map, coeff))
    return terms


def electric_z_coeffs(lx: int, ly: int, g: float):
    """
    Pauli decomposition of the diagonal electric part
      H_E = A Σ_p n_p - (A/2) Σ_<p,q> n_p n_q,   A = g²(N_c - 1/N_c).

    Returns (z_coeffs, zz_coeff, identity_const):
      z_coeffs[q]    = A (deg(q)/8 - 1/2)   coefficient of Z_q
      zz_coeff       = -A/8                 coefficient of each bond Z_p Z_q
      identity_const = A [N/2 - N_bonds/8]  (kept in the SparsePauliOp only;
                                             a global phase in the circuit)
    """
    A = g**2 * (N_C - 1.0 / N_C)
    n_plaq = lx * ly
    z_coeffs = []
    for q in range(n_plaq):
        deg = len(neighbours(q, lx, ly))
        z_coeffs.append(A * (deg / 8.0 - 0.5))
    zz_coeff = -A / 8.0
    identity_const = A * (n_plaq / 2.0 - len(bonds(lx, ly)) / 8.0)
    return z_coeffs, zz_coeff, identity_const


# ─────────────────────────────────────────────────────────────────────────────
# 3.  Hamiltonian
# ─────────────────────────────────────────────────────────────────────────────

def plaquette_hamiltonian_2d_121(lx: int, ly: int, g: float) -> SparsePauliOp:
    """
    Build the (1,2,1) Lx × Ly plaquette-lattice Hamiltonian (OBC) as a
    SparsePauliOp, INCLUDING the identity constant from the electric part,
    so that <0...0| H |0...0> = 0 (electric vacuum).

    Qiskit Pauli string convention: qubit 0 is the RIGHTMOST character.
    """
    n_plaq = lx * ly
    terms = []

    def pauli_str(pauli_map):
        pauli_list = ["I"] * n_plaq
        for q, p in pauli_map.items():
            pauli_list[q] = p
        return "".join(reversed(pauli_list))

    # ── Electric part (diagonal) ────────────────────────────────────────────
    z_coeffs, zz_coeff, identity_const = electric_z_coeffs(lx, ly, g)
    terms.append(("I" * n_plaq, identity_const))
    for q in range(n_plaq):
        terms.append((pauli_str({q: "Z"}), z_coeffs[q]))
    for p, q in bonds(lx, ly):
        terms.append((pauli_str({p: "Z", q: "Z"}), zz_coeff))

    # ── Magnetic part (dressed hopping, overall -1/g²) ──────────────────────
    mag_prefactor = -1.0 / g**2
    for q in range(n_plaq):
        for pauli_map, coeff in magnetic_site_terms(q, lx, ly):
            terms.append((pauli_str(pauli_map), mag_prefactor * coeff))

    return SparsePauliOp.from_list(terms).simplify()


# ─────────────────────────────────────────────────────────────────────────────
# 4.  Trotter step
# ─────────────────────────────────────────────────────────────────────────────

def multiplexed_rz_schedule(controls: list, walsh_coeffs: dict, tau: float) -> list:
    """
    Gate schedule for exp(-i tau Σ_S c_S (Π_{k∈S} Z_k) Z_target), where S runs
    over subsets of `controls` and c_S = walsh_coeffs[frozenset(S)] (missing
    keys are treated as 0).

    Returns a list of (rz_angle, control) steps: apply Rz(rz_angle) on the
    target, then CX(control, target) (control is None for the m = 0 case,
    where there is no CX).

    The schedule is a multiplexed Rz walking the reflected Gray code over the
    m = len(controls) control bits.  At step j we apply Rz(2 tau c_{S_j}) on
    the target, S_j being the set of controls whose Gray-code bit is 1, then
    CX(c_j, target) with c_j the control whose bit flips between g(j) and
    g(j+1) (wrapping to g(0) so the ladder closes).  In the control subspace
    with Z-eigenvalues z_k, each CX(k, target) flips the sign of every later
    Rz when z_k = -1, so the accumulated sign of step j is Π_{k∈S_j} z_k and
    the net rotation is exp(-i tau Σ_S c_S Π_{k∈S} z_k Z_target).

    Cost: 2^m CX, 2^m Rz.  For m = 2 with controls [L, R] this is the pattern
    Rz CX(L) Rz CX(R) Rz CX(L) Rz CX(R) of plaquette_chain_121.py.
    """
    m = len(controls)
    if m == 0:
        return [(2.0 * tau * walsh_coeffs.get(frozenset(), 0.0), None)]
    n_codes = 1 << m
    steps = []
    for j in range(n_codes):
        gray = j ^ (j >> 1)
        subset = frozenset(controls[k] for k in range(m) if (gray >> k) & 1)
        j_next = (j + 1) % n_codes
        next_gray = j_next ^ (j_next >> 1)
        flipped_bit = (gray ^ next_gray).bit_length() - 1
        steps.append((2.0 * tau * walsh_coeffs.get(subset, 0.0),
                      controls[flipped_bit]))
    return steps


def apply_multiplexed_rz(qc: QuantumCircuit, target: int, controls: list,
                         walsh_coeffs: dict, tau: float):
    """Append the multiplexed_rz_schedule gates to qc (single target)."""
    for angle, control in multiplexed_rz_schedule(controls, walsh_coeffs, tau):
        qc.rz(angle, target)
        if control is not None:
            qc.cx(control, target)


def dressed_hopping_schedule(q: int, lx: int, ly: int, tau: float) -> list:
    """
    (rz_angle, control) schedule for exp(-i * tau * D ⊗ X_q) between the
    Hadamards on q, with the Walsh coefficients θ_S read off from
    magnetic_site_terms(q).  Cost: 2^deg(q) CX — 16 interior, 8 edge,
    4 corner, 2 for a chain interior site, 0 for a single plaquette.
    """
    coeff = {
        frozenset(k for k, p in pauli_map.items() if p == "Z"): c
        for pauli_map, c in magnetic_site_terms(q, lx, ly)
    }
    return multiplexed_rz_schedule(neighbours(q, lx, ly), coeff, tau)


def apply_dressed_hopping(qc: QuantumCircuit, q: int, lx: int, ly: int, tau: float):
    """
    Append exp(-i * tau * D ⊗ X_q) to qc, where D is the diagonal neighbour
    operator whose Pauli decomposition is given by magnetic_site_terms(q).

    Compiled as H_q · [Gray-code multiplexed Rz over the neighbours] · H_q.
    (Single-site convenience; _magnetic_layer interleaves the schedules of
    all plaquettes in a layer instead.)
    """
    qc.h(q)
    for angle, control in dressed_hopping_schedule(q, lx, ly, tau):
        qc.rz(angle, q)
        if control is not None:
            qc.cx(control, q)
    qc.h(q)


def _electric_layer(qc: QuantumCircuit, lx: int, ly: int, g: float, dt: float):
    """
    Append exp(-i dt H_E) — the diagonal electric part (identity constant
    dropped as a global phase).  All terms commute, so the layer is exact:
      exp(-i dt c Z) = Rz(2 c dt)   [Rz(λ) = exp(-i λ Z / 2)]

    The ZZ bond gadgets are emitted colour by colour (bond_colour), so the
    four groups of disjoint bonds give CX depth 8 for any lattice size.
    """
    z_coeffs, zz_coeff, _ = electric_z_coeffs(lx, ly, g)
    for q in range(lx * ly):
        qc.rz(2.0 * z_coeffs[q] * dt, q)
    all_bonds = bonds(lx, ly)
    for colour in range(4):
        for p, q in all_bonds:
            if bond_colour(p, q, lx) == colour:
                apply_pauli_exp(qc, [p, q], ["Z", "Z"], zz_coeff * dt)


def _magnetic_layer(qc: QuantumCircuit, lx: int, ly: int, g: float, dt: float,
                    parity: int):
    """
    Append exp(-i dt Σ_{(i+j) ≡ parity (mod 2)} dressed hopping at (i, j)).
    Same-colour plaquettes are never adjacent, so terms in one layer overlap
    only on qubits where both act diagonally: the layer is a product of
    commuting exponentials (exact).

    Emission order: the Gray-code schedules of all plaquettes in the layer
    are interleaved round by round.  In each round every plaquette (interior
    ones first) advances one (Rz, CX) step if its control qubit has not been
    used as a control in that round; otherwise it waits for the next round.
    Interior plaquettes flip the same neighbour direction in the same round
    and never collide, so the CX depth is 16 (17 with boundary collisions)
    independent of the lattice size.
    """
    tau = (-1.0 / g**2) * dt
    targets = [q for q in range(lx * ly) if site_parity(q, lx) == parity]
    targets.sort(key=lambda q: -len(neighbours(q, lx, ly)))  # interior first

    schedules = {q: dressed_hopping_schedule(q, lx, ly, tau) for q in targets}
    position = {q: 0 for q in targets}

    for q in targets:
        qc.h(q)
    while any(position[q] < len(schedules[q]) for q in targets):
        used_controls = set()
        for q in targets:
            if position[q] >= len(schedules[q]):
                continue
            angle, control = schedules[q][position[q]]
            if control is not None and control in used_controls:
                continue
            qc.rz(angle, q)
            if control is not None:
                qc.cx(control, q)
                used_controls.add(control)
            position[q] += 1
    for q in targets:
        qc.h(q)


def trotter_step_2d_121(lx: int, ly: int, dt: float, g: float) -> QuantumCircuit:
    """
    One second-order (Strang) Trotter step for the (1,2,1) lattice (OBC):

      S(dt) = E(dt/2) · M_odd(dt/2) · M_even(dt) · M_odd(dt/2) · E(dt/2)

    Per-step error O(dt³), global error O(dt²).  Note that
    build_plaquette_circuit_2d_121 does NOT compose this function directly:
    it merges the adjacent E(dt/2) half-layers of neighbouring steps into
    single E(dt) layers (unitarily identical, fewer gates).
    """
    qc = QuantumCircuit(lx * ly)
    _electric_layer(qc, lx, ly, g, 0.5 * dt)
    _magnetic_layer(qc, lx, ly, g, 0.5 * dt, 1)
    _magnetic_layer(qc, lx, ly, g, dt, 0)
    _magnetic_layer(qc, lx, ly, g, 0.5 * dt, 1)
    _electric_layer(qc, lx, ly, g, 0.5 * dt)
    return qc


# ─────────────────────────────────────────────────────────────────────────────
# 5.  Full evolution circuit
# ─────────────────────────────────────────────────────────────────────────────

def build_plaquette_circuit_2d_121(
    lx: int,
    ly: int,
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
    while saving one full electric layer — 2 N_bonds CX — per step boundary.

    initial_state: "Zero" (electric vacuum |0...0>), "Neel" (X on the
    (i+j)-even checkerboard sublattice), or "Plus".
    """
    n_plaq = lx * ly
    qc = QuantumCircuit(n_plaq)

    if initial_state == "Zero":
        pass
    elif initial_state == "Neel":
        for q in range(n_plaq):
            if site_parity(q, lx) == 0:
                qc.x(q)
    elif initial_state == "Plus":
        qc.h(range(n_plaq))
    else:
        raise ValueError(f"Unknown initial_state: {initial_state!r}")

    if n_steps > 0:
        _electric_layer(qc, lx, ly, g, 0.5 * dt)
        for k in range(n_steps):
            _magnetic_layer(qc, lx, ly, g, 0.5 * dt, 1)
            _magnetic_layer(qc, lx, ly, g, dt, 0)
            _magnetic_layer(qc, lx, ly, g, 0.5 * dt, 1)
            is_last = (k == n_steps - 1)
            _electric_layer(qc, lx, ly, g, 0.5 * dt if is_last else dt)
    return qc


# ─────────────────────────────────────────────────────────────────────────────
# 6.  Command-line interface
# ─────────────────────────────────────────────────────────────────────────────

def qasm_filename(lx: int, ly: int, g: float, dt: float, n_steps: int) -> str:
    return f"plaq2d121_obc_Lx{lx}_Ly{ly}_g{g:.3f}_dt{dt:.4f}_n{n_steps}.qasm"


def main():
    parser = argparse.ArgumentParser(
        description="Trotterized time evolution circuit for the (1,2,1) "
                    "truncation on an Lx x Ly square plaquette lattice "
                    "(Eq. 16 of arXiv:2503.11888), OBC, N_c=3."
    )
    parser.add_argument("--g", type=float, required=True,
                        help="gauge coupling g")
    parser.add_argument("--dt", type=float, required=True,
                        help="Trotter step size dt")
    parser.add_argument("--lx", type=int, required=True,
                        help="number of plaquettes in the x direction")
    parser.add_argument("--ly", type=int, required=True,
                        help="number of plaquettes in the y direction")
    parser.add_argument("--n-steps", type=int, required=True,
                        help="number of second-order (Strang) Trotter steps")
    parser.add_argument("--validate", action="store_true",
                        help="compare the circuit against exact expm evolution "
                             "(small lattices only, lx*ly <= 12)")
    args = parser.parse_args()

    if args.g == 0:
        parser.error("g must be nonzero (magnetic coefficients ~ 1/g²)")
    if args.lx < 1 or args.ly < 1:
        parser.error("--lx and --ly must be >= 1")
    if args.n_steps < 0:
        parser.error("--n-steps must be >= 0")

    qc = build_plaquette_circuit_2d_121(args.lx, args.ly, args.dt, args.n_steps, args.g)

    path = os.path.abspath(qasm_filename(args.lx, args.ly, args.g, args.dt, args.n_steps))
    from qiskit import qasm2
    with open(path, "w") as f:
        qasm2.dump(qc, f)

    print(f"(1,2,1) square-lattice plaquettes, OBC, N_c = {N_C}")
    print(f"  g = {args.g},  dt = {args.dt},  Lx x Ly = {args.lx} x {args.ly},  "
          f"steps = {args.n_steps}  (T = {args.n_steps * args.dt})")
    print(f"  qubits = {qc.num_qubits},  depth = {qc.depth()},  "
          f"gates = {dict(qc.count_ops())}")
    print(f"  QASM written to {path}")

    if args.validate:
        n_plaq = args.lx * args.ly
        if n_plaq > 12:
            print("  [validate] skipped: lx*ly > 12")
        else:
            from scipy.linalg import expm
            H = plaquette_hamiltonian_2d_121(args.lx, args.ly, args.g).to_matrix()
            psi0 = Statevector.from_label("0" * n_plaq)
            exact = expm(-1j * args.n_steps * args.dt * H) @ psi0.data
            trotter = Statevector(qc)
            fidelity = np.abs(np.vdot(exact, trotter.data)) ** 2
            print(f"  [validate] |<exact|trotter>|² = {fidelity:.10f}")


if __name__ == "__main__":
    main()
