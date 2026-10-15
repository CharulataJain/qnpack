#!/bin/bash
# Run 2QPU magic-mode sweep: ideal + noisy, 1D lattice, n=0,2,4,5,6,8,10
# Usage: bash experiments/run_2qpu_magic_sweep.sh [RUNS]
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
set -euo pipefail

cd /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline.yml
OUT=$DQC/results/plaquette_sweep
N_STEPS=(0 2 4 5 6 8 10)
RUNS=${1:-500}

run_one () {
    local noise=$1 n=$2
    local tag outdir cfg
    qasm="qasm/plaquette_sweep/9qubit_2qpu_plaq121_obc_L9_g1.000_dt0.1000_n${n}.qasm"
    tag="2qpu_1d_magic_${noise}_n${n}"
    outdir="$OUT/2qpu_1d_magic_${noise}"
    cfg="/tmp/plaquette_magic_${noise}_n${n}.yml"

    mkdir -p "$outdir"

    if ls "$outdir"/*"n${n}"*.csv >/dev/null 2>&1; then
        echo "SKIP $tag (CSV exists)"
        return
    fi

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

    echo "START $tag -> $outdir"
    python3 -m qnpack.dqc.sim \
        -p "$cfg" -b "$DQC" -o "$outdir" -n "$RUNS" \
        > "$outdir/${tag}.log" 2>&1

    produced=$(ls -t "$outdir"/*.csv 2>/dev/null | head -1)
    if [ -n "$produced" ]; then
        mv "$produced" "$outdir/${tag}.csv"
    fi
    echo "DONE $tag"
}

for noise in ideal noisy; do
    for n in "${N_STEPS[@]}"; do
        run_one "$noise" "$n"
    done
done

echo "ALL DONE — results in $OUT/2qpu_1d_magic_{ideal,noisy}/"
