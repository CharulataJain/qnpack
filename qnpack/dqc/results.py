"""
results.py
----------
Turn raw per-run rows into reported output: bitstrings, summary tables,
CSV, and histograms.

Nothing here touches NetSquid.  A "row" is one run's measurements plus its
timing; an "entry" is one noise configuration's worth of rows together with
the parameters that produced them.
"""
import logging
import os
from collections import Counter

import matplotlib.pyplot as plt
import pandas

log = logging.getLogger(__name__)


def mean_entanglement_time_per_run(row):
    """Mean request-to-ready time over Bell pairs in one algorithm run."""
    durations = row.get('entanglement_durations') or {}
    return sum(durations.values()) / len(durations) if durations else None


def mean_entanglement_time_across_runs(results):
    """Equal-weight mean of the per-run Bell-pair averages."""
    per_run = [
        mean_entanglement_time_per_run(row) for row in results
    ]
    measured = [value for value in per_run if value is not None]
    return sum(measured) / len(measured) if measured else None


def row_bitstring(row, col_names):
    """Join one row's per-column bits, using ``?`` for anything missing."""
    return "".join(
        str(int(row[c])) if row.get(c) is not None else "?" for c in col_names
    )


def summarise_bitstrings(results, col_names, top_n):
    """Count bitstrings across *results* and log the most common.

    Returns
    -------
    tuple
        ``(counts, top_n_list)``
    """
    counts = Counter(row_bitstring(r, col_names) for r in results)
    log.info(f"Bitstring counts: {dict(counts)}")

    top = counts.most_common(top_n)
    log.info(f"Top {top_n} bitstrings:")
    for bitstring, count in top:
        log.info(f"  {bitstring}: {count}")
    return counts, top


def log_measurement_table(results, col_names):
    """Log a per-run table of measurement outcomes."""
    header = f"{'Run':>4}" + "".join(f"  {c:>12}" for c in col_names)
    rule = "=" * len(header)

    log.info(rule)
    log.info(f"MEASUREMENT RESULTS ({len(col_names)} data qubits)")
    log.info(rule)
    log.info(header)
    log.info("-" * len(header))
    for r in results:
        line = f"{r['run']:>4}"
        for c in col_names:
            v = r.get(c)
            line += f"  {int(v) if v is not None else 'N/A':>12}"
        log.info(line)
    log.info(rule)


def build_noise_label(params):
    """Describe the actual sweep values without assuming a baseline."""
    return " | ".join(f"{name}={value}" for name, value in params.items())


def to_dataframe(final_data):
    """Flatten every run of every configuration into one DataFrame."""
    rows = []
    for entry in final_data:
        col_names = entry["col_names"]
        noise_label = entry["noise_label"].replace("\n", " ")

        for r in entry["results"]:
            durations = r.get("entanglement_durations") or {}
            avg_ent = mean_entanglement_time_per_run(r)
            row = {
                "noise_label": noise_label,
                "two_q_depolar_prob": entry["two_q_prob"],
                "one_q_depolar_prob": entry["one_q_prob"],
                "emission_fidelity": entry["emission_fidelity"],
                "collection_efficiency": entry["collection_efficiency"],
                "T1": entry["T1"],
                "T2": entry["T2"],
                "one_q_gate_duration": entry["one_q_gate_duration"],
                "two_q_gate_duration": entry["two_q_gate_duration"],
                "photon_loss": entry["photon_loss"],
                "init_photon_loss": entry["init_photon_loss"],
                "fiber_depolar_rate": entry["fiber_depolar_rate"],
                "run": r.get("run", ""),
                "bitstring": row_bitstring(r, col_names),
                "sim_duration_s": r.get("sim_duration_s"),
                "entanglement_count": len(durations),
                "entl_time_s": avg_ent,
                "mean_entl_time_s": entry.get("mean_entl_time_s"),
                "avg_entanglement_time_s": avg_ent,
            }
            row.update({c: r.get(c) for c in col_names})
            rows.append(row)

    return pandas.DataFrame(rows)


