#!/bin/bash
# Run magic-mode sweep: 1QPU vs 3QPU, 1D and 2D, ideal and noisy, n=1,3,6.
# Ideal 1QPU results should match ideal 3QPU to validate the partition/compile.
#
# Usage: bash experiments/run_3qpu_magic_sweep.sh [RUNS]
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline.yml
OUT=$DQC/results/plaquette_sweep
N_STEPS=(2 4 6)
RUNS=${1:-500}

mkdir -p "$OUT"

run_one () {
    local nqpu=$1 lattice=$2 noise=$3 n=$4
    local tag outdir cfg qasm

    if [ "$lattice" = "1d" ]; then
        qasm="qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq121_obc_L9_g1.000_dt0.1000_n${n}.qasm"
    else
        qasm="qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n${n}.qasm"
    fi

    tag="${nqpu}qpu_${lattice}_magic_${noise}_n${n}"
    outdir="$OUT/${nqpu}qpu_${lattice}_magic_${noise}"
    cfg="/tmp/plaquette_magic_${tag}.yml"

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

# Run 3QPU ideal first so we can compare with existing 1QPU ideal results.
for lattice in 1d 2d; do
    for n in "${N_STEPS[@]}"; do
        run_one 3 "$lattice" ideal "$n"
    done
done

# Noisy runs.
for lattice in 1d 2d; do
    for n in "${N_STEPS[@]}"; do
        run_one 3 "$lattice" noisy "$n"
    done
done

echo ""
echo "ALL DONE — results in $OUT/3qpu_{1d,2d}_magic_{ideal,noisy}/"
echo ""
echo "Ideal match check — top bitstring: 1QPU (existing BSM) vs 3QPU (magic):"
for lattice in 1d 2d; do
    for n in "${N_STEPS[@]}"; do
        echo "--- ${lattice} n=${n} ---"
        csv_1=$(ls -t "$OUT/1qpu_${lattice}_ideal"/*"n${n}"*.csv 2>/dev/null | head -1 || true)
        csv_3=$(ls -t "$OUT/3qpu_${lattice}_magic_ideal"/*"n${n}"*.csv 2>/dev/null | head -1 || true)
        if [ -n "$csv_1" ]; then
            echo "  1QPU: $(head -2 "$csv_1" | tail -1)"
        else
            echo "  1QPU: (no CSV)"
        fi
        if [ -n "$csv_3" ]; then
            echo "  3QPU: $(head -2 "$csv_3" | tail -1)"
        else
            echo "  3QPU: (no CSV)"
        fi
    done
done
