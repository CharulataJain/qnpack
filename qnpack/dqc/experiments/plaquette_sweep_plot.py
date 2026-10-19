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


def _series_def(lattice):
    """Return the ordered list of series to plot for a given lattice.

    Each entry: (label, subdir, prefix, extra_dirs, exclude,
                 color, linestyle, marker, lw, elinewidth, capsize, capthick,
                 alpha, zorder)
    """
    excl = (5,) if lattice == "1d" else ()
    L = lattice
    extra_ideal = [("1qpu_1d_ideal", "1qpu_1d_ideal")] if L == "1d" else []
    extra_noisy = [("1qpu_1d_noisy", "1qpu_1d_noisy")] if L == "1d" else []
    return [
        # label                             subdir / prefix
        ("1 QPU noiseless",
         f"1qpu_{L}_magic_ideal",  f"1qpu_{L}_magic_ideal",  extra_ideal, excl,
         "#3498db", "-",  "o",    2.4, 1.8, 5, 1.8, 0.95, 5),
        ("1 QPU noisy",
         f"1qpu_{L}_magic_noisy",  f"1qpu_{L}_magic_noisy",  extra_noisy, excl,
         "#3498db", "-.", "none", 1.6, 1.1, 4, 1.1, 0.70, 3),
        ("2 QPU noiseless",
         f"2qpu_{L}_magic_ideal",  f"2qpu_{L}_magic_ideal",  [],          excl,
         "#e74c3c", "-",  "o",    2.4, 1.8, 5, 1.8, 0.95, 5),
        (r"2 QPU noisy, $\eta=1.0$",
         f"2qpu_{L}_magic_noisy",  f"2qpu_{L}_magic_noisy",  [],          excl,
         "#e74c3c", "-.", "none", 1.6, 1.1, 4, 1.1, 0.70, 3),
        (r"2 QPU noisy, $\eta=0.96$",
         f"2qpu_{L}_bsm_noisy_emf096", f"2qpu_{L}_bsm_noisy_emf096", [], excl,
         "#e67e22", "--", "none", 1.6, 1.1, 4, 1.1, 0.70, 3),
    ]


def main():
    fig, axes = plt.subplots(1, 2, figsize=(14, 6), sharey=True)
    titles = {"1d": "1D chain", "2d": "2D grid"}

    for ax, lattice in zip(axes, ("1d", "2d")):
        for (label, subdir, prefix, extra, excl,
             color, ls, marker, lw, elw, capsize, capthick,
             alpha, zorder) in _series_def(lattice):

            xs, ys, errs = _load_series(subdir, prefix, extra, excl)
            if not xs:
                continue
            ax.errorbar(
                xs, ys, yerr=errs,
                fmt=ls,
                color=color,
                marker=marker,
                markersize=5,
                lw=lw,
                elinewidth=elw,
                capsize=capsize,
                capthick=capthick,
                alpha=alpha,
                zorder=zorder,
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
