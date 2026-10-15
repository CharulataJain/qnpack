#!/bin/bash
# Run 2D magic-mode sweep: 1QPU + 2QPU, ideal + noisy, n=0,2,4,6,8,10
# Target: 1000 runs each. If a CSV already exists with fewer rows, tops it up;
# if it already has >= 1000 rows, skips.
#
# Usage: bash experiments/run_2d_all_magic_1000.sh
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
set -euo pipefail

cd /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline.yml
OUT=$DQC/results/plaquette_sweep
N_STEPS=(0 2 4 6 8 10)
TARGET=1000

run_one () {
    local nqpu=$1 noise=$2 n=$3
    local tag outdir cfg qasm final_csv tmpdir

    qasm="qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n${n}.qasm"
    tag="${nqpu}qpu_2d_magic_${noise}_n${n}"
    outdir="$OUT/${nqpu}qpu_2d_magic_${noise}"
    final_csv="$outdir/${tag}.csv"
    cfg="/tmp/2d_magic_${tag}.yml"

    if [ ! -f "$DQC/$qasm" ]; then
        echo "MISSING $qasm — skipping"
        return
    fi

    mkdir -p "$outdir"

    # Determine how many runs are already in the final CSV
    existing_rows=0
    if [ -f "$final_csv" ]; then
        existing_rows=$(( $(wc -l < "$final_csv") - 1 ))
    fi

    if [ "$existing_rows" -ge "$TARGET" ]; then
        echo "SKIP $tag — already has $existing_rows rows (>= $TARGET)"
        return
    fi

    needed=$(( TARGET - existing_rows ))
    echo "=== $tag: existing=$existing_rows, running $needed more ==="

    python3 - "$BASE" "$cfg" "$qasm" "$noise" <<'PYEOF'
import sys, yaml
base_path, cfg_path, qasm_path, noise = sys.argv[1:5]
with open(base_path) as f:
    cfg = yaml.safe_load(f)
cfg["circuit"]["qasm_file"] = qasm_path
cfg["circuit"]["pre_schedule_entanglement"] = False
cfg["entanglement"]["method"] = "magic"
cfg["entanglement"]["magic_state_delay_ns"] = 0
cfg["bsm"]["deterministic_bsm"] = True
if noise == "noisy":
    cfg["qpu"]["two_q_depolar_prob"] = 1.0e-4
    cfg["qpu"]["one_q_depolar_prob"] = 1.0e-5
else:
    cfg["qpu"]["two_q_depolar_prob"] = 0
    cfg["qpu"]["one_q_depolar_prob"] = 0
with open(cfg_path, "w") as f:
    yaml.safe_dump(cfg, f, sort_keys=False)
PYEOF

    tmpdir="$outdir/tmp_n${n}"
    mkdir -p "$tmpdir"
    rm -f "$tmpdir"/*.csv

    python3 -m qnpack.dqc.sim \
        -p "$cfg" -b "$DQC" -o "$tmpdir" -n "$needed" \
        > "$outdir/${tag}.log" 2>&1

    new_csv=$(ls -t "$tmpdir"/*.csv 2>/dev/null | head -1)
    if [ -z "$new_csv" ]; then
        echo "ERROR: no CSV produced for $tag — check $outdir/${tag}.log"
        rm -rf "$tmpdir"
        return
    fi

    if [ -f "$final_csv" ]; then
        # Merge: offset run numbers in new batch
        echo "  merging into $final_csv"
        python3 - "$final_csv" "$new_csv" <<'PYEOF'
import sys
import pandas as pd
existing_path, new_path = sys.argv[1], sys.argv[2]
existing = pd.read_csv(existing_path)
new_df = pd.read_csv(new_path)
new_df["run"] = new_df["run"] + len(existing)
merged = pd.concat([existing, new_df], ignore_index=True)
merged.to_csv(existing_path, index=False)
print(f"  merged: {len(existing)} + {len(new_df)} = {len(merged)} rows")
PYEOF
    else
        mv "$new_csv" "$final_csv"
        echo "  saved $final_csv"
    fi

    rm -rf "$tmpdir"
    echo "DONE $tag"
}

for nqpu in 1 2; do
    for noise in ideal noisy; do
        for n in "${N_STEPS[@]}"; do
            run_one "$nqpu" "$noise" "$n"
        done
    done
done

echo ""
echo "ALL DONE — results in $OUT/{1,2}qpu_2d_magic_{ideal,noisy}/"
