"""Run a resumable Grover BSM/KET fiber depolarization sweep.

Usage: python -m qnpack.dqc.experiments.grover_channel_sweep --manifest PATH
Every experiment setting is supplied by the manifest or its parameters file.
"""

import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

import yaml

from .grover_sweep import (
    _path, _positive_int, _read_csv, _required, _sha256, _worker_count,
    _write_csv,
)


REQUIRED_FIELDS = (
    "algorithm", "parameters_file", "base_dir", "output_dir", "num_runs",
    "max_workers", "numerical_threads_per_worker",
    "target_bitstring", "circuit_mode", "entanglement_method", "formalism",
    "qpu_circuits",
)

#: The original manifests sweep `channel.fiber_depolar_rate` through a
#: top-level `fiber_depolar_rates` list. A manifest may instead carry a
#: `sweep` block naming any parameter to vary; both forms resolve to the
#: same (section, key, values, tag) specification.
LEGACY_SWEEP = ("channel", "fiber_depolar_rate", "fiber")

#: Swept parameters the simulator does not echo into its raw CSV, warned once.
_warned_uncheckable = defaultdict(bool)


def _load_manifest(path):
    with path.open(encoding="utf-8") as stream:
        manifest = yaml.safe_load(stream)
    if not isinstance(manifest, dict):
        raise ValueError("The manifest must be a YAML mapping")
    for field in REQUIRED_FIELDS:
        _required(manifest, field, "manifest")
    if "starting_seed" in manifest:
        raise ValueError("Remove starting_seed; each shot uses fresh random state")
    if not isinstance(manifest["algorithm"], str) or not re.fullmatch(r"[A-Za-z0-9_]+", manifest["algorithm"]):
        raise ValueError("algorithm must contain only letters, digits, and underscores")
    if manifest["circuit_mode"] != "cisco":
        raise ValueError("circuit_mode must be cisco")
    if manifest["entanglement_method"] != "bsm":
        raise ValueError("entanglement_method must be bsm")
    if manifest["formalism"] != "KET":
        raise ValueError("formalism must be KET")
    _positive_int(manifest["num_runs"], "num_runs")
    if manifest["max_workers"] != "auto":
        _positive_int(manifest["max_workers"], "max_workers")
    _positive_int(manifest["numerical_threads_per_worker"], "numerical_threads_per_worker")
    target = manifest["target_bitstring"]
    if not isinstance(target, str) or not target or set(target) - {"0", "1"}:
        raise ValueError("target_bitstring must be a nonempty binary string")
    circuits = manifest["qpu_circuits"]
    if not isinstance(circuits, dict) or not circuits:
        raise ValueError("qpu_circuits must be a nonempty mapping")
    for count, source in circuits.items():
        _positive_int(count, "qpu_circuits key")
        _path(Path(), source, f"qpu_circuits.{count}")
    _sweep_spec(manifest)
    return manifest


def _sweep_spec(manifest):
    """Resolve the manifest's sweep to (section, key, values, tag)."""
    legacy = "fiber_depolar_rates" in manifest
    block = manifest.get("sweep")
    if legacy and block is not None:
        raise ValueError("Give either fiber_depolar_rates or a sweep block, not both")
    if legacy:
        section, key, tag = LEGACY_SWEEP
        values = manifest["fiber_depolar_rates"]
    elif block is not None:
        for field in ("section", "key", "tag", "values"):
            _required(block, field, "manifest.sweep")
        section, key, tag = block["section"], block["key"], block["tag"]
        for name, value in (("section", section), ("key", key), ("tag", tag)):
            if not isinstance(value, str) or not re.fullmatch(r"[A-Za-z0-9_]+", value):
                raise ValueError(f"sweep.{name} must contain only letters, digits, and underscores")
        values = block["values"]
    else:
        raise ValueError("manifest must contain fiber_depolar_rates or a sweep block")

    if not isinstance(values, list) or not values:
        raise ValueError("The sweep values must be a nonempty list")
    for value in values:
        if isinstance(value, bool) or not isinstance(value, (int, float)) or not 0 <= value <= 1:
            raise ValueError("The sweep values must be numbers in [0, 1]")
    if len(set(values)) != len(values):
        raise ValueError("The sweep values must be unique")
    return section, key, values, tag


