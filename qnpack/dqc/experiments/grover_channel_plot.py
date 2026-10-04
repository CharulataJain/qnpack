"""Plot completed Grover fiber depolarization sweeps from their summary CSVs."""

import argparse
import csv
from pathlib import Path

import matplotlib.pyplot as plt
import yaml

from .grover_sweep import _path, _positive_int, _required


def _save_figure(fig, output_dir, name, dpi):
    for suffix in ("png", "svg"):
        fig.savefig(output_dir / f"{name}.{suffix}", dpi=dpi)
    plt.close(fig)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args(argv)
    manifest_path = args.manifest.expanduser().resolve()
    with manifest_path.open(encoding="utf-8") as stream:
        manifest = yaml.safe_load(stream)
    for key in ("algorithm", "output_dir", "target_bitstring", "qpu_circuits",
                "fiber_depolar_rates", "plot"):
        _required(manifest, key, "manifest")
    plot = manifest["plot"]
    for key in ("width_inches", "height_inches", "dpi", "grid_alpha"):
        _required(plot, key, "manifest.plot")
    if any(not isinstance(plot[key], (int, float)) or plot[key] <= 0
           for key in ("width_inches", "height_inches")):
        raise ValueError("Plot dimensions must be positive numbers")
    _positive_int(plot["dpi"], "plot.dpi")
    if not isinstance(plot["grid_alpha"], (int, float)) or not 0 <= plot["grid_alpha"] <= 1:
        raise ValueError("plot.grid_alpha must be in [0, 1]")
    x_scale = plot.get("x_scale", "linear")
    if x_scale not in ("linear", "symlog"):
        raise ValueError("plot.x_scale must be linear or symlog")
    linear_threshold = plot.get("x_linear_threshold", 0.005)
    if not isinstance(linear_threshold, (int, float)) or linear_threshold <= 0:
        raise ValueError("plot.x_linear_threshold must be a positive number")

    output_dir = _path(manifest_path.parent, manifest["output_dir"], "output_dir")
    prefix = f"{manifest['algorithm']}_cisco_bsm_ket"
    summary_path = output_dir / f"{prefix}_target_{manifest['target_bitstring']}_summary.csv"
    with summary_path.open(newline="", encoding="utf-8") as stream:
        rows = list(csv.DictReader(stream))
    expected = {(int(qpu), float(rate)) for qpu in manifest["qpu_circuits"]
                for rate in manifest["fiber_depolar_rates"]}
    actual = {(int(row["qpu_count"]), float(row["fiber_depolar_rate"])) for row in rows}
    if len(rows) != len(expected) or actual != expected:
        raise ValueError(f"{summary_path} does not contain every manifest condition exactly once")

    figure_size = (plot["width_inches"], plot["height_inches"])
    fig_all, ax_all = plt.subplots(figsize=figure_size)
    for qpu_count in manifest["qpu_circuits"]:
        group = sorted((row for row in rows if int(row["qpu_count"]) == qpu_count),
                       key=lambda row: float(row["fiber_depolar_rate"]))
        x = [float(row["fiber_depolar_rate"]) for row in group]
        y = [float(row["target_state_probability"]) for row in group]
        fig, ax = plt.subplots(figsize=figure_size)
        for axis in (ax, ax_all):
            axis.plot(x, y, marker="o", label=f"{qpu_count} QPU")
            axis.set_xlabel("Fiber depolarization probability per photon")
            axis.set_ylabel(f"P(target = {manifest['target_bitstring']})")
            axis.set_ylim(0, 1)
            if x_scale == "symlog":
                axis.set_xscale("symlog", linthresh=linear_threshold)
            axis.set_xticks(x)
            labels = axis.set_xticklabels([format(value, "g") for value in x])
            if x_scale == "symlog":
                for label in labels:
                    label.set_rotation(45)
                    label.set_horizontalalignment("right")
            axis.minorticks_off()
            axis.grid(True, alpha=plot["grid_alpha"])
        ax.set_title(f"{manifest['algorithm']} · {qpu_count} QPU · BSM · KET")
        fig.tight_layout()
        _save_figure(fig, output_dir,
                     f"{prefix}_{qpu_count}qpu_target_{manifest['target_bitstring']}_vs_fiber_depolar_rate",
                     plot["dpi"])
    ax_all.set_title(f"{manifest['algorithm']} · BSM · KET")
    ax_all.legend(title="QPU count")
    fig_all.tight_layout()
    _save_figure(fig_all, output_dir,
                 f"{prefix}_target_{manifest['target_bitstring']}_vs_fiber_depolar_rate",
                 plot["dpi"])


if __name__ == "__main__":
    main()
