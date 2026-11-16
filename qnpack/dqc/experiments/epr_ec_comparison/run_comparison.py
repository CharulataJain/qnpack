"""
EPR model vs physical BSM comparison.

Runs three circuit modes (cisco/tket/cisco_v2) under two entanglement conditions:
  bsm       — full physical simulation, Full SotA noise
  epr_model — abstract depolarised EPR pairs, d=3 surface-code corrected (above threshold)

All parameters read from manifest.yml — no hardcoded values in this script.

Usage (from repo root):
    python -m qnpack.dqc.experiments.epr_ec_comparison.run_comparison
    python -m qnpack.dqc.experiments.epr_ec_comparison.run_comparison --smoke
"""

import argparse
import collections
import csv
import os
import shutil
import subprocess
import sys
from pathlib import Path

import yaml

MANIFEST = Path(__file__).with_name("manifest.yml")


def _load_manifest():
    return yaml.safe_load(MANIFEST.read_text(encoding="utf-8"))


def _initpl_tag(value):
    return format(value, "g").replace(".", "p")


def _build_config(manifest, circuit_key, entanglement_method, num_runs):
    """Build a parameters.yml dict for one circuit × entanglement condition."""
    noise   = manifest["noise"]
    bsm_cfg = manifest["bsm"]
    circ    = manifest["circuits"][circuit_key]
    anchor  = MANIFEST.parent
    base_dir = (anchor / manifest["base_dir"]).resolve()

    cfg = {
        "sim": {
            "debug":       False,
            "formalism":   "KET",
            "iterations":  num_runs,
            "max_workers": manifest["max_workers"],
        },
        "circuit": {
            "mode":                      circ["mode"],
            "pre_schedule_entanglement": False,
        },
        "qpu": {
            "num_qpu_nodes":        circ["num_qpu_nodes"],
            "qubits":               circ["num_qubits"],
            "emission_fidelity":    noise["emission_fidelity"],
            "collection_efficiency": noise["collection_efficiency"],
            "one_q_depolar_prob":   noise["one_q_depolar_prob"],
            "two_q_depolar_prob":   noise["two_q_depolar_prob"],
            "emission_duration":    0,
        },
        "memory": {
            "noise_model": "T1T2NoiseModel",
            "T1":          noise["T1"],
            "T2":          noise["T2"],
        },
        "gate_durations": {
            "one_q_gate_duration": noise["one_q_gate_duration"],
            "two_q_gate_duration": noise["two_q_gate_duration"],
        },
        "clock": {
            "HZ":       1000000,
            "max_ticks": -1,
        },
        "channel": {
            "q_lightspeed":       200000,
            "c_lightspeed":       200000,
            "photon_loss":        noise["photon_loss"],
            "init_photon_loss":   noise["init_photon_loss"],
            "fiber_depolar_rate": noise["fiber_depolar_rate"],
            "simulated_length_km": noise["simulated_length_km"],
            "missing_length_km":  noise["missing_length_km"],
            "quantum_noise_model": "DepolarNoiseModel",
            "time_independent":   True,
        },
        "bsm": {
            "deterministic_bsm":   bsm_cfg["deterministic_bsm"],
            "detection_window":    bsm_cfg["detection_window"],
            "system_delay":        bsm_cfg["system_delay"],
            "coupling_efficiency": bsm_cfg["coupling_efficiency"],
            "detector_wait_factor": bsm_cfg["detector_wait_factor"],
            "max_emission_retries": bsm_cfg["max_emission_retries"],
            "retry_duration":      bsm_cfg["retry_duration"],
            "detector_dead_time":  bsm_cfg["detector_dead_time"],
            "error_on_fail":       bsm_cfg["error_on_fail"],
        },
        "entanglement": {
            "method":               entanglement_method,
            "magic_state_delay_ns": 0,
        },
        "epr_factory": {
            "enabled":          False,
            "pool_only":        False,
            "drain_timeout_ns": 0,
        },
        "topology":    {"file": manifest["topology_file"]},
        "switch": {
            "port_insertion_loss": manifest["switch"]["port_insertion_loss"],
            "mems_latency_ns":     manifest["switch"]["mems_latency_ns"],
            "internal_length_km":  manifest["switch"]["internal_length_km"],
        },
        "results": {
            "top_n_bitstrings": 5,
            "plot_filename":    "",
            "save_plot":        False,
        },
    }

    # Circuit-mode-specific keys
    if circ["mode"] == "tket":
        dc_path = str((base_dir / circ["dist_commands"]).resolve())
        cfg["circuit"]["dist_commands_file"] = dc_path
        cfg["circuit"]["measure_qubits"]     = circ["measure_qubits"]
    else:
        qasm_path = str((base_dir / circ["qasm"]).resolve())
        cfg["circuit"]["qasm_file"] = qasm_path

    # EPR model knobs (required when method=epr_model)
    if entanglement_method == "epr_model":
        epr = manifest["epr_model"]
        cfg["entanglement"]["epr_fidelity"]     = epr["epr_fidelity"]
        cfg["entanglement"]["epr_rate_hz"]       = epr["epr_rate_hz"]
        cfg["entanglement"]["epr_success_prob"]  = epr["epr_success_prob"]

    return cfg


