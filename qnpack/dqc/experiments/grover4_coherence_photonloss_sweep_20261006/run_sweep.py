"""Run the joint T1/T2-coherence × photon-loss sweep for Grover 4, 2 & 3 QPU.

Usage: python run_sweep.py [--qpu-count N]

Each point in manifest.yml bundles a coherence time with a channel loss
pair; they vary together, not independently, so each condition is one
simulator invocation at one (T1, T2, photon_loss, collection_efficiency)
tuple. Resumable: a condition with a matching raw CSV + metadata is reused.
"""

import argparse
import hashlib
import json
import os
import subprocess
import sys
from pathlib import Path

import yaml


def _write_csv(path, fieldnames, rows):
    import csv
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def _read_csv(path):
    import csv
    with path.open(newline="", encoding="utf-8") as stream:
        reader = csv.DictReader(stream)
        return reader.fieldnames, list(reader)


def _sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _tag(algorithm, qpu_count, point, run_count):
    t1_tag = format(point["T1"], "g").replace(".", "p")
    return f"{algorithm}_cisco_bsm_ket_{qpu_count}qpu_coh{t1_tag}_{run_count}runs"


def _run_condition(manifest, paths, run_count, qpu_count, qasm_relative,
                   point, point_index):
    algorithm = "grover4"
    qasm_path = (paths["base_dir"] / qasm_relative).resolve()
    if not qasm_path.is_file():
        raise FileNotFoundError(qasm_path)
    tag = _tag(algorithm, qpu_count, point, run_count)
    output_dir = paths["output_dir"]
    raw_path = output_dir / f"{tag}.csv"
    config_path = output_dir / f"{tag}.yml"
    metadata_path = output_dir / f"{tag}.json"
    log_path = output_dir / f"{tag}.log"

    config = yaml.safe_load(paths["parameters_file"].read_text(encoding="utf-8"))
    config["sim"]["iterations"] = run_count
    config["sim"]["max_workers"] = manifest["max_workers"]
    config["circuit"]["mode"] = "cisco"
    config["circuit"]["qasm_file"] = str(qasm_path)
    config["entanglement"]["method"] = "bsm"
    config["channel"]["fiber_depolar_rate"] = 0
    config["qpu"]["emission_fidelity"] = 1
    config["memory"]["T1"] = point["T1"]
    config["memory"]["T2"] = point["T2"]
    config["channel"]["photon_loss"] = point["photon_loss"]
    # collection_efficiency is a qpu-side parameter (applied in _emit_photon);
    # channel has no key of that name, so it is set only here.
    config["qpu"]["collection_efficiency"] = point["collection_efficiency"]
    config_text = yaml.safe_dump(config, sort_keys=False)

    metadata = {
        "algorithm": algorithm,
        "qpu_count": qpu_count,
        "qasm_file": str(qasm_path),
        "qasm_sha256": _sha256(qasm_path),
        "parameters_sha256": hashlib.sha256(config_text.encode("utf-8")).hexdigest(),
        "target_bitstring": manifest["target_bitstring"],
        "num_runs": run_count,
        "point_label": point["label"],
        "T1": point["T1"],
        "T2": point["T2"],
        "photon_loss": point["photon_loss"],
        "collection_efficiency": point["collection_efficiency"],
        "fiber_depolar_rate": 0,
        "emission_fidelity": 1,
        "two_q_depolar_prob": config["qpu"]["two_q_depolar_prob"],
        "one_q_depolar_prob": config["qpu"]["one_q_depolar_prob"],
    }

    if raw_path.exists():
        if not metadata_path.is_file():
            raise ValueError(f"{raw_path} exists without matching metadata")
        if json.loads(metadata_path.read_text(encoding="utf-8")) != metadata:
            raise ValueError(f"{raw_path} belongs to another configuration")
        print(f"RESUME {tag}", flush=True)
    else:
        if metadata_path.exists():
            raise ValueError(f"{metadata_path} exists without its raw CSV")
        config_path.write_text(config_text, encoding="utf-8")
        staging_dir = output_dir / f"{tag}_staging"
        staging_dir.mkdir(exist_ok=True)
        command = [manifest["python_executable"], "-m", "qnpack.dqc.sim",
                   "-p", str(config_path), "-b", str(paths["base_dir"]),
                   "-o", str(staging_dir), "-n", str(run_count)]
        environment = os.environ.copy()
        # Unpinned BLAS threading here previously produced intermittent,
        # nondeterministic "R_z is not a Clifford operator" aborts — almost
        # certainly a data race in the underlying state-vector math when
        # multiple threads touch it concurrently. grover_channel_sweep.py
        # pins these for the same reason; this runner must too.
        for name in ("OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "OMP_NUM_THREADS",
                     "VECLIB_MAXIMUM_THREADS", "NUMEXPR_NUM_THREADS"):
            environment[name] = "1"
        environment["MPLCONFIGDIR"] = str(output_dir / "matplotlib_cache")
        environment["XDG_CACHE_HOME"] = str(output_dir / "cache")
        os.makedirs(environment["MPLCONFIGDIR"], exist_ok=True)
        os.makedirs(environment["XDG_CACHE_HOME"], exist_ok=True)
        print(f"START {tag}", flush=True)
        with log_path.open("w", encoding="utf-8") as log:
            # qnpack.dqc.sim resolves some parameters.yml paths (e.g.
            # topology.file, circuit.dist_commands_file) relative to the
            # process cwd, not -b/base_dir. Launched from inside this
            # experiment subfolder without an explicit cwd, that silently
            # picks up the wrong circuit/topology and produces nondeterministic
            # failures ("R_z is not a Clifford operator") depending on which
            # file happens to resolve. Match base_dir's parent.parent (the
            # repo root containing the qnpack package), same as the sibling
            # grover4_gate_sweep_20260928/run_sweep.py.
            subprocess.run(command, cwd=paths["base_dir"].parent.parent,
                           stdout=log, stderr=subprocess.STDOUT,
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
    if any(float(row["T1"]) != point["T1"] or float(row["T2"]) != point["T2"]
           for row in rows):
        raise ValueError(f"{raw_path}: T1/T2 do not match the requested point")
    if {int(row["run"]) for row in rows} != set(range(run_count)):
        raise ValueError(f"{raw_path}: run indices do not match")
    states = [row["rng_state_sha256"] for row in rows]
    if any(not state for state in states) or len(set(states)) != run_count:
        raise ValueError(f"{raw_path}: random states are missing or repeated")
    if len({row["worker_pid"] for row in rows}) < 2:
        raise ValueError(f"{raw_path}: multiple worker processes were not observed")

    hits = sum(row["bitstring"] == manifest["target_bitstring"] for row in rows)
    summary = {
        "algorithm": algorithm,
        "qpu_count": qpu_count,
        "qasm_file": qasm_relative,
        "point_index": point_index,
        "point_label": point["label"],
        "T1": point["T1"],
        "T2": point["T2"],
        "photon_loss": point["photon_loss"],
        "collection_efficiency": point["collection_efficiency"],
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
    parser.add_argument("--qpu-count", type=int)
    args = parser.parse_args(argv)

    manifest = yaml.safe_load(Path(__file__).with_name("manifest.yml").read_text())
    if args.qpu_count is not None and args.qpu_count not in manifest["qpu_circuits"]:
        raise ValueError("--qpu-count is absent from qpu_circuits")

    paths = {
        "parameters_file": Path(manifest["source_parameters"]),
        "base_dir": Path(manifest["base_dir"]),
        "output_dir": Path(manifest["output_dir"]),
    }
    if not paths["parameters_file"].is_file():
        raise FileNotFoundError(paths["parameters_file"])
    paths["output_dir"].mkdir(parents=True, exist_ok=True)

    run_count = manifest["num_runs"]
    summaries = []
    combined_rows = []
    combined_fields = None
    prefix = "grover4_cisco_bsm_ket"

    for qpu_count, qasm_relative in manifest["qpu_circuits"].items():
        if args.qpu_count is not None and qpu_count != args.qpu_count:
            continue
        for point_offset, point in enumerate(manifest["points"]):
            point_index = point_offset + 1
            summary, fields, rows = _run_condition(
                manifest, paths, run_count, qpu_count, qasm_relative,
                point, point_index,
            )
            summaries.append(summary)
            if combined_fields is None:
                combined_fields = ["qpu_count", "point_index", *fields]
            elif combined_fields != ["qpu_count", "point_index", *fields]:
                raise ValueError("Raw CSV columns differ across conditions")
            combined_rows.extend({"qpu_count": qpu_count, "point_index": point_index, **row}
                                 for row in rows)
            _write_csv(paths["output_dir"] / f"{prefix}_target_{manifest['target_bitstring']}_summary.csv",
                       list(summaries[0]), summaries)
            _write_csv(paths["output_dir"] / f"{prefix}_all_runs.csv", combined_fields, combined_rows)

    print("ALL CONDITIONS COMPLETE", flush=True)


if __name__ == "__main__":
    main()
