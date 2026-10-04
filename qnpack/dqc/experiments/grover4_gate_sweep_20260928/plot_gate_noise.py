"""Replot the Grover 4 gate-depolarization sweep in the Grover 12 log-axis style."""

import csv
from math import isclose
from pathlib import Path

import matplotlib.pyplot as plt
import yaml

SCRIPT_DIR = Path(__file__).parent


def main():
    manifest = yaml.safe_load((SCRIPT_DIR / "manifest.yml").read_text())
    # The results live wherever the sweep wrote them, not beside this script.
    output_dir = Path(manifest["output_dir"])
    if not output_dir.is_dir():
        raise NotADirectoryError(
            f"{output_dir} (manifest output_dir) does not exist; "
            f"edit manifest.yml if the results moved")
    target = manifest["target_bitstring"]
    summary_path = output_dir / f"grover4_cisco_magic_target_{target}_summary.csv"
    with summary_path.open(newline="", encoding="utf-8") as stream:
        rows = list(csv.DictReader(stream))

    expected = {(int(qpu), float(pair["two_q_depolar_prob"]))
                for qpu in manifest["qpu_circuits"]
                for pair in manifest["noise_pairs"]}
    actual = {(int(row["qpu_count"]), float(row["two_q_depolar_prob"])) for row in rows}
    if len(rows) != len(expected) or actual != expected:
        raise ValueError(f"{summary_path} does not contain every condition exactly once")
    if any(not isclose(float(row["one_q_depolar_prob"]) * 10,
                       float(row["two_q_depolar_prob"]), rel_tol=1e-9)
           for row in rows):
        raise ValueError("one-qubit rate is not two-qubit / 10; axis label would be wrong")

    fig, ax = plt.subplots(figsize=(10, 6.2))
    for qpu_count in sorted(int(qpu) for qpu in manifest["qpu_circuits"]):
        group = sorted((row for row in rows if int(row["qpu_count"]) == qpu_count),
                       key=lambda row: float(row["two_q_depolar_prob"]))
        x = [float(row["two_q_depolar_prob"]) for row in group]
        y = [float(row["target_state_probability"]) for row in group]
        ax.plot(x, y, marker="o", markersize=8, linewidth=2, label=f"{qpu_count} QPU")

    ax.set_xscale("log")
    ax.set_xlabel("Two-qubit gate depolarization probability (one-qubit = x / 10)",
                  fontsize=14)
    ax.set_ylabel(f"P(target = {target})", fontsize=14)
    ax.set_ylim(0, 1)
    ax.tick_params(labelsize=13)
    ax.grid(True, which="major", alpha=0.3)
    ax.grid(True, which="minor", alpha=0.15)
    ax.legend(title="Grover 4", fontsize=14, title_fontsize=14, loc="lower left")
    fig.tight_layout()

    name = f"grover4_cisco_magic_target_{target}_vs_gate_noise"
    for suffix in ("png", "svg"):
        fig.savefig(output_dir / f"{name}.{suffix}", dpi=200)
    plt.close(fig)
    print(f"wrote {output_dir / name}.png")


if __name__ == "__main__":
    main()
