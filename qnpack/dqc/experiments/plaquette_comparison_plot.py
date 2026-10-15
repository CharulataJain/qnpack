"""Plot 1QPU vs 2QPU DQC P(center=1) comparison for the 1D plaquette sweep.

Reads:
  results/plaquette_sweep/1qpu_1d_ideal/   — 500 shots, no noise
  results/plaquette_sweep/1qpu_1d_noisy/   — 500 shots, gate depolarization
  results/plaquette_sweep/2qpu_1d_magic_ideal/ — 500 shots, magic mode, no noise
  results/plaquette_sweep/2qpu_1d_magic_noisy/ — 500 shots, magic mode, gate depolarization

Usage: python -m qnpack.dqc.experiments.plaquette_comparison_plot
       (or python experiments/plaquette_comparison_plot.py from repo root)
"""

import csv
import re
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

BASE = Path(__file__).resolve().parent.parent
RESULTS = BASE / "results" / "plaquette_sweep"
QASM_DIR = BASE / "qasm" / "plaquette_sweep"

QASM_1QPU = "9qubit_1qpu_plaq121_obc_L9_g1.000_dt0.1000_n{n}.qasm"
QASM_2QPU = "9qubit_2qpu_plaq121_obc_L9_g1.000_dt0.1000_n{n}.qasm"

N_STEPS = [0, 2, 4, 5, 6, 8, 10]


def _meas_order(qasm_path):
    """Return {register_name: meas_column_index} from QASM measure statements."""
    pattern_1qpu = re.compile(r"meas\[(\d+)\] = measure (_qcomp_r\d+c\d+)\[0\];")
    pattern_2qpu = re.compile(r"meas\[(\d+)\] = measure (_qcomp_qpu_\d+_r\d+c\d+)\[0\];")
    # Also handle bare register names without qpu prefix
    order = {}
    with qasm_path.open() as f:
        for line in f:
            line = line.strip()
            for pat in (pattern_2qpu, pattern_1qpu):
                m = pat.match(line)
                if m:
                    order[m.group(2)] = int(m.group(1))
                    break
    return order


def _intra_cx_edges(qasm_path):
    """Data-qubit edges from cx gates within a single QPU."""
    pat = re.compile(r"cx (_qcomp\w+)\[0\], (_qcomp\w+)\[0\];")
    edges = set()
    with qasm_path.open() as f:
        for line in f:
            m = pat.match(line.strip())
            if m:
                a, b = m.group(1), m.group(2)
                if "qcomm" not in a and "qcomm" not in b:
                    edges.add(frozenset((a, b)))
    return edges


def _bridge_edge(qasm_path):
    """The cross-QPU data-qubit pair joined by EJPP, as a frozenset."""
    pat = re.compile(r"cx (_q\w+)\[0\], (_q\w+)\[0\];")
    comm_data = {}
    with qasm_path.open() as f:
        for line in f:
            m = pat.match(line.strip())
            if not m:
                continue
            a, b = m.group(1), m.group(2)
            a_c = "qcomm" in a
            b_c = "qcomm" in b
            if a_c != b_c:
                comm, data = (a, b) if a_c else (b, a)
                comm_data.setdefault(comm, {}).setdefault(data, 0)
                comm_data[comm][data] += 1
    by_qpu = {}
    for comm, counts in comm_data.items():
        qpu = re.search(r"_qpu_(\d+)_", comm).group(1)
        best = max(counts, key=counts.get)
        by_qpu[qpu] = best
    endpoints = list(by_qpu.values())
    return frozenset(endpoints) if len(endpoints) == 2 else None


def _chain_center(qasm_path):
    """Unique topological center of the (possibly distributed) 1D chain."""
    edges = _intra_cx_edges(qasm_path)
    bridge = _bridge_edge(qasm_path)
    if bridge:
        edges.add(bridge)

    adjacency = {}
    for edge in edges:
        a, b = tuple(edge)
        adjacency.setdefault(a, set()).add(b)
        adjacency.setdefault(b, set()).add(a)

    def eccentricity(src):
        dist = {src: 0}
        q = [src]
        while q:
            nxt = []
            for u in q:
                for v in adjacency[u]:
                    if v not in dist:
                        dist[v] = dist[u] + 1
                        nxt.append(v)
            q = nxt
        return max(dist.values())

    ecc = {n: eccentricity(n) for n in adjacency}
    min_ecc = min(ecc.values())
    centers = [n for n, e in ecc.items() if e == min_ecc]
    if len(centers) == 1:
        return centers[0]
    # Two-center chain: pick the one with lower string sort (deterministic)
    return sorted(centers)[0]


