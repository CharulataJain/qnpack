"""Plot P(center qubit = 1) vs Trotter step count for the plaquette sweep.

Reads the per-condition CSVs written by run_plaquette_sweep.sh (one CSV per
(lattice, noise, n_steps) combination, each a raw dqc-sim output with
meas_0..meas_8 columns) and plots the ideal vs gate-depolarized curves for
each lattice, mirroring the solid-line-vs-noisy-points style used in
2411.05915 Fig. 14 (solid = ideal/classical reference, markers = the noisy
condition — the simulator here plays both roles since no hardware was run).

The column that holds "the" qubit of interest is derived from circuit
structure rather than hardcoded: for each lattice, it's the unique data
qubit whose first field-rotation (u1) coefficient is zero in the 2D case,
or the unique graph-center of the 1D chain reconstructed from its cx and
EJPP-entanglement edges. See _lattice_center_register().

Usage: python -m qnpack.dqc.experiments.plaquette_plot
"""

import csv
import re
from pathlib import Path

import matplotlib.pyplot as plt

RESULTS_DIR = Path(__file__).resolve().parent.parent / "results" / "plaquette_sweep"
QASM_DIR = Path(__file__).resolve().parent.parent / "qasm" / "plaquette_sweep"
N_STEPS = [0, 2, 4, 5, 6, 10]

LATTICES = {
    "1d": {
        "label": "1D chain (L=9, OBC)",
        "qasm_template": "9qubit_2qpu_plaq121_obc_L9_g1.000_dt0.1000_n{n}.qasm",
    },
    "2d": {
        "label": "2D lattice (3x3, OBC)",
        "qasm_template": "9qubit_2qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n{n}.qasm",
    },
}

NOISE_CONDITIONS = [
    ("ideal", "Ideal", dict(linestyle="-", marker=None)),
    ("noisy", "Gate depolarization (2q=1e-4, 1q=1e-5)", dict(linestyle="none", marker="o")),
]


def _measurement_order(qasm_path):
    """Return [register_name, ...] ordered by its meas[i] index."""
    order = {}
    pattern = re.compile(r"meas\[(\d+)\] = measure (_qcomp_qpu_\d+_r\d+c\d+)\[0\];")
    with qasm_path.open(encoding="utf-8") as stream:
        for line in stream:
            m = pattern.match(line.strip())
            if m:
                order[int(m.group(1))] = m.group(2)
    if len(order) != 9:
        raise ValueError(f"{qasm_path}: expected 9 final measurements, found {len(order)}")
    return [order[i] for i in range(9)]


def _first_u1_coefficients(qasm_path):
    """First u1(theta) applied to each data qubit, before any cx — the
    bare on-site field-rotation coefficient for that site."""
    seen = {}
    # Match bare integer or float/scientific-notation coefficient, e.g. u1(0) or u1(-0.0333)
    pattern = re.compile(
        r"u1\(\s*([-+]?(?:[0-9]*\.)?[0-9]+(?:[eE][-+]?[0-9]+)?)\s*\)"
        r"\s+(_qcomp_qpu_\d+_r\d+c\d+)\[0\];"
    )
    with qasm_path.open(encoding="utf-8") as stream:
        for line in stream:
            m = pattern.match(line.strip())
            if m and m.group(2) not in seen:
                seen[m.group(2)] = float(m.group(1))
    return seen


def _chain_center_register(qasm_path):
    """Unique graph-center of the 1D open chain, from cx + EJPP bridge edges."""
    cx_pattern = re.compile(r"cx (_q\w+)\[0\], (_q\w+)\[0\];")
    intra_edges = set()
    comm_data = {}
    with qasm_path.open(encoding="utf-8") as stream:
        for line in stream:
            m = cx_pattern.match(line.strip())
            if not m:
                continue
            a, b = m.groups()
            a_comm, b_comm = "qcomm" in a, "qcomm" in b
            if not a_comm and not b_comm:
                intra_edges.add(frozenset((a, b)))
            elif a_comm != b_comm:
                comm, data = (a, b) if a_comm else (b, a)
                comm_data.setdefault(comm, set()).add(data)

    adjacency = {}
    for edge in intra_edges:
        a, b = tuple(edge)
        adjacency.setdefault(a, set()).add(b)
        adjacency.setdefault(b, set()).add(a)

    # The cross-QPU bridge: each QPU's comm registers all funnel to the same
    # single boundary data qubit (the one the EJPP process repeatedly targets).
    from collections import Counter
    by_qpu = {}
    for comm, datas in comm_data.items():
        qpu = re.search(r"_qpu_(\d+)_", comm).group(1)
        by_qpu.setdefault(qpu, Counter()).update(datas)
    bridge = {qpu: counts.most_common(1)[0][0] for qpu, counts in by_qpu.items()}
    bridge_qubits = list(bridge.values())
    if len(bridge_qubits) == 2:
        a, b = bridge_qubits
        adjacency.setdefault(a, set()).add(b)
        adjacency.setdefault(b, set()).add(a)

    def eccentricity(src):
        dist = {src: 0}
        frontier = [src]
        while frontier:
            nxt = []
            for u in frontier:
                for v in adjacency[u]:
                    if v not in dist:
                        dist[v] = dist[u] + 1
                        nxt.append(v)
            frontier = nxt
        return max(dist.values())

    ecc = {n: eccentricity(n) for n in adjacency}
    min_ecc = min(ecc.values())
    centers = [n for n, e in ecc.items() if e == min_ecc]
    if len(centers) != 1:
        raise ValueError(f"{qasm_path}: expected a unique chain center, found {centers}")
    return centers[0]


