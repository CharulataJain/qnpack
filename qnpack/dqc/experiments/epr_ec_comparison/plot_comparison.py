"""
Plot EPR model vs physical BSM comparison.

Reads epr_ec_comparison_summary.csv from the output directory and produces
a 3-panel bar chart (one panel per circuit mode) saved as a PNG.

All display parameters (labels, metric names, colours) come from manifest.yml
and the summary CSV — no hardcoded strings in the chart logic.

Usage (from repo root):
    python -m qnpack.dqc.experiments.epr_ec_comparison.plot_comparison
"""

import csv
import sys
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np
import yaml

MANIFEST = Path(__file__).with_name("manifest.yml")
COLOURS = {
    "bsm":       "#6a0dad",   # purple — physical BSM
    "epr_model": "#2d6a4f",   # green  — EPR model (EC)
}
METRIC_YLABEL = {
    "p_target": "P(target bitstring)",
    "p_center": "P(center qubit = 1)",
}


def main():
    manifest = yaml.safe_load(MANIFEST.read_text(encoding="utf-8"))
    anchor   = MANIFEST.parent
    out_dir  = (anchor / manifest["output_dir"]).resolve()
    summary_path = out_dir / "epr_ec_comparison_summary.csv"

    if not summary_path.exists():
        sys.exit(f"Summary not found: {summary_path}\nRun run_comparison.py first.")

    with summary_path.open(newline="", encoding="utf-8") as f:
        rows = list(csv.DictReader(f))

    # Group by circuit
    circuits_in_order = list(manifest["circuits"].keys())
    by_circuit = {k: [r for r in rows if r["circuit_key"] == k]
                  for k in circuits_in_order}

    n_circuits = len(circuits_in_order)
    fig, axes = plt.subplots(1, n_circuits, figsize=(5 * n_circuits, 5), sharey=False)
    if n_circuits == 1:
        axes = [axes]

    for ax, circuit_key in zip(axes, circuits_in_order):
        circ_rows = by_circuit[circuit_key]
        circ_cfg  = manifest["circuits"][circuit_key]
        metric    = circ_cfg["metric"]

        conditions  = ["bsm", "epr_model"]
        values      = []
        bar_colours = []
        bar_labels  = []

        for cond in conditions:
            match = [r for r in circ_rows if r["entanglement"] == cond]
            if not match:
                values.append(0.0)
            else:
                values.append(float(match[0]["value"]))
            bar_colours.append(COLOURS[cond])
            lbl = match[0]["condition_label"].replace("\\n", "\n") if match else cond
            bar_labels.append(lbl)

        x = np.arange(len(conditions))
        bars = ax.bar(x, values, color=bar_colours, width=0.5, edgecolor="white",
                      linewidth=0.8)

        for bar, val in zip(bars, values):
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.01,
                    f"{val:.3f}", ha="center", va="bottom", fontsize=10, fontweight="bold")

        ax.set_xticks(x)
        ax.set_xticklabels(bar_labels, fontsize=9)
        ax.set_ylabel(METRIC_YLABEL.get(metric, metric), fontsize=10)
        ax.set_ylim(0, 1.0)
        ax.axhline(0.25, color="grey", linestyle="--", linewidth=0.8, alpha=0.6,
                   label="Random (0.25)")
        ax.set_title(circ_cfg["label"], fontsize=11, fontweight="bold")
        ax.yaxis.grid(True, alpha=0.3)
        ax.set_axisbelow(True)

        # Annotate run counts
        for bar, cond in zip(bars, conditions):
            match = [r for r in circ_rows if r["entanglement"] == cond]
            if match:
                n = match[0]["num_runs"]
                ax.text(bar.get_x() + bar.get_width() / 2,
                        -0.06, f"n={n}", ha="center", va="top",
                        fontsize=8, color="grey",
                        transform=ax.get_xaxis_transform())

    # Shared legend
    noise = manifest["noise"]
    epr   = manifest["epr_model"]
    patches = [
        mpatches.Patch(color=COLOURS["bsm"],
                       label=(
                           f"Physical BSM — noise only (no losses)\n"
                           f"(emf={noise['emission_fidelity']}, "
                           f"fiber_dep={noise['fiber_depolar_rate']}, "
                           f"T1={float(noise['T1']):.0e}ns, T2={float(noise['T2']):.2e}ns,\n"
                           f" 1q={float(noise['one_q_depolar_prob']):.0e}, "
                           f"2q={float(noise['two_q_depolar_prob']):.0e}; "
                           f"all losses=0)"
                       )),
        mpatches.Patch(color=COLOURS["epr_model"],
                       label=(
                           f"EPR model — d=3 surface code EC\n"
                           f"(F_logical={epr['epr_fidelity']}, "
                           f"rate={epr['epr_rate_hz']/1e3:.1f} kHz, "
                           f"p_succ={epr['epr_success_prob']}; "
                           f"above F_th≈0.871)"
                       )),
    ]
    fig.legend(handles=patches, loc="lower center", ncol=2,
               fontsize=8, bbox_to_anchor=(0.5, -0.08), frameon=True)

    fig.suptitle(
        "Physical BSM vs EPR Model (d=3 Surface Code EC)\n"
        "Noise-only params (all losses=0) — Grover4 & Plaquette circuits",
        fontsize=12, fontweight="bold", y=1.02,
    )

    png_path = out_dir / "epr_ec_comparison.png"
    fig.tight_layout()
    fig.savefig(png_path, dpi=150, bbox_inches="tight")
    plt.close(fig)
    print(f"Saved: {png_path}")


if __name__ == "__main__":
    main()
