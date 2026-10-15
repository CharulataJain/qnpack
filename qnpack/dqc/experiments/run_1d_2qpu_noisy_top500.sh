#!/bin/bash
# Top-up 2QPU 1D magic noisy for n=6,8,10 to 1000 total runs.
# Existing CSVs already have 500 runs. This script:
#   1. Runs 500 new shots into a temp dir
#   2. Merges (offsetting run numbers) with the existing CSV
#   3. Writes the merged 1000-run CSV back to the canonical location
#
# Usage: bash experiments/run_1d_2qpu_noisy_top500.sh
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline.yml
OUT=$DQC/results/plaquette_sweep/2qpu_1d_magic_noisy
TMPOUT=$DQC/results/plaquette_sweep/2qpu_1d_magic_noisy_tmp
RUNS=500

mkdir -p "$TMPOUT"

for n in 6 8 10; do
    existing="$OUT/2qpu_1d_magic_noisy_n${n}.csv"
    qasm="qasm/plaquette_sweep/9qubit_2qpu_plaq121_obc_L9_g1.000_dt0.1000_n${n}.qasm"
    tag="2qpu_1d_magic_noisy_n${n}"
    cfg="/tmp/topup_1d_noisy_n${n}.yml"

    if [ ! -f "$DQC/$qasm" ]; then
        echo "MISSING $qasm — skipping n=$n"
        continue
    fi
    if [ ! -f "$existing" ]; then
        echo "MISSING existing CSV $existing — skipping n=$n"
        continue
    fi

    existing_rows=$(( $(wc -l < "$existing") - 1 ))
    if [ "$existing_rows" -ge 1000 ]; then
        echo "SKIP n=$n — already has $existing_rows rows (>= 1000)"
        continue
    fi

    echo "=== n=$n: existing=$existing_rows rows, running $RUNS more ==="

    python3 - "$BASE" "$cfg" "$qasm" <<'PYEOF'
import sys, yaml
base_path, cfg_path, qasm_path = sys.argv[1:4]
with open(base_path) as f:
    cfg = yaml.safe_load(f)
cfg["circuit"]["qasm_file"] = qasm_path
cfg["circuit"]["pre_schedule_entanglement"] = False
cfg["entanglement"]["method"] = "magic"
cfg["entanglement"]["magic_state_delay_ns"] = 0
cfg["bsm"]["deterministic_bsm"] = True
cfg["qpu"]["two_q_depolar_prob"] = 1.0e-4
cfg["qpu"]["one_q_depolar_prob"] = 1.0e-5
with open(cfg_path, "w") as f:
    yaml.safe_dump(cfg, f, sort_keys=False)
PYEOF

    # Clear tmp dir of any old CSVs for this n
    rm -f "$TMPOUT"/*"n${n}"*.csv

    python3 -m qnpack.dqc.sim \
        -p "$cfg" -b "$DQC" -o "$TMPOUT" -n "$RUNS" \
        > "$TMPOUT/${tag}_topup.log" 2>&1

    new_csv=$(ls -t "$TMPOUT"/*.csv 2>/dev/null | head -1)
    if [ -z "$new_csv" ]; then
        echo "ERROR: no CSV produced for n=$n — check $TMPOUT/${tag}_topup.log"
        continue
    fi

    echo "  merging $existing + $new_csv -> $existing"
    python3 - "$existing" "$new_csv" <<'PYEOF'
import sys
import pandas as pd
existing_path, new_path = sys.argv[1], sys.argv[2]
existing = pd.read_csv(existing_path)
new_df = pd.read_csv(new_path)
new_df["run"] = new_df["run"] + len(existing)
merged = pd.concat([existing, new_df], ignore_index=True)
merged.to_csv(existing_path, index=False)
print(f"  merged: {len(existing)} + {len(new_df)} = {len(merged)} rows -> {existing_path}")
PYEOF

    echo "DONE n=$n"
done

rm -rf "$TMPOUT"
echo ""
echo "ALL DONE — merged CSVs in $OUT/"