def lattice_center_register(lattice, qasm_path):
    """The qubit register this script treats as 'the' site for P(1)."""
    if lattice == "1d":
        return _chain_center_register(qasm_path)
    if lattice == "2d":
        coeffs = _first_u1_coefficients(qasm_path)
        zeros = [q for q, c in coeffs.items() if abs(c) < 1e-12]
        if len(zeros) != 1:
            raise ValueError(f"{qasm_path}: expected one zero-coefficient qubit, found {zeros}")
        return zeros[0]
    raise ValueError(f"Unknown lattice {lattice!r}")


def _p1(csv_path, meas_column):
    with csv_path.open(newline="", encoding="utf-8") as stream:
        rows = list(csv.DictReader(stream))
    if not rows:
        raise ValueError(f"{csv_path}: no rows")
    if meas_column not in rows[0]:
        raise KeyError(f"{csv_path}: column {meas_column!r} not found; "
                       f"available: {list(rows[0].keys())}")
    # Skip rows where the measurement value is empty (e.g. zero-step circuits
    # whose ancilla measurements were not recorded).
    values = []
    for row in rows:
        v = row[meas_column].strip()
        if v != "":
            values.append(int(v))
    if not values:
        raise ValueError(f"{csv_path}: no non-empty values in column {meas_column!r}")
    return sum(values) / len(values), len(values)


def _save_figure(fig, name, dpi=220):
    for suffix in ("png", "svg"):
        fig.savefig(RESULTS_DIR / f"{name}.{suffix}", dpi=dpi)
    plt.close(fig)


def main():
    for lattice, spec in LATTICES.items():
        # n_steps=0 has no gates, so the center can't be derived from it —
        # the qubit *registers* are identical across every n_steps value for
        # a given lattice, only the meas[i] ordering changes, so derive the
        # center once from the deepest circuit and reuse the register name.
        reference_qasm = QASM_DIR / spec["qasm_template"].format(n=max(N_STEPS))
        center_reg = lattice_center_register(lattice, reference_qasm)

        fig, ax = plt.subplots(figsize=(7, 5))
        for noise_key, noise_label, style in NOISE_CONDITIONS:
            xs, ys = [], []
            for n in N_STEPS:
                try:
                    qasm_path = QASM_DIR / spec["qasm_template"].format(n=n)
                    meas_order = _measurement_order(qasm_path)
                    meas_column = f"meas_{meas_order.index(center_reg)}"

                    csv_path = RESULTS_DIR / f"{lattice}_{noise_key}" / f"{lattice}_{noise_key}_n{n}.csv"
                    if not csv_path.is_file():
                        print(f"SKIP {csv_path} (not found yet)")
                        continue
                    p1, num_runs = _p1(csv_path, meas_column)
                    xs.append(n)
                    ys.append(p1)
                    print(f"  [{lattice}] {noise_key} n={n}: {meas_column} -> P(1)={p1:.4f} ({num_runs} runs)")
                except Exception as exc:
                    print(f"  ERROR [{lattice}] {noise_key} n={n}: {exc}")
                    continue
            if xs:
                ax.plot(xs, ys, label=noise_label, **style)

        ax.set_xlabel("Trotter step count (n_steps)")
        ax.set_ylabel("P(center qubit = 1)")
        ax.set_ylim(-0.02, 1.02)
        ax.set_xticks(N_STEPS)
        ax.grid(True, alpha=0.3)
        ax.set_title(f"{spec['label']} — center-site excitation probability")
        ax.legend()
        fig.tight_layout()
        _save_figure(fig, f"plaquette_{lattice}_center_p1_vs_nsteps")
        print(f"Wrote plaquette_{lattice}_center_p1_vs_nsteps.{{png,svg}}")


if __name__ == "__main__":
    main()
