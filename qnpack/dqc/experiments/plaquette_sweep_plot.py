"""Comprehensive P(center=1) vs Trotter steps for 1D and 2D plaquette sweep.

Reads 1QPU and 2QPU magic-mode results from results/plaquette_sweep/.
Center qubit is meas_4 (qubit index 4) for both 1D (L=9) and 2D (3x3) lattices.

Usage: python -m qnpack.dqc.experiments.plaquette_sweep_plot
"""

import csv
import re
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.lines as mlines
import numpy as np

plt.rcParams.update({
    "font.size": 14,
    "axes.titlesize": 16,
    "axes.labelsize": 14,
    "xtick.labelsize": 12,
    "ytick.labelsize": 12,
    "legend.fontsize": 12,
})

BASE = Path(__file__).resolve().parent.parent
RESULTS = BASE / "results" / "plaquette_sweep"

CENTER_COL = "meas_4"


def _load_from_dir(subdir, prefix, vals_by_n, exclude=()):
    """Accumulate raw meas_4 values per n from a directory."""
    d = RESULTS / subdir
    if not d.exists():
        return
    pattern = re.compile(rf"{re.escape(prefix)}_n(\d+)\.csv$")
    for csv_path in sorted(d.glob("*.csv")):
        m = pattern.match(csv_path.name)
        if not m:
            continue
        n = int(m.group(1))
        if n in exclude:
            continue
        rows = list(csv.DictReader(csv_path.open()))
        vals = [int(r[CENTER_COL]) for r in rows if r.get(CENTER_COL, "").strip() != ""]
        if not vals:
            continue
        vals_by_n.setdefault(n, []).extend(vals)
        print(f"  {subdir} n={n}: +{len(vals)} shots")


def _load_series(subdir, prefix, extra_subdirs=(), exclude=()):
    """Load and combine shots across primary + extra dirs for each n."""
    vals_by_n = {}
    _load_from_dir(subdir, prefix, vals_by_n, exclude)
    for esub, epre in extra_subdirs:
        _load_from_dir(esub, epre, vals_by_n, exclude)

    if not vals_by_n:
        return [], [], []
    ns = sorted(vals_by_n)
    ys, errs = [], []
    for n in ns:
        vals = vals_by_n[n]
        p = np.mean(vals)
        cnt = len(vals)
        err = np.sqrt(p * (1 - p) / cnt) if cnt > 0 else 0
        ys.append(p)
        errs.append(err)
        print(f"  combined n={n}: P(1)={p:.4f} ({cnt} shots)")
    return ns, ys, errs


# (subdir, prefix, nqpu, lattice, noise, extra_dirs)
SERIES = [
    ("1qpu_1d_magic_ideal", "1qpu_1d_magic_ideal", 1, "1d", "noiseless",
     [("1qpu_1d_ideal", "1qpu_1d_ideal")]),
    ("1qpu_1d_magic_noisy", "1qpu_1d_magic_noisy", 1, "1d", "noisy",
     [("1qpu_1d_noisy", "1qpu_1d_noisy")]),
    ("2qpu_1d_magic_ideal", "2qpu_1d_magic_ideal", 2, "1d", "noiseless", []),
    ("2qpu_1d_magic_noisy", "2qpu_1d_magic_noisy", 2, "1d", "noisy", []),
    ("1qpu_2d_magic_ideal", "1qpu_2d_magic_ideal", 1, "2d", "noiseless", []),
    ("1qpu_2d_magic_noisy", "1qpu_2d_magic_noisy", 1, "2d", "noisy", []),
    ("2qpu_2d_magic_ideal", "2qpu_2d_magic_ideal", 2, "2d", "noiseless", []),
    ("2qpu_2d_magic_noisy", "2qpu_2d_magic_noisy", 2, "2d", "noisy", []),
]

LS = {"noiseless": "-", "noisy": "-."}  # solid=noiseless, dash-dot=noisy

# One distinct color per (nqpu, lattice) config
CONFIGS = [
    (1, "1d", "#3498db", "o", "1 QPU · 1D chain"),
    (1, "2d", "#2ecc71", "s", "1 QPU · 2D grid"),
    (2, "1d", "#e74c3c", "D", "2 QPU · 1D chain"),
    (2, "2d", "#9b59b6", "^", "2 QPU · 2D grid"),
]


EXTRA_MAP = {
    (1, "1d", "noiseless"): [("1qpu_1d_ideal", "1qpu_1d_ideal")],
    (1, "1d", "noisy"): [("1qpu_1d_noisy", "1qpu_1d_noisy")],
}

# Override subdir for specific (nqpu, lattice, noise) combos
SUBDIR_OVERRIDE = {
    (2, "1d", "noisy"): "2qpu_1d_bsm_noisy_emf096",
    (2, "2d", "noisy"): "2qpu_2d_bsm_noisy_emf096",
}

COLOR_QPU = {1: "#3498db", 2: "#e74c3c"}


def main():
    fig, axes = plt.subplots(1, 2, figsize=(14, 6), sharey=True)
    titles = {"1d": "1D chain", "2d": "2D grid"}

    for ax, lattice in zip(axes, ("1d", "2d")):
        exclude = (5,) if lattice == "1d" else ()
        for nqpu in (1, 2):
            color = COLOR_QPU[nqpu]
            for noise in ("noiseless", "noisy"):
                extra = EXTRA_MAP.get((nqpu, lattice, noise), [])
                dir_noise = "ideal" if noise == "noiseless" else noise
                subdir = SUBDIR_OVERRIDE.get(
                    (nqpu, lattice, noise),
                    f"{nqpu}qpu_{lattice}_magic_{dir_noise}"
                )
                xs, ys, errs = _load_series(subdir, subdir, extra, exclude)
                if not xs:
                    continue
                label = f"{nqpu} QPU {noise}"
                is_noiseless = noise == "noiseless"
                ax.errorbar(
                    xs, ys, yerr=errs,
                    fmt=LS[noise],
                    color=color,
                    marker="o" if is_noiseless else "none",
                    markersize=5,
                    lw=2.4 if is_noiseless else 1.4,
                    elinewidth=1.6 if is_noiseless else 1.0,
                    capsize=4,
                    capthick=1.6 if is_noiseless else 1.0,
                    alpha=0.95 if is_noiseless else 0.6,
                    zorder=4 if is_noiseless else 3,
                    label=label,
                )

        ax.set_xlabel("Trotter steps (n)", fontsize=13, fontweight="bold")
        if ax is axes[0]:
            ax.set_ylabel("P(center qubit = 1)", fontsize=13, fontweight="bold")
        ax.set_ylim(0, 0.55)
        ax.yaxis.set_major_formatter(plt.FuncFormatter(lambda v, _: f"{v:.2f}"))
        ax.grid(axis="y", alpha=0.3, linestyle="--", zorder=0)
        ax.grid(axis="x", alpha=0.15, linestyle=":", zorder=0)
        ax.set_title(f"Plaquette sweep — {titles[lattice]}", fontsize=14, fontweight="bold", pad=12)

    for ax in axes:
        ax.legend(loc="upper left", fontsize=11, framealpha=0.9)

    fig.tight_layout()

    for ext in ("png", "svg", "pdf"):
        out = RESULTS / f"plaquette_1d_2d_1qpu_2qpu_sweep.{ext}"
        fig.savefig(str(out), dpi=220, bbox_inches="tight")
        print(f"\nSaved: {out}")
    plt.close(fig)


if __name__ == "__main__":
    main()