def _center_col(qasm_template, n_ref):
    """Return the meas_N column name for the center qubit, derived from n_ref."""
    qasm = QASM_DIR / qasm_template.format(n=n_ref)
    center_reg = _chain_center(qasm)
    order = _meas_order(qasm)
    if center_reg not in order:
        raise KeyError(f"Center register {center_reg!r} not in meas order {order}")
    return f"meas_{order[center_reg]}"


def _load_p1(csv_path, col):
    rows = list(csv.DictReader(csv_path.open()))
    vals = [int(r[col]) for r in rows if r.get(col, "").strip() != ""]
    return np.mean(vals) if vals else None, len(vals)


def _load_series(result_subdir, file_prefix, qasm_template, center_col_cache):
    xs, ys, errs = [], [], []
    for n in N_STEPS:
        csv_path = RESULTS / result_subdir / f"{file_prefix}_n{n}.csv"
        if not csv_path.exists():
            continue
        col = center_col_cache.get(n)
        if col is None:
            # n=0 has no gates, derive column from deepest available QASM
            continue
        p, cnt = _load_p1(csv_path, col)
        if p is None:
            continue
        xs.append(n)
        ys.append(p)
        # Wilson-score SE approximation
        errs.append(np.sqrt(p * (1 - p) / cnt) if cnt > 0 else 0)
        print(f"  {result_subdir} n={n}: {col} -> P(1)={p:.4f} ({cnt} shots)")
    return xs, ys, errs


def main():
    # Derive center columns once per QASM family (use n=10 as reference)
    ref_n = 10
    cols_1qpu = {}
    cols_2qpu = {}
    for n in N_STEPS:
        qasm_n = n if n > 0 else ref_n  # n=0 has no cx gates; borrow from n=ref
        try:
            cols_1qpu[n] = _center_col(QASM_1QPU, qasm_n)
        except Exception as e:
            print(f"  1QPU center col n={n}: {e}")
        try:
            cols_2qpu[n] = _center_col(QASM_2QPU, qasm_n)
        except Exception as e:
            print(f"  2QPU center col n={n}: {e}")

    print(f"1QPU center columns: {cols_1qpu}")
    print(f"2QPU center columns: {cols_2qpu}")

    SERIES = [
        ("1qpu_1d_ideal",       "1qpu_1d_ideal",       QASM_1QPU, cols_1qpu,
         "1QPU ideal",        dict(color="#1f77b4", ls="-",  marker="o", ms=5, lw=2)),
        ("1qpu_1d_noisy",       "1qpu_1d_noisy",       QASM_1QPU, cols_1qpu,
         "1QPU noisy",        dict(color="#1f77b4", ls="--", marker="s", ms=5, lw=1.5, alpha=0.7)),
        ("2qpu_1d_magic_ideal", "2qpu_1d_magic_ideal", QASM_2QPU, cols_2qpu,
         "2QPU DQC ideal",   dict(color="#ff7f0e", ls="-",  marker="o", ms=5, lw=2)),
        ("2qpu_1d_magic_noisy", "2qpu_1d_magic_noisy", QASM_2QPU, cols_2qpu,
         "2QPU DQC noisy",   dict(color="#ff7f0e", ls="--", marker="s", ms=5, lw=1.5, alpha=0.7)),
    ]

    fig, ax = plt.subplots(figsize=(8, 5))

    for subdir, prefix, tmpl, cols, label, style in SERIES:
        print(f"\n{subdir}:")
        xs, ys, errs = _load_series(subdir, prefix, tmpl, cols)
        if not xs:
            print(f"  (no data)")
            continue
        ax.errorbar(xs, ys, yerr=errs, label=label, capsize=3, **style)

    ax.set_xlabel("Trotter steps (n)", fontsize=12)
    ax.set_ylabel("P(center qubit = 1)", fontsize=12)
    ax.set_xticks(N_STEPS)
    ax.set_ylim(-0.01, None)
    ax.grid(True, alpha=0.25, linestyle=":")
    ax.set_title("1D plaquette chain (L=9, OBC) — 1QPU vs 2QPU DQC")
    ax.legend(fontsize=10)
    fig.tight_layout()

    for ext in ("png", "svg"):
        out = RESULTS / f"plaquette_1qpu_vs_2qpu_magic_{ext}"
        fig.savefig(str(RESULTS / f"plaquette_1qpu_vs_2qpu_magic.{ext}"), dpi=220)
    plt.close(fig)
    print(f"\nSaved: {RESULTS}/plaquette_1qpu_vs_2qpu_magic.{{png,svg}}")


if __name__ == "__main__":
    main()
