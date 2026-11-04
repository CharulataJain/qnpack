"""Gate depolarizing sweep for plaquette simulation (n=6).

Sweeps two_q_depolar_prob / one_q_depolar_prob across 1D/2D × 1QPU/2QPU circuits.
Emission fidelity is held fixed at 1.0 and magic entanglement is used for all
circuits so the two noise sources are mutually exclusive.

Usage:
    python -m qnpack.dqc.experiments.plaquette_gate_depol_sweep_20261030.run_sweep
"""

import csv
import shutil
import subprocess
from pathlib import Path

import yaml


CENTER_COL = "meas_4"


def _write_csv(path, fieldnames, rows):
    with path.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(rows)


def _p_center(rows):
    vals = [int(r[CENTER_COL]) for r in rows if r.get(CENTER_COL, "").strip() != ""]
    return sum(vals) / len(vals) if vals else float("nan")


def main():
    manifest_path = Path(__file__).with_name("manifest.yml")
    manifest = yaml.safe_load(manifest_path.read_text())

    base_dir = Path(manifest["base_dir"])
    output_dir = Path(manifest["output_dir"])
    output_dir.mkdir(parents=True, exist_ok=True)

    source_cfg = yaml.safe_load(Path(manifest["source_parameters"]).read_text())
    num_runs = manifest["num_runs"]
    max_workers = manifest["max_workers"]
    circuit_mode = manifest["circuit_mode"]
    entanglement_method = manifest["entanglement_method"]
    emission_fidelity = manifest["emission_fidelity"]
    noise_pairs = manifest["noise_pairs"]
    circuits = manifest["circuits"]   # {label: relative_qasm_path}

    summary_rows = []
    pair_count = len(noise_pairs)

    for circuit_idx, (circuit_label, qasm_relative) in enumerate(circuits.items()):
        qasm_path = (base_dir / qasm_relative).resolve()
        if not qasm_path.is_file():
            raise FileNotFoundError(f"QASM not found: {qasm_path}")

        for pair_idx, pair in enumerate(noise_pairs):
            two_q = pair["two_q_depolar_prob"]
            one_q = pair["one_q_depolar_prob"]

            tag = (
                f"plaq_depol_{circuit_label}_n{manifest['n_steps']}_"
                f"2q{two_q:.0e}_1q{one_q:.0e}_{num_runs}runs"
            )
            raw_path = output_dir / f"{tag}.csv"
            config_path = output_dir / f"{tag}.yml"
            log_path = output_dir / f"{tag}.log"

            # Build config for this condition
            config = yaml.safe_load(yaml.safe_dump(source_cfg))
            config["sim"]["iterations"] = num_runs
            config["sim"]["max_workers"] = max_workers
            config["sim"].pop("starting_seed", None)
            config["circuit"]["mode"] = circuit_mode
            config["circuit"]["qasm_file"] = str(qasm_path)
            config["entanglement"]["method"] = entanglement_method
            config["qpu"]["two_q_depolar_prob"] = two_q
            config["qpu"]["one_q_depolar_prob"] = one_q
            config["qpu"]["emission_fidelity"] = emission_fidelity
            config_path.write_text(yaml.safe_dump(config, sort_keys=False))

            if not raw_path.exists():
                staging_dir = output_dir / f"{tag}_staging"
                staging_dir.mkdir(exist_ok=True)
                command = [
                    manifest["python_executable"], "-m", "qnpack.dqc.sim",
                    "-p", str(config_path),
                    "-b", str(base_dir),
                    "-o", str(staging_dir),
                    "-n", str(num_runs),
                ]
                print(f"START {tag}", flush=True)
                with log_path.open("w") as log:
                    subprocess.run(
                        command,
                        cwd=base_dir.parent.parent,
                        stdout=log, stderr=subprocess.STDOUT,
                        check=True,
                    )
                produced = next(staging_dir.glob("*.csv"))
                shutil.move(str(produced), raw_path)
                staging_dir.rmdir()

            with raw_path.open(newline="") as f:
                reader = csv.DictReader(f)
                rows = list(reader)

            p1 = _p_center(rows)
            summary_rows.append({
                "circuit": circuit_label,
                "n_steps": manifest["n_steps"],
                "two_q_depolar_prob": two_q,
                "one_q_depolar_prob": one_q,
                "emission_fidelity": emission_fidelity,
                "entanglement_method": entanglement_method,
                "num_runs": num_runs,
                "p_center_1": round(p1, 6),
                "raw_csv": raw_path.name,
            })
            print(
                f"DONE {tag}: P(center=1)={p1:.4f} ({len(rows)} shots)",
                flush=True,
            )

    summary_path = output_dir / "plaq_gate_depol_sweep_n6_summary.csv"
    _write_csv(summary_path, list(summary_rows[0]), summary_rows)
    print(f"\nSummary written to {summary_path}")


if __name__ == "__main__":
    main()