def _load_parameters(path):
    with path.open(encoding="utf-8") as stream:
        config = yaml.safe_load(stream)
    for section in ("sim", "circuit", "entanglement", "qpu", "memory", "channel"):
        _required(config, section, "parameters")
    if "starting_seed" in config["sim"]:
        raise ValueError("Remove sim.starting_seed; each shot uses fresh random state")
    for section, keys in {
        "qpu": ("two_q_depolar_prob", "one_q_depolar_prob", "emission_fidelity", "collection_efficiency"),
        "memory": ("T1", "T2"),
        "channel": ("fiber_depolar_rate", "time_independent"),
    }.items():
        for key in keys:
            _required(config[section], key, f"parameters.{section}")
    if config["channel"]["time_independent"] is not True:
        raise ValueError("channel.time_independent must be true for a per-photon probability sweep")
    return config


def _rate_tag(rate):
    return format(rate, "g").replace(".", "p")


def _run_condition(manifest, paths, run_count, workers, threads, qpu_count,
                   qasm_relative, rate, rate_index, spec):
    section, key, _, sweep_tag = spec
    qasm_path = _path(paths["base_dir"], qasm_relative, "qasm_file")
    if not qasm_path.is_file():
        raise FileNotFoundError(qasm_path)
    tag = (f"{manifest['algorithm']}_cisco_bsm_ket_{qpu_count}qpu_"
           f"{sweep_tag}{_rate_tag(rate)}_{run_count}runs")
    output_dir = paths["output_dir"]
    raw_path = output_dir / f"{tag}.csv"
    config_path = output_dir / f"{tag}.yml"
    metadata_path = output_dir / f"{tag}.json"
    log_path = output_dir / f"{tag}.log"

    config = _load_parameters(paths["parameters_file"])
    config["sim"]["iterations"] = run_count
    config["sim"]["max_workers"] = workers
    config["sim"]["formalism"] = manifest["formalism"]
    config["circuit"]["mode"] = manifest["circuit_mode"]
    config["circuit"]["qasm_file"] = str(qasm_path)
    config["entanglement"]["method"] = manifest["entanglement_method"]
    if key not in config[section]:
        raise ValueError(f"parameters.{section}.{key} is absent; cannot sweep it")
    config[section][key] = rate
    config_text = yaml.safe_dump(config, sort_keys=False)
    metadata = {
        "algorithm": manifest["algorithm"],
        "qpu_count": qpu_count,
        "qasm_file": str(qasm_path),
        "qasm_sha256": _sha256(qasm_path),
        "parameters_sha256": hashlib.sha256(config_text.encode("utf-8")).hexdigest(),
        "target_bitstring": manifest["target_bitstring"],
        "circuit_mode": manifest["circuit_mode"],
        "entanglement_method": manifest["entanglement_method"],
        "formalism": manifest["formalism"],
        "num_runs": run_count,
        "max_workers": workers,
        "numerical_threads_per_worker": threads,
        "swept_parameter": f"{section}.{key}",
        "fiber_depolar_rate": config["channel"]["fiber_depolar_rate"],
        "two_q_depolar_prob": config["qpu"]["two_q_depolar_prob"],
        "one_q_depolar_prob": config["qpu"]["one_q_depolar_prob"],
        "emission_fidelity": config["qpu"]["emission_fidelity"],
        "collection_efficiency": config["qpu"]["collection_efficiency"],
        "T1": config["memory"]["T1"],
        "T2": config["memory"]["T2"],
    }

    if raw_path.exists():
        if not metadata_path.is_file():
            raise ValueError(f"{raw_path} exists without matching metadata")
        with metadata_path.open(encoding="utf-8") as stream:
            if json.load(stream) != metadata:
                raise ValueError(f"{raw_path} belongs to another configuration")
        print(f"RESUME {tag}", flush=True)
    else:
        if metadata_path.exists():
            raise ValueError(f"{metadata_path} exists without its raw CSV")
        config_path.write_text(config_text, encoding="utf-8")
        staging_dir = output_dir / f"{tag}_staging"
        staging_dir.mkdir(exist_ok=True)
        command = [sys.executable, "-m", "qnpack.dqc.sim", "-p", str(config_path),
                   "-b", str(paths["base_dir"]), "-o", str(staging_dir),
                   "-n", str(run_count)]
        environment = os.environ.copy()
        for name in ("OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "OMP_NUM_THREADS",
                     "VECLIB_MAXIMUM_THREADS", "NUMEXPR_NUM_THREADS"):
            environment[name] = str(threads)
        environment["MPLCONFIGDIR"] = str(paths["matplotlib_cache"])
        environment["XDG_CACHE_HOME"] = str(paths["cache_dir"])
        print(f"START {tag}", flush=True)
        with log_path.open("w", encoding="utf-8") as log:
            subprocess.run(command, stdout=log, stderr=subprocess.STDOUT,
                           env=environment, check=True)
        produced = list(staging_dir.glob("*.csv"))
        if len(produced) != 1:
            raise ValueError(f"Expected one simulator CSV in {staging_dir}, found {len(produced)}")
        produced[0].replace(raw_path)
        metadata_path.write_text(json.dumps(metadata, indent=2) + "\n", encoding="utf-8")
        staging_dir.rmdir()

    fields, rows = _read_csv(raw_path)
    if len(rows) != run_count:
        raise ValueError(f"{raw_path}: expected {run_count} rows, found {len(rows)}")
    if any(len(row["bitstring"]) != len(manifest["target_bitstring"])
           or set(row["bitstring"]) - {"0", "1"} for row in rows):
        raise ValueError(f"{raw_path}: invalid measurement bitstring")
    if key in fields:
        if any(float(row[key]) != rate for row in rows):
            raise ValueError(f"{raw_path}: {key} does not match the requested value")
    elif not _warned_uncheckable[section, key]:
        # The simulator records only a fixed column set; a swept parameter
        # outside it cannot be confirmed from the raw CSV itself.
        print(f"NOTE {section}.{key} is not a raw CSV column; its value is "
              f"verified from the effective config only", flush=True)
        _warned_uncheckable[section, key] = True
    if {int(row["run"]) for row in rows} != set(range(run_count)):
        raise ValueError(f"{raw_path}: run indices do not match")
    states = [row["rng_state_sha256"] for row in rows]
    if any(not state for state in states) or len(set(states)) != run_count:
        raise ValueError(f"{raw_path}: random states are missing or repeated")
    if min(_worker_count(workers), run_count) > 1 and len({row["worker_pid"] for row in rows}) < 2:
        raise ValueError(f"{raw_path}: multiple worker processes were not observed")

    hits = sum(row["bitstring"] == manifest["target_bitstring"] for row in rows)
    summary = {
        "algorithm": manifest["algorithm"],
        "circuit_mode": manifest["circuit_mode"],
        "entanglement_method": manifest["entanglement_method"],
        "formalism": manifest["formalism"],
        "qpu_count": qpu_count,
        "qasm_file": qasm_relative,
        "sweep_index": rate_index,
        "swept_parameter": f"{section}.{key}",
        "swept_value": rate,
        "fiber_depolar_rate": config["channel"]["fiber_depolar_rate"],
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
    parser.add_argument("--max-workers", type=int)
    parser.add_argument("--output-dir", type=Path)
    parser.add_argument("--qpu-count", type=int)
    parser.add_argument("--rate-index", type=int,
                        help="Select one rate by its one-based position in the manifest")
    args = parser.parse_args(argv)
    manifest_path = args.manifest.expanduser().resolve()
    manifest = _load_manifest(manifest_path)
    run_count = manifest["num_runs"] if args.num_runs is None else _positive_int(args.num_runs, "--num-runs")
    workers = manifest["max_workers"] if args.max_workers is None else _positive_int(args.max_workers, "--max-workers")
    if args.qpu_count is not None and args.qpu_count not in manifest["qpu_circuits"]:
        raise ValueError("--qpu-count is absent from qpu_circuits")
    spec = _sweep_spec(manifest)
    if args.rate_index is not None and not 1 <= args.rate_index <= len(spec[2]):
        raise ValueError("--rate-index is outside the sweep values")
    if any(value is not None for value in (args.num_runs, args.max_workers, args.qpu_count, args.rate_index)) and args.output_dir is None:
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
    rates = spec[2]
    for qpu_count, qasm_relative in manifest["qpu_circuits"].items():
        if args.qpu_count is not None and qpu_count != args.qpu_count:
            continue
        for rate_offset, rate in enumerate(rates):
            rate_index = rate_offset + 1
            if args.rate_index is not None and rate_index != args.rate_index:
                continue
            summary, fields, rows = _run_condition(
                manifest, paths, run_count, workers,
                manifest["numerical_threads_per_worker"], qpu_count,
                qasm_relative, rate, rate_index, spec,
            )
            summaries.append(summary)
            if combined_fields is None:
                combined_fields = ["qpu_count", "sweep_index", *fields]
            elif combined_fields != ["qpu_count", "sweep_index", *fields]:
                raise ValueError("Raw CSV columns differ across conditions")
            combined_rows.extend({"qpu_count": qpu_count, "sweep_index": rate_index, **row}
                                 for row in rows)
            prefix = f"{manifest['algorithm']}_cisco_bsm_ket"
            _write_csv(output_dir / f"{prefix}_target_{manifest['target_bitstring']}_summary.csv",
                       list(summaries[0]), summaries)
            _write_csv(output_dir / f"{prefix}_all_runs.csv", combined_fields, combined_rows)


if __name__ == "__main__":
    main()
