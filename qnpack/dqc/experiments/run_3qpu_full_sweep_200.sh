#!/bin/bash
# 3QPU full sweep: 1D + 2D, ideal + noisy, n=0,2,4,6,8,10,15,20, 200 runs each
#
# Usage: bash qnpack/dqc/experiments/run_3qpu_full_sweep_200.sh
# Run from: /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
set -euo pipefail

cd /Users/cjain/Documents/Repositories/charu-qnpack/qnpack
DQC=qnpack/dqc
BASE=$DQC/experiments/plaquette_baseline.yml
OUT=$DQC/results/plaquette_sweep

mkdir -p "$OUT"

qasm_path () {
    local nqpu=$1 lattice=$2 n=$3
    if [ "$lattice" = "1d" ]; then
        echo "qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq121_obc_L9_g1.000_dt0.1000_n${n}.qasm"
    else
        echo "qasm/plaquette_sweep/9qubit_${nqpu}qpu_plaq2d121_obc_Lx3_Ly3_g1.000_dt0.1000_n${n}.qasm"
    fi
}

make_cfg () {
    local base_path=$1 cfg_path=$2 qasm=$3 noise=$4 nqpu=$5
    python3 - "$base_path" "$cfg_path" "$qasm" "$noise" "$nqpu" <<'PYEOF'
import sys, yaml
base_path, cfg_path, qasm_path, noise, nqpu = sys.argv[1:6]
with open(base_path) as f:
    cfg = yaml.safe_load(f)
cfg["circuit"]["qasm_file"] = qasm_path
cfg["circuit"]["pre_schedule_entanglement"] = False
cfg["entanglement"]["method"] = "magic"
cfg["entanglement"]["magic_state_delay_ns"] = 0
cfg["bsm"]["deterministic_bsm"] = True
cfg["qpu"]["num_qpu_nodes"] = int(nqpu)
if noise == "noisy":
    cfg["qpu"]["two_q_depolar_prob"] = 1.0e-4
    cfg["qpu"]["one_q_depolar_prob"] = 1.0e-5
else:
    cfg["qpu"]["two_q_depolar_prob"] = 0
    cfg["qpu"]["one_q_depolar_prob"] = 0
with open(cfg_path, "w") as f:
    yaml.safe_dump(cfg, f, sort_keys=False)
PYEOF
}

run_one () {
    local nqpu=$1 lattice=$2 noise=$3 n=$4 runs=$5
    local qasm tag outdir final_csv cfg tmpdir

    qasm=$(qasm_path "$nqpu" "$lattice" "$n")
    tag="${nqpu}qpu_${lattice}_magic_${noise}_n${n}"
    outdir="$OUT/${nqpu}qpu_${lattice}_magic_${noise}"
    final_csv="$outdir/${tag}.csv"
    cfg="/tmp/sim_${tag}.yml"

    if [ ! -f "$DQC/$qasm" ]; then
        echo "MISSING $qasm — skipping $tag"
        return
    fi

    mkdir -p "$outdir"

    existing_rows=0
    if [ -f "$final_csv" ]; then
        existing_rows=$(( $(wc -l < "$final_csv") - 1 ))
    fi
    if [ "$existing_rows" -ge "$runs" ]; then
        echo "SKIP $tag — already has $existing_rows rows (>= $runs)"
        return
    fi

    needed=$(( runs - existing_rows ))
    echo ""
    echo ">>> START $tag | runs=$needed (have=$existing_rows, target=$runs)"

    make_cfg "$BASE" "$cfg" "$qasm" "$noise" "$nqpu"

    tmpdir="$outdir/tmp_n${n}"
    mkdir -p "$tmpdir"
    rm -f "$tmpdir"/*.csv

    conda run -n cisco python3 -m qnpack.dqc.sim \
        -p "$cfg" -b "$DQC" -o "$tmpdir" -n "$needed" \
        > "$outdir/${tag}.log" 2>&1

    new_csv=$(ls -t "$tmpdir"/*.csv 2>/dev/null | head -1)
    if [ -z "$new_csv" ]; then
        echo "ERROR: no CSV for $tag — see $outdir/${tag}.log"
        rm -rf "$tmpdir"
        return
    fi

    if [ -f "$final_csv" ]; then
        python3 - "$final_csv" "$new_csv" <<'PYEOF'
import sys, pandas as pd
ep, np_ = sys.argv[1], sys.argv[2]
e = pd.read_csv(ep); n = pd.read_csv(np_)
n["run"] = n["run"] + len(e)
m = pd.concat([e, n], ignore_index=True)
m.to_csv(ep, index=False)
print(f"  merged: {len(e)} + {len(n)} = {len(m)} rows -> {ep}")
PYEOF
    else
        mv "$new_csv" "$final_csv"
        rows=$(( $(wc -l < "$final_csv") - 1 ))
        echo "  saved $final_csv ($rows rows)"
    fi

    rm -rf "$tmpdir"
    echo "<<< DONE $tag"
}

echo "============================================================"
echo " 3QPU full sweep — 1D + 2D, ideal + noisy"
echo " n = 0, 2, 4, 6, 8, 10, 15, 20 — 200 runs each"
echo "============================================================"

for n in 0 2 4 6 8 10 15 20; do
    for lattice in 1d 2d; do
        for noise in ideal noisy; do
            run_one 3 "$lattice" "$noise" "$n" 200
        done
    done
done

echo ""
echo "Done — 3QPU full sweep complete."
