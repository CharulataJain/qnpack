#!/bin/bash
# Re-run 2QPU plaquette sweep with deterministic_bsm: true
set -euo pipefail

cd /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline_detbsm.yml
OUT=$DQC/results/plaquette_sweep_detbsm
N_STEPS=(0 2 4 6 8 10)
RUNS=500

mkdir -p "$OUT"

run_one () {
  local lattice=$1 noise=$2 n=$3
  local tag qasm cfg outdir
  if [ "$lattice" = "1d" ]; then
    qasm="qasm/plaquette_sweep/9qubit_2qpu_plaq121_obc_L9_g1.000_dt0.1000_n${n}.qasm"
  else
    qasm="qasm/plaquette_sweep/9qubit_2qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n${n}.qasm"
  fi
  tag="${lattice}_${noise}_n${n}"
  outdir="$OUT/${lattice}_${noise}"
  mkdir -p "$outdir"
  cfg="/tmp/plaquette_detbsm_cfg_${tag}.yml"

  /opt/anaconda3/envs/cisco/bin/python3 - "$BASE" "$cfg" "$qasm" "$noise" <<'PYEOF'
import sys, yaml
base_path, cfg_path, qasm_path, noise = sys.argv[1:5]
with open(base_path) as f:
    cfg = yaml.safe_load(f)
cfg["circuit"]["qasm_file"] = qasm_path
if noise == "noisy":
    cfg["qpu"]["two_q_depolar_prob"] = 1.0e-4
    cfg["qpu"]["one_q_depolar_prob"] = 1.0e-5
else:
    cfg["qpu"]["two_q_depolar_prob"] = 0
    cfg["qpu"]["one_q_depolar_prob"] = 0
with open(cfg_path, "w") as f:
    yaml.safe_dump(cfg, f, sort_keys=False)
PYEOF

  if ls "$outdir"/*"${tag}"*.csv >/dev/null 2>&1; then
    echo "SKIP $tag"
    return
  fi

  echo "START $tag"
  /opt/anaconda3/envs/cisco/bin/python3 -m qnpack.dqc.sim -p "$cfg" -b "$DQC" -o "$outdir" -n "$RUNS" \
    > "$outdir/${tag}.log" 2>&1
  produced=$(ls -t "$outdir"/*.csv 2>/dev/null | head -1)
  if [ -n "$produced" ]; then
    mv "$produced" "$outdir/${tag}.csv"
  fi
  echo "DONE $tag"
}

for lattice in 1d 2d; do
  for noise in ideal noisy; do
    for n in "${N_STEPS[@]}"; do
      run_one "$lattice" "$noise" "$n"
    done
  done
done

echo "ALL DONE"