def _run_condition(tag, cfg_dict, base_dir, output_dir, log_path, raw_path, smoke):
    """Run one (circuit × entanglement) condition, return raw CSV path."""
    if raw_path.exists():
        print(f"RESUME {tag}", flush=True)
        return raw_path

    staging = output_dir / f"{tag}_staging"
    staging.mkdir(exist_ok=True)
    cfg_path = output_dir / f"{tag}.yml"
    cfg_path.write_text(yaml.safe_dump(cfg_dict, sort_keys=False), encoding="utf-8")

    n_runs = cfg_dict["sim"]["iterations"]
    if smoke:
        cfg_dict["sim"]["iterations"] = 2
        cfg_dict["sim"]["max_workers"] = 1
        cfg_path.write_text(yaml.safe_dump(cfg_dict, sort_keys=False), encoding="utf-8")
        n_runs = 2

    cmd = [
        sys.executable, "-m", "qnpack.dqc.sim",
        "-p", str(cfg_path),
        "-b", str(base_dir),
        "-o", str(staging),
        "-n", str(n_runs),
    ]
    env = os.environ.copy()
    for v in ("OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "OMP_NUM_THREADS",
              "VECLIB_MAXIMUM_THREADS", "NUMEXPR_NUM_THREADS"):
        env[v] = "1"
    env["MPLCONFIGDIR"] = str(output_dir / "matplotlib_cache")
    env["XDG_CACHE_HOME"] = str(output_dir / "cache")
    os.makedirs(env["MPLCONFIGDIR"], exist_ok=True)
    os.makedirs(env["XDG_CACHE_HOME"], exist_ok=True)

    cwd = base_dir.parent.parent
    print(f"START {tag}", flush=True)
    with log_path.open("w", encoding="utf-8") as log:
        subprocess.run(cmd, cwd=cwd, stdout=log, stderr=subprocess.STDOUT,
                       env=env, check=True)

    produced = list(staging.glob("*.csv"))
    if len(produced) != 1:
        raise RuntimeError(f"Expected 1 CSV in {staging}, found {len(produced)}")
    shutil.move(str(produced[0]), raw_path)
    staging.rmdir()
    return raw_path


def _metric(rows, circuit_cfg):
    """Compute the primary metric for a circuit condition."""
    metric = circuit_cfg["metric"]
    if metric == "p_target":
        target = circuit_cfg["target_bitstring"]
        counts = collections.Counter(r.get("bitstring", "") for r in rows)
        return counts.get(target, 0) / len(rows) if rows else 0.0
    elif metric == "p_center":
        col = circuit_cfg["center_col"]
        vals = [int(r[col]) for r in rows if r.get(col, "").strip() != ""]
        return sum(vals) / len(vals) if vals else float("nan")
    raise ValueError(f"Unknown metric: {metric!r}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--smoke", action="store_true",
                        help="Quick 2-run smoke test per condition")
    args = parser.parse_args()

    manifest = _load_manifest()
    anchor   = MANIFEST.parent
    base_dir = (anchor / manifest["base_dir"]).resolve()
    out_dir  = (anchor / manifest["output_dir"]).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    conditions = [
        ("bsm",       manifest["bsm_num_runs"]),
        ("epr_model", manifest["epr_num_runs"]),
    ]

    summary = []

    for circuit_key, circuit_cfg in manifest["circuits"].items():
        for ent_method, num_runs in conditions:
            tag = f"{circuit_key}_{ent_method}_{num_runs}runs"
            if args.smoke:
                tag += "_smoke"

            raw_path = out_dir / f"{tag}.csv"
            log_path = out_dir / f"{tag}.log"

            cfg = _build_config(manifest, circuit_key, ent_method, num_runs)
            _run_condition(tag, cfg, base_dir, out_dir, log_path, raw_path, args.smoke)

            with raw_path.open(newline="", encoding="utf-8") as f:
                rows = list(csv.DictReader(f))

            m = _metric(rows, circuit_cfg)
            label = "Physical BSM\n(Full SotA)" if ent_method == "bsm" \
                    else "EPR model\n(d=3 EC, F=0.93)"
            summary.append({
                "circuit_key":   circuit_key,
                "circuit_label": circuit_cfg["label"],
                "entanglement":  ent_method,
                "condition_label": label,
                "num_runs":      len(rows),
                "metric":        circuit_cfg["metric"],
                "value":         round(m, 5),
                "raw_csv":       raw_path.name,
            })
            print(f"DONE {tag}: metric={m:.4f} ({len(rows)} shots)", flush=True)

    # Write summary CSV
    summary_path = out_dir / "epr_ec_comparison_summary.csv"
    if summary:
        with summary_path.open("w", newline="", encoding="utf-8") as f:
            w = csv.DictWriter(f, fieldnames=list(summary[0]))
            w.writeheader()
            w.writerows(summary)
    print(f"\nSummary: {summary_path}")
    return summary


if __name__ == "__main__":
    main()
