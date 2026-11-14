#!/usr/bin/env bash
# Queue all 32 init_photon_loss conditions one at a time.
#
#   Grover4 2QPU  × 8 initpl values  (500 runs each)  =  8 conditions
#   QAOA 9q 2QPU  × 8 initpl values  (200 runs each)  =  8 conditions
#   Plaquette 1d_2qpu × 8 initpl values (200 runs)    =  8 conditions
#   Plaquette 2d_2qpu × 8 initpl values (200 runs)    =  8 conditions
#
# All BSM. Resumable: re-run the script to skip completed conditions.
#
# Usage (from qnpack repo root):
#   bash qnpack/dqc/experiments/queue_initpl_sweeps.sh 2>&1 | tee sweep_log.txt
#
# initpl sweep values: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
# rate-index is 1-based: 1=0, 2=0.1, ..., 8=0.7

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"
cd "$REPO_ROOT"

TOTAL=32
N=0

initpl_values=(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7)

run_one() {
    local desc="$1"; shift
    N=$((N + 1))
    echo ""
    echo "[$N/$TOTAL] $(date '+%Y-%m-%d %H:%M:%S')  START  $desc"
    "$@"
    echo "[$N/$TOTAL] $(date '+%Y-%m-%d %H:%M:%S')  DONE   $desc"
}

echo "========================================"
echo "  init_photon_loss sweep — 32 conditions"
echo "  Started: $(date)"
echo "========================================"

# ── Grover4 2QPU (8 conditions, 500 runs each) ───────────────────────────────
GROVER_OUT="$REPO_ROOT/qnpack/dqc/results/grover4_bsm_ket_initphotonloss_sweep_20261113"
GROVER_MANIFEST="$REPO_ROOT/qnpack/dqc/experiments/grover4_initphotonloss_sweep.yml"

for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    run_one "Grover4 2QPU  initpl=${initpl}" \
        python -m qnpack.dqc.experiments.grover_channel_sweep \
            --manifest "$GROVER_MANIFEST" \
            --qpu-count 2 --rate-index "$idx" \
            --output-dir "$GROVER_OUT"
done

# ── QAOA 9q 2QPU BSM (8 conditions, 200 runs each) ───────────────────────────
for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    run_one "QAOA 9q 2QPU  initpl=${initpl}" \
        python -m qnpack.dqc.experiments.qaoa9_initphotonloss_sweep.run_sweep \
            --circuit-label 2qpu --rate-index "$idx"
done

# ── Plaquette 1d_2qpu BSM (8 conditions, 200 runs each) ──────────────────────
for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    run_one "Plaquette 1d_2qpu  initpl=${initpl}" \
        python -m qnpack.dqc.experiments.plaquette_initpl_sweep_20261113.run_sweep \
            --circuit-label 1d_2qpu --rate-index "$idx"
done

# ── Plaquette 2d_2qpu BSM (8 conditions, 200 runs each) ──────────────────────
for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    run_one "Plaquette 2d_2qpu  initpl=${initpl}" \
        python -m qnpack.dqc.experiments.plaquette_initpl_sweep_20261113.run_sweep \
            --circuit-label 2d_2qpu --rate-index "$idx"
done

echo ""
echo "========================================"
echo "  ALL 32 CONDITIONS COMPLETE"
echo "  Finished: $(date)"
echo "========================================"
