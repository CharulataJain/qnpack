"""init_photon_loss sweep for QAOA 9q in tket/BSM/KET mode.

Sweeps channel.init_photon_loss across 1QPU (magic, reference) and
2QPU (BSM) circuits. All other realistic noise is held fixed.

Usage:
    python -m qnpack.dqc.experiments.qaoa9_initphotonloss_sweep.run_sweep

Smoke test (2QPU, initpl=0.3, 2 runs):
    python -m qnpack.dqc.experiments.qaoa9_initphotonloss_sweep.run_sweep \
        --num-runs 2 --circuit-label 2qpu --rate-index 4
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


def _write_csv(path, fieldnames, rows):
    with path.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(rows)


def _top_bitstring(rows):
    counts = collections.Counter(r.get("bitstring", "") for r in rows if r.get("bitstring", "").strip())
    if not counts:
        return "", 0
    top, count = counts.most_common(1)[0]
    return top, count


def _initpl_tag(value):
    return format(value, "g").replace(".", "p")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--num-runs", type=int,
                        help="Override num_runs from manifest (for smoke tests)")
    parser.add_argument("--circuit-label", metavar="LABEL",
                        help="Run only this circuit label (e.g. '2qpu')")
    parser.add_argument("--rate-index", type=int, metavar="N",
                        help="Run only this 1-based index into init_photon_loss_values")
    args = parser.parse_args(argv)

    manifest_path = Path(__file__).with_name("manifest.yml")
    manifest = yaml.safe_load(manifest_path.read_text(encoding="utf-8"))
    anchor = manifest_path.parent

    base_dir = (anchor / manifest["base_dir"]).resolve()
    output_dir = (anchor / manifest["output_dir"]).resolve()
    output_dir.mkdir(parents=True, exist_ok=True)

    source_cfg = yaml.safe_load((anchor / manifest["source_parameters"]).resolve().read_text(encoding="utf-8"))
    initpl_values = manifest["init_photon_loss_values"]
    circuits = manifest["circuits"]

    if args.circuit_label is not None and args.circuit_label not in circuits:
        raise ValueError(f"--circuit-label '{args.circuit_label}' not in manifest circuits: {list(circuits)}")
    if args.rate_index is not None and not 1 <= args.rate_index <= len(initpl_values):
        raise ValueError(f"--rate-index {args.rate_index} out of range [1, {len(initpl_values)}]")

    summary_rows = []

    for circuit_label, circuit_cfg in circuits.items():
        if args.circuit_label is not None and circuit_label != args.circuit_label:
            continue

        dist_commands_path = (base_dir / circuit_cfg["dist_commands"]).resolve()
        if not dist_commands_path.is_file():
            raise FileNotFoundError(f"dist_commands not found: {dist_commands_path}")
        entanglement_method = circuit_cfg["entanglement_method"]
        num_runs = args.num_runs if args.num_runs is not None else circuit_cfg.get("num_runs", manifest["num_runs"])
        measure_qubits = circuit_cfg["measure_qubits"]

        for rate_offset, initpl in enumerate(initpl_values):
            rate_index = rate_offset + 1
            if args.rate_index is not None and rate_index != args.rate_index:
                continue

            tag = (
                f"qaoa9_tket_bsm_ket_{circuit_label}_"
                f"initpl{_initpl_tag(initpl)}_{num_runs}runs"
            )
            raw_path = output_dir / f"{tag}.csv"
            config_path = output_dir / f"{tag}.yml"
            log_path = output_dir / f"{tag}.log"

            config = yaml.safe_load(yaml.safe_dump(source_cfg))
            config["sim"]["iterations"] = num_runs
            config["sim"]["max_workers"] = manifest["max_workers"]
            config["sim"].pop("starting_seed", None)
            config["circuit"]["mode"] = manifest["circuit_mode"]
            config["circuit"]["dist_commands_file"] = str(dist_commands_path)
            config["circuit"]["measure_qubits"] = measure_qubits
            config["entanglement"]["method"] = entanglement_method
            config["qpu"]["two_q_depolar_prob"] = manifest["two_q_depolar_prob"]
            config["qpu"]["one_q_depolar_prob"] = manifest["one_q_depolar_prob"]
            config["qpu"]["emission_fidelity"] = manifest["emission_fidelity"]
            config["qpu"]["collection_efficiency"] = manifest["collection_efficiency"]
            config["memory"]["T1"] = manifest["T1"]
            config["memory"]["T2"] = manifest["T2"]
            config["channel"]["photon_loss"] = manifest["photon_loss"]
            config["channel"]["fiber_depolar_rate"] = manifest["fiber_depolar_rate"]
            config["channel"]["init_photon_loss"] = initpl
            config_path.write_text(yaml.safe_dump(config, sort_keys=False), encoding="utf-8")

            if not raw_path.exists():
                staging_dir = output_dir / f"{tag}_staging"
                staging_dir.mkdir(exist_ok=True)
                command = [
                    sys.executable, "-m", "qnpack.dqc.sim",
                    "-p", str(config_path),
                    "-b", str(base_dir),
                    "-o", str(staging_dir),
                    "-n", str(num_runs),
                ]
                environment = os.environ.copy()
                for name in ("OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "OMP_NUM_THREADS",
                             "VECLIB_MAXIMUM_THREADS", "NUMEXPR_NUM_THREADS"):
                    environment[name] = "1"
                environment["MPLCONFIGDIR"] = str(output_dir / "matplotlib_cache")
                environment["XDG_CACHE_HOME"] = str(output_dir / "cache")
                os.makedirs(environment["MPLCONFIGDIR"], exist_ok=True)
                os.makedirs(environment["XDG_CACHE_HOME"], exist_ok=True)
                print(f"START {tag}", flush=True)
                with log_path.open("w", encoding="utf-8") as log:
                    subprocess.run(
                        command,
                        cwd=base_dir.parent.parent,
                        stdout=log, stderr=subprocess.STDOUT,
                        env=environment, check=True,
                    )
                produced = list(staging_dir.glob("*.csv"))
                if len(produced) != 1:
                    raise ValueError(f"Expected one CSV in {staging_dir}, found {len(produced)}")
                shutil.move(str(produced[0]), raw_path)
                staging_dir.rmdir()
            else:
                print(f"RESUME {tag}", flush=True)

            with raw_path.open(newline="", encoding="utf-8") as f:
                rows = list(csv.DictReader(f))

            top_bs, top_count = _top_bitstring(rows)
            summary_rows.append({
                "circuit": circuit_label,
                "entanglement_method": entanglement_method,
                "init_photon_loss": initpl,
                "num_runs": len(rows),
                "top_bitstring": top_bs,
                "top_count": top_count,
                "top_probability": round(top_count / len(rows), 6) if rows else float("nan"),
                "raw_csv": raw_path.name,
            })
            print(
                f"DONE {tag}: top={top_bs!r} {top_count}/{len(rows)}",
                flush=True,
            )

    if summary_rows:
        summary_path = output_dir / "qaoa9_bsm_ket_initpl_sweep_summary.csv"
        _write_csv(summary_path, list(summary_rows[0]), summary_rows)
        print(f"\nSummary written to {summary_path}")


if __name__ == "__main__":
    main()