def log_timing_stats(df):
    """Log per-run, total, and mean simulated duration."""
    log.info("\n" + "=" * 80)
    log.info("SIMULATION TIME STATISTICS (per run)")
    log.info("=" * 80)

    if "sim_duration_s" not in df.columns:
        log.info("=" * 80)
        return

    durations = df["sim_duration_s"].dropna()
    if len(durations) > 0:
        for idx, dur in enumerate(durations):
            log.info(f"  Run {idx:>3}: {dur:.6f} s")
        log.info("  ---")
        log.info(
            f"  Total simulation time ({len(durations)} runs): "
            f"{durations.sum():.6f} s"
        )
        log.info(
            f"  Average simulation time per run: {durations.mean():.6f} s"
        )
    log.info("=" * 80)


def log_entanglement_stats(final_data):
    """Log each run's pair average and the mean across runs."""
    log.info("\n" + "=" * 80)
    log.info("SUCCESSFUL ENTANGLEMENT STATISTICS")
    log.info("=" * 80)

    for entry in final_data:
        log.info(f"Noise configuration: {entry['noise_label']}")
        for row in entry['results']:
            mean = mean_entanglement_time_per_run(row)
            if mean is None:
                log.info(f"  Run {row['run']}: no Bell pairs generated")
            else:
                count = len(row['entanglement_durations'])
                log.info(
                    f"  Run {row['run']}: {mean:.9g} s per pair "
                    f"({count} Bell pairs)"
                )
        across_runs = mean_entanglement_time_across_runs(entry['results'])
        if across_runs is not None:
            log.info(
                f"  Mean per-pair time across runs: {across_runs:.9g} s"
            )
    log.info("=" * 80 + "\n")


def csv_filename(circuit_cfg, num_runs, entanglement_method):
    """Name the CSV after circuit, run count, scheduling, and pair method."""
    from qnpack.common.config import require_cfg

    pre_scheduled = require_cfg(circuit_cfg, "pre_schedule_entanglement", "circuit")
    tag = "prescheduled" if pre_scheduled else "nopresched"

    mode = require_cfg(circuit_cfg, "mode", "circuit")
    if mode in ("cisco", "cisco_v2"):
        source = require_cfg(circuit_cfg, "qasm_file", "circuit")
    else:
        source = require_cfg(circuit_cfg, "dist_commands_file", "circuit")

    stem = os.path.splitext(os.path.basename(source))[0]
    return f"{stem}_{num_runs}iter_{tag}_{entanglement_method}.csv"


def write_csv(final_data, output_dir, circuit_cfg, num_runs,
              entanglement_method):
    """Write every run to CSV and log the timing and entanglement stats.

    Returns
    -------
    str
        Path to the written file.
    """
    os.makedirs(output_dir, exist_ok=True)

    df = to_dataframe(final_data)
    log_timing_stats(df)
    log_entanglement_stats(final_data)

    path = os.path.join(
        output_dir, csv_filename(circuit_cfg, num_runs, entanglement_method)
    )
    df.to_csv(path, index=False)
    log.info(f"Results saved to CSV: {path}")
    return path


def plot_histograms(final_data, output_dir, filename):
    """Plot one bitstring histogram per noise configuration, side by side.

    Returns
    -------
    str
        Path to the saved figure.
    """
    os.makedirs(output_dir, exist_ok=True)

    n_configs = len(final_data)
    fig, axes = plt.subplots(
        1, n_configs, figsize=(max(8, n_configs * 7), 5), squeeze=False
    )

    for ax, entry in zip(axes[0], final_data):
        counts = entry["counts"]
        two_q, one_q = entry["two_q_prob"], entry["one_q_prob"]

        labels = sorted(counts.keys())
        values = [counts[lbl] for lbl in labels]
        colour = "steelblue" if (two_q == 0 and one_q == 0) else "tomato"

        ax.bar(labels, values, color=colour, edgecolor="black")
        ax.set_xlabel("Measurement outcome", fontsize=9)
        ax.set_ylabel("Count")
        ax.set_title(
            f"{entry['noise_label']}\n({entry['num_runs']} runs)", fontsize=10
        )
        ax.yaxis.get_major_locator().set_params(integer=True)
        ax.tick_params(axis="x", rotation=90, labelsize=7)
        for i, v in enumerate(values):
            ax.text(i, v + 0.1, str(v), ha="center", fontsize=7,
                    fontweight="bold")

    plt.suptitle(
        "DQC Measurement Distribution: Noiseless vs Noisy", fontsize=12, y=1.02
    )
    plt.tight_layout()

    path = os.path.join(output_dir, filename)
    plt.savefig(path, dpi=150, bbox_inches="tight")
    log.info(f"Combined histogram saved to {path}")
    plt.close(fig)
    return path
