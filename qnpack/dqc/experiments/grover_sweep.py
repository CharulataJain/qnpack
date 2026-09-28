"""Run a file-driven Grover noise sweep with isolated simulator processes.

Usage: python -m qnpack.dqc.experiments.grover_sweep --manifest PATH
All experiment values and paths are supplied by the manifest.
"""

import argparse
import csv
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path

import yaml


REQUIRED_FIELDS = (
    "algorithm",
    "parameters_file",
    "base_dir",
    "output_dir",
    "num_runs",
    "max_workers",
    "numerical_threads_per_worker",
    "starting_seed",
    "target_bitstring",
    "circuit_mode",
    "entanglement_method",
    "qpu_circuits",
    "noise_pairs",
)


def _required(mapping, key, location):
    if not isinstance(mapping, dict) or key not in mapping:
        raise ValueError(f"{location}.{key} is required")
    return mapping[key]


def _positive_int(value, name):
    if isinstance(value, bool) or not isinstance(value, int) or value <= 0:
        raise ValueError(f"{name} must be a positive integer")
    return value


def _path(anchor, value, name):
    if not isinstance(value, str) or not value.strip():
        raise ValueError(f"{name} must be a nonempty path")
    return (anchor / value).expanduser().resolve()


def _load_manifest(path):
    with path.open(encoding="utf-8") as stream:
        manifest = yaml.safe_load(stream)
    if not isinstance(manifest, dict):
        raise ValueError("The manifest must be a YAML mapping")
    for field in REQUIRED_FIELDS:
        _required(manifest, field, "manifest")

    algorithm = manifest["algorithm"]
    if not isinstance(algorithm, str) or not re.fullmatch(r"[A-Za-z0-9_]+", algorithm):
        raise ValueError("algorithm must contain only letters, digits, and underscores")
    if manifest["circuit_mode"] != "cisco":
        raise ValueError("circuit_mode must be cisco for this runner")
    if manifest["entanglement_method"] != "magic":
        raise ValueError("entanglement_method must be magic for this runner")

    _positive_int(manifest["num_runs"], "num_runs")
    workers = manifest["max_workers"]
    if workers != "auto":
        _positive_int(workers, "max_workers")
    _positive_int(manifest["numerical_threads_per_worker"], "numerical_threads_per_worker")
    seed = manifest["starting_seed"]
    if isinstance(seed, bool) or not isinstance(seed, int) or seed < 0:
        raise ValueError("starting_seed must be a nonnegative integer")

    target = manifest["target_bitstring"]
    if not isinstance(target, str) or not target or set(target) - {"0", "1"}:
        raise ValueError("target_bitstring must be a nonempty binary string")
    circuits = manifest["qpu_circuits"]
    if not isinstance(circuits, dict) or not circuits:
        raise ValueError("qpu_circuits must be a nonempty mapping")
    for count, source in circuits.items():
        _positive_int(count, "qpu_circuits key")
        _path(Path(), source, f"qpu_circuits.{count}")
    pairs = manifest["noise_pairs"]
    if not isinstance(pairs, list) or not pairs:
        raise ValueError("noise_pairs must be a nonempty list")
    for index, pair in enumerate(pairs):
        for name in ("two_q_depolar_prob", "one_q_depolar_prob"):
            value = _required(pair, name, f"noise_pairs[{index}]")
            if isinstance(value, bool) or not isinstance(value, (int, float)) or not 0 <= value <= 1:
                raise ValueError(f"noise_pairs[{index}].{name} must be in [0, 1]")
    return manifest


def _write_csv(path, fieldnames, rows):
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def _read_csv(path):
    with path.open(newline="", encoding="utf-8") as stream:
        reader = csv.DictReader(stream)
        return reader.fieldnames, list(reader)


def _sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _worker_count(setting):
    if setting == "auto":
        count = os.cpu_count()
        if count is None:
            raise ValueError("Cannot detect CPU count; specify max_workers")
        return count
    return setting


