"""Run the explicitly configured Grover 4 noise matrix and collate results."""

import csv
import shutil
import subprocess
from pathlib import Path

import yaml


def write_rows(path, fieldnames, rows):
    with path.open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def main():
    manifest = yaml.safe_load(Path(__file__).with_name("manifest.yml").read_text())
    output_dir = Path(manifest["output_dir"])
    source = yaml.safe_load(Path(manifest["source_parameters"]).read_text())
    summary_rows = []
    all_runs = []
    run_fields = None
    pair_count = len(manifest["noise_pairs"])

    for qpu_index, (qpu_count, qasm_file) in enumerate(manifest["qpu_circuits"].items()):
        for pair_index, pair in enumerate(manifest["noise_pairs"]):
            two_q = pair["two_q_depolar_prob"]
            one_q = pair["one_q_depolar_prob"]
            tag = (
                f"grover4_cisco_magic_{qpu_count}qpu_"
                f"2q{two_q:.0e}_1q{one_q:.0e}_{manifest['num_runs']}runs"
            )
            raw_path = output_dir / f"{tag}.csv"
            config_path = output_dir / f"{tag}.yml"
            log_path = output_dir / f"{tag}.log"
            config = yaml.safe_load(yaml.safe_dump(source))
            config["sim"]["iterations"] = manifest["num_runs"]
            config["sim"]["max_workers"] = manifest["max_workers"]
            config["sim"]["starting_seed"] = (
                manifest["starting_seed"]
                + (qpu_index * pair_count + pair_index)
                * manifest["num_runs"]
            )
            config["circuit"]["mode"] = manifest["circuit_mode"]
            config["circuit"]["qasm_file"] = qasm_file
            config["entanglement"]["method"] = manifest["entanglement_method"]
            config["qpu"]["two_q_depolar_prob"] = two_q
            config["qpu"]["one_q_depolar_prob"] = one_q
            config_path.write_text(yaml.safe_dump(config, sort_keys=False))

            if not raw_path.exists():
                staging_dir = output_dir / f"{tag}_staging"
                staging_dir.mkdir(exist_ok=True)
                command = [
                    manifest["python_executable"], "-m", "qnpack.dqc.sim",
                    "-p", str(config_path),
                    "-b", manifest["base_dir"],
                    "-o", str(staging_dir),
                    "-n", str(manifest["num_runs"]),
                ]
                print(f"START {tag}", flush=True)
                with log_path.open("w") as log:
                    subprocess.run(
                        command, cwd=Path(manifest["base_dir"]).parent.parent,
                        stdout=log, stderr=subprocess.STDOUT, check=True,
                    )
                produced = next(staging_dir.glob("*.csv"))
                shutil.move(produced, raw_path)
                staging_dir.rmdir()

            with raw_path.open(newline="") as stream:
                reader = csv.DictReader(stream)
                fields = reader.fieldnames
                rows = list(reader)
            if len(rows) != manifest["num_runs"]:
                raise ValueError(f"{raw_path}: expected {manifest['num_runs']} rows, got {len(rows)}")
            if any(len(row["bitstring"]) != len(manifest["target_bitstring"]) or "?" in row["bitstring"] for row in rows):
                raise ValueError(f"{raw_path}: invalid measurement bitstring")
            if any(float(row["two_q_depolar_prob"]) != two_q or float(row["one_q_depolar_prob"]) != one_q for row in rows):
                raise ValueError(f"{raw_path}: noise columns do not match configuration")
            if len({row["seed"] for row in rows}) != manifest["num_runs"]:
                raise ValueError(f"{raw_path}: duplicate seeds")
            if len({row["worker_pid"] for row in rows}) < 2:
                raise ValueError(f"{raw_path}: multiprocessing not observed")

            target_count = sum(row["bitstring"] == manifest["target_bitstring"] for row in rows)
            summary_rows.append({
                "algorithm": "grover4",
                "circuit_mode": manifest["circuit_mode"],
                "entanglement_method": manifest["entanglement_method"],
                "qpu_count": qpu_count,
                "qasm_file": qasm_file,
                "sweep_index": pair_index + 1,
                "two_q_depolar_prob": two_q,
                "one_q_depolar_prob": one_q,
                "noise_pair": f"2q={two_q:.0e}, 1q={one_q:.0e}",
                "target_bitstring": manifest["target_bitstring"],
                "target_count": target_count,
                "num_runs": manifest["num_runs"],
                "target_state_probability": target_count / manifest["num_runs"],
                "raw_csv": raw_path.name,
            })
            for row in rows:
                all_runs.append({"qpu_count": qpu_count, "sweep_index": pair_index + 1, **row})
            run_fields = ["qpu_count", "sweep_index", *fields]
            summary_path = output_dir / f"grover4_cisco_magic_target_{manifest['target_bitstring']}_summary.csv"
            write_rows(summary_path, list(summary_rows[0]), summary_rows)
            print(f"DONE {tag}: {target_count}/{manifest['num_runs']}", flush=True)

    write_rows(output_dir / "grover4_cisco_magic_all_runs.csv", run_fields, all_runs)


if __name__ == "__main__":
    main()
