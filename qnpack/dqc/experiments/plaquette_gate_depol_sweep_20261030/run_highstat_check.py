"""High-statistics check: 2000 shots on 1D 1QPU at 3 depol levels.

Confirms gate depol has no measurable effect at p2<=1e-4 vs p2=1e-3.
Fastest possible check: smallest circuit (1D 1QPU, n=6), magic mode.

Usage:
    python -m qnpack.dqc.experiments.plaquette_gate_depol_sweep_20261030.run_highstat_check
"""

import csv
import shutil
import subprocess
import numpy as np
from pathlib import Path

import yaml

CENTER_COL = "meas_4"
NUM_RUNS = 2000
QASM = "qasm/plaquette_sweep/9qubit_1qpu_plaq121_obc_L9_g1.000_dt0.1000_n6.qasm"
CHECK_PAIRS = [
    (0.0,    0.0),     # ideal
    (1e-4,   1e-5),    # existing "noisy" baseline — should match ideal
    (1e-3,   1e-4),    # borderline — should start to deviate
]

manifest_path = Path(__file__).with_name("manifest.yml")
manifest = yaml.safe_load(manifest_path.read_text())
base_dir = Path(manifest["base_dir"])
source_cfg = yaml.safe_load(Path(manifest["source_parameters"]).read_text())

output_dir = Path(manifest["output_dir"]) / "highstat_check"
output_dir.mkdir(parents=True, exist_ok=True)

qasm_path = (base_dir / QASM).resolve()
results = []

for two_q, one_q in CHECK_PAIRS:
    tag = f"highstat_1d_1qpu_n6_2q{two_q:.0e}_1q{one_q:.0e}_{NUM_RUNS}runs"
    raw_path = output_dir / f"{tag}.csv"
    config_path = output_dir / f"{tag}.yml"
    log_path = output_dir / f"{tag}.log"

    config = yaml.safe_load(yaml.safe_dump(source_cfg))
    config["sim"]["iterations"] = NUM_RUNS
    config["sim"]["max_workers"] = manifest["max_workers"]
    config["sim"].pop("starting_seed", None)
    config["circuit"]["mode"] = manifest["circuit_mode"]
    config["circuit"]["qasm_file"] = str(qasm_path)
    config["entanglement"]["method"] = manifest["entanglement_method"]
    config["qpu"]["two_q_depolar_prob"] = two_q
    config["qpu"]["one_q_depolar_prob"] = one_q
    config["qpu"]["emission_fidelity"] = manifest["emission_fidelity"]
    config_path.write_text(yaml.safe_dump(config, sort_keys=False))

    if not raw_path.exists():
        staging_dir = output_dir / f"{tag}_staging"
        staging_dir.mkdir(exist_ok=True)
        cmd = [
            manifest["python_executable"], "-m", "qnpack.dqc.sim",
            "-p", str(config_path),
            "-b", str(base_dir),
            "-o", str(staging_dir),
            "-n", str(NUM_RUNS),
        ]
        print(f"START {tag}", flush=True)
        with log_path.open("w") as log:
            subprocess.run(cmd, cwd=base_dir.parent.parent,
                           stdout=log, stderr=subprocess.STDOUT, check=True)
        produced = next(staging_dir.glob("*.csv"))
        shutil.move(str(produced), raw_path)
        staging_dir.rmdir()

    rows = list(csv.DictReader(raw_path.open()))
    vals = [int(r[CENTER_COL]) for r in rows if r.get(CENTER_COL, "").strip() != ""]
    p = np.mean(vals)
    err = np.sqrt(p * (1 - p) / len(vals))
    results.append((two_q, p, err, len(vals)))
    print(f"  p2={two_q:.0e}: P(center=1)={p:.4f} ± {err:.4f}  ({len(vals)} shots)", flush=True)

# Summary
print("\n=== High-stat check summary (1D 1QPU, n=6, 2000 shots) ===")
p_ideal = results[0][1]
for two_q, p, err, n in results:
    delta = p - p_ideal
    sigma = abs(delta) / err if err > 0 else 0
    label = "IDEAL" if two_q == 0 else f"p2={two_q:.0e}"
    print(f"  {label:14s}: P={p:.4f}±{err:.4f}  Δ={delta:+.4f}  ({sigma:.1f}σ from ideal)")
