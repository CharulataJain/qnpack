#!/bin/bash
# Extended magic-mode sweep: 1QPU + 2QPU, 1D + 2D.
#
# 2D:  n=0,2,4 @ 500 shots  +  n=6,8,10 @ 1000 shots  — ideal & noisy
# 1D:  n=6,8,10 @ 1000 shots                            — ideal & noisy
#
# Usage: bash experiments/run_extended_magic_sweep.sh
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
set -euo pipefail

cd /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline.yml
OUT=$DQC/results/plaquette_sweep

mkdir -p "$OUT"

run_one () {
    local nqpu=$1 lattice=$2 noise=$3 n=$4 runs=$5
    local tag outdir cfg qasm

    if [ "$lattice" = "1d" ]; then
        qasm="qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq121_obc_L9_g1.000_dt0.1000_n${n}.qasm"
    else
        qasm="qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n${n}.qasm"
    fi

    if [ ! -f "$DQC/$qasm" ]; then
        echo "MISSING $qasm — skipping"
        return
    fi

    tag="${nqpu}qpu_${lattice}_magic_${noise}_n${n}"
    outdir="$OUT/${nqpu}qpu_${lattice}_magic_${noise}"
    cfg="/tmp/ext_magic_${tag}.yml"

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
    cfg["qpu"]["one_q_depolar_prob"] = 1.0e-5
    cfg["qpu"]["two_q_depolar_prob"] = 1.0e-4
else:
    cfg["qpu"]["one_q_depolar_prob"] = 0
    cfg["qpu"]["two_q_depolar_prob"] = 0
with open(cfg_path, "w") as f:
    yaml.safe_dump(cfg, f, sort_keys=False)
PYEOF

    echo "START $tag ($runs shots) -> $outdir"
    conda run -n cisco python3 -m qnpack.dqc.sim \
        -p "$cfg" -b "$DQC" -o "$outdir" -n "$runs" \
        > "$outdir/${tag}.log" 2>&1

    produced=$(ls -t "$outdir"/*.csv 2>/dev/null | head -1)
    if [ -n "$produced" ]; then
        mv "$produced" "$outdir/${tag}.csv"
    fi
    echo "DONE $tag"
}

# ── 2D: 500 shots for n=0,2,4 ──────────────────────────────────────────────
for nqpu in 1 2; do
    for noise in ideal noisy; do
        for n in 0 2 4; do
            run_one "$nqpu" 2d "$noise" "$n" 500
        done
    done
done

# ── 2D: 1000 shots for n=6,8,10 ────────────────────────────────────────────
for nqpu in 1 2; do
    for noise in ideal noisy; do
        for n in 6 8 10; do
            run_one "$nqpu" 2d "$noise" "$n" 1000
        done
    done
done

# ── 1D: 1000 shots for n=6,8,10 ────────────────────────────────────────────
for nqpu in 1 2; do
    for noise in ideal noisy; do
        for n in 6 8 10; do
            run_one "$nqpu" 1d "$noise" "$n" 1000
        done
    done
done

echo ""
echo "ALL DONE — results in $OUT/{1,2}qpu_{1d,2d}_magic_{ideal,noisy}/"