def _run_condition(manifest, paths, run_count, worker_setting, threads_per_worker,
                   qpu_count, qasm_relative, pair, pair_index, condition_index):
    algorithm = manifest["algorithm"]
    two_q = pair["two_q_depolar_prob"]
    one_q = pair["one_q_depolar_prob"]
    tag = (
        f"{algorithm}_cisco_magic_{qpu_count}qpu_"
        f"2q{two_q:.0e}_1q{one_q:.0e}_{run_count}runs"
    )
    output_dir = paths["output_dir"]
    raw_path = output_dir / f"{tag}.csv"
    config_path = output_dir / f"{tag}.yml"
    metadata_path = output_dir / f"{tag}.json"
    log_path = output_dir / f"{tag}.log"
    qasm_path = _path(paths["base_dir"], qasm_relative, "qasm_file")
    if not qasm_path.is_file():
        raise FileNotFoundError(qasm_path)

    with paths["parameters_file"].open(encoding="utf-8") as stream:
        config = yaml.safe_load(stream)
    config["sim"]["iterations"] = run_count
    config["sim"]["max_workers"] = worker_setting
    config["sim"]["starting_seed"] = manifest["starting_seed"] + condition_index * run_count
    config["circuit"]["mode"] = manifest["circuit_mode"]
    config["circuit"]["qasm_file"] = str(qasm_path)
    config["entanglement"]["method"] = manifest["entanglement_method"]
    config["qpu"]["two_q_depolar_prob"] = two_q
    config["qpu"]["one_q_depolar_prob"] = one_q
    config_text = yaml.safe_dump(config, sort_keys=False)
    expected_metadata = {
        "algorithm": algorithm,
        "qpu_count": qpu_count,
        "qasm_file": str(qasm_path),
        "qasm_sha256": _sha256(qasm_path),
        "parameters_sha256": hashlib.sha256(config_text.encode("utf-8")).hexdigest(),
        "target_bitstring": manifest["target_bitstring"],
        "num_runs": run_count,
        "max_workers": worker_setting,
        "numerical_threads_per_worker": threads_per_worker,
        "starting_seed": config["sim"]["starting_seed"],
        "two_q_depolar_prob": two_q,
        "one_q_depolar_prob": one_q,
    }

    if raw_path.exists():
        if not metadata_path.is_file():
            raise ValueError(f"{raw_path} exists without matching metadata")
        with metadata_path.open(encoding="utf-8") as stream:
            recorded_metadata = json.load(stream)
        if recorded_metadata != expected_metadata:
            raise ValueError(f"{raw_path} belongs to a different experiment configuration")
        print(f"RESUME {tag}", flush=True)
    else:
        config_path.write_text(config_text, encoding="utf-8")
        staging_dir = output_dir / f"{tag}_staging"
        staging_dir.mkdir(exist_ok=True)
        command = [
            sys.executable, "-m", "qnpack.dqc.sim",
            "-p", str(config_path),
            "-b", str(paths["base_dir"]),
            "-o", str(staging_dir),
            "-n", str(run_count),
        ]
        environment = os.environ.copy()
        for name in ("OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "OMP_NUM_THREADS",
                     "VECLIB_MAXIMUM_THREADS", "NUMEXPR_NUM_THREADS"):
            environment[name] = str(threads_per_worker)
        environment["MPLCONFIGDIR"] = str(paths["matplotlib_cache"])
        environment["XDG_CACHE_HOME"] = str(paths["cache_dir"])
        print(f"START {tag}", flush=True)
        with log_path.open("w", encoding="utf-8") as log:
            subprocess.run(command, stdout=log, stderr=subprocess.STDOUT,
                           env=environment, check=True)
        produced = list(staging_dir.glob("*.csv"))
        if len(produced) != 1:
            raise ValueError(f"Expected one simulator CSV in {staging_dir}, found {len(produced)}")
        metadata_path.write_text(json.dumps(expected_metadata, indent=2) + "\n",
                                 encoding="utf-8")
        produced[0].replace(raw_path)
        staging_dir.rmdir()

    fields, rows = _read_csv(raw_path)
    if len(rows) != run_count:
        raise ValueError(f"{raw_path}: expected {run_count} rows, found {len(rows)}")
    if any(len(row["bitstring"]) != len(manifest["target_bitstring"])
           or set(row["bitstring"]) - {"0", "1"} for row in rows):
        raise ValueError(f"{raw_path}: invalid measurement bitstring")
    if any(float(row["two_q_depolar_prob"]) != two_q
           or float(row["one_q_depolar_prob"]) != one_q for row in rows):
        raise ValueError(f"{raw_path}: noise columns do not match")
    seeds = {int(row["seed"]) for row in rows}
    expected_seeds = set(range(config["sim"]["starting_seed"],
                               config["sim"]["starting_seed"] + run_count))
    if seeds != expected_seeds:
        raise ValueError(f"{raw_path}: run seeds do not match")
    if min(_worker_count(worker_setting), run_count) > 1:
        if len({row["worker_pid"] for row in rows}) < 2:
            raise ValueError(f"{raw_path}: multiple worker processes were not observed")

    hits = sum(row["bitstring"] == manifest["target_bitstring"] for row in rows)
    summary = {
        "algorithm": algorithm,
        "circuit_mode": manifest["circuit_mode"],
        "entanglement_method": manifest["entanglement_method"],
        "qpu_count": qpu_count,
        "qasm_file": qasm_relative,
        "sweep_index": pair_index,
        "two_q_depolar_prob": two_q,
        "one_q_depolar_prob": one_q,
        "noise_pair": f"2q={two_q:.0e}, 1q={one_q:.0e}",
        "target_bitstring": manifest["target_bitstring"],
        "target_count": hits,
        "num_runs": run_count,
        "target_state_probability": hits / run_count,
        "raw_csv": raw_path.name,
    }
    print(f"DONE {tag}: {hits}/{run_count}", flush=True)
    return summary, fields, rows


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--num-runs", type=int)
    parser.add_argument("--max-workers")
    parser.add_argument("--output-dir", type=Path)
    parser.add_argument("--qpu-count", type=int)
    parser.add_argument("--noise-pair-index", type=int,
                        help="Select one pair by its one-based position in the manifest")
    args = parser.parse_args(argv)

    manifest_path = args.manifest.expanduser().resolve()
    manifest = _load_manifest(manifest_path)
    if args.max_workers is None:
        worker_setting = manifest["max_workers"]
    elif args.max_workers == "auto":
        worker_setting = "auto"
    else:
        try:
            worker_setting = int(args.max_workers)
        except ValueError as error:
            raise ValueError("--max-workers must be auto or a positive integer") from error
        _positive_int(worker_setting, "--max-workers")
    run_count = manifest["num_runs"] if args.num_runs is None else _positive_int(args.num_runs, "--num-runs")
    threads_per_worker = manifest["numerical_threads_per_worker"]
    if args.qpu_count is not None and args.qpu_count not in manifest["qpu_circuits"]:
        raise ValueError(f"QPU count {args.qpu_count} is absent from the manifest")
    if args.noise_pair_index is not None and not 1 <= args.noise_pair_index <= len(manifest["noise_pairs"]):
        raise ValueError("--noise-pair-index is outside the manifest's noise_pairs")
    if (args.num_runs is not None or args.max_workers is not None
            or args.qpu_count is not None or args.noise_pair_index is not None):
        if args.output_dir is None:
            raise ValueError("--output-dir is required when overriding or filtering a run")

    anchor = manifest_path.parent
    output_dir = (_path(anchor, manifest["output_dir"], "output_dir")
                  if args.output_dir is None else args.output_dir.expanduser().resolve())
    paths = {
        "parameters_file": _path(anchor, manifest["parameters_file"], "parameters_file"),
        "base_dir": _path(anchor, manifest["base_dir"], "base_dir"),
        "output_dir": output_dir,
        "matplotlib_cache": output_dir / "matplotlib_cache",
        "cache_dir": output_dir / "cache",
    }
    if not paths["parameters_file"].is_file():
        raise FileNotFoundError(paths["parameters_file"])
    if not paths["base_dir"].is_dir():
        raise NotADirectoryError(paths["base_dir"])
    for directory in (output_dir, paths["matplotlib_cache"], paths["cache_dir"]):
        directory.mkdir(parents=True, exist_ok=True)

    summaries = []
    combined_rows = []
    combined_fields = None
    pair_count = len(manifest["noise_pairs"])
    for qpu_index, (qpu_count, qasm_relative) in enumerate(manifest["qpu_circuits"].items()):
        if args.qpu_count is not None and qpu_count != args.qpu_count:
            continue
        for pair_offset, pair in enumerate(manifest["noise_pairs"]):
            pair_index = pair_offset + 1
            if args.noise_pair_index is not None and pair_index != args.noise_pair_index:
                continue
            condition_index = qpu_index * pair_count + pair_offset
            summary, fields, rows = _run_condition(
                manifest, paths, run_count, worker_setting, threads_per_worker,
                qpu_count, qasm_relative, pair, pair_index, condition_index,
            )
            summaries.append(summary)
            if combined_fields is None:
                combined_fields = ["qpu_count", "sweep_index", *fields]
            elif combined_fields != ["qpu_count", "sweep_index", *fields]:
                raise ValueError("Raw CSV columns differ across conditions")
            combined_rows.extend(
                {"qpu_count": qpu_count, "sweep_index": pair_index, **row}
                for row in rows
            )
            prefix = f"{manifest['algorithm']}_cisco_magic"
            _write_csv(output_dir / f"{prefix}_target_{manifest['target_bitstring']}_summary.csv",
                       list(summaries[0]), summaries)
            _write_csv(output_dir / f"{prefix}_all_runs.csv",
                       combined_fields, combined_rows)


if __name__ == "__main__":
    main()
