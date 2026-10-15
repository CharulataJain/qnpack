#!/bin/bash
# Run only 2d ideal n6, n8, n10 with deterministic_bsm: true
set -euo pipefail

cd /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline_detbsm.yml
OUT=$DQC/results/plaquette_sweep_detbsm/2d_ideal
RUNS=500

mkdir -p "$OUT"

for n in 6 8 10; do
  qasm="qasm/plaquette_sweep/9qubit_2qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n${n}.qasm"
  tag="2d_ideal_n${n}"
  cfg="/Users/cjain/.claude/jobs/62cd9492/tmp/plaquette_detbsm_2d_ideal_n${n}.yml"

  if [ -f "$OUT/${tag}.csv" ]; then
    echo "SKIP $tag"
    continue
  fi

  /opt/anaconda3/envs/cisco/bin/python3 - "$BASE" "$cfg" "$qasm" <<'PYEOF'
import sys, yaml
base_path, cfg_path, qasm_path = sys.argv[1:4]
with open(base_path) as f:
    cfg = yaml.safe_load(f)
cfg["circuit"]["qasm_file"] = qasm_path
cfg["qpu"]["two_q_depolar_prob"] = 0
cfg["qpu"]["one_q_depolar_prob"] = 0
with open(cfg_path, "w") as f:
    yaml.safe_dump(cfg, f, sort_keys=False)
PYEOF

  echo "START $tag"
  /opt/anaconda3/envs/cisco/bin/python3 -m qnpack.dqc.sim \
    -p "$cfg" -b "$DQC" -o "$OUT" -n "$RUNS" \
    > "$OUT/${tag}.log" 2>&1
  produced=$(ls -t "$OUT"/*.csv 2>/dev/null | head -1)
  [ -n "$produced" ] && mv "$produced" "$OUT/${tag}.csv"
  echo "DONE $tag"
done

echo "ALL DONE"
