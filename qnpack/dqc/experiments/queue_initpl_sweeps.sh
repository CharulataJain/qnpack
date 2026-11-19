#!/usr/bin/env bash
# Queue all 32 init_photon_loss conditions one at a time.
#
#   Grover4 2QPU  × 8 initpl values  =  8 conditions
#   QAOA 9q 2QPU  × 8 initpl values  =  8 conditions
#   Plaquette 1d_2qpu × 8 initpl     =  8 conditions
#   Plaquette 2d_2qpu × 8 initpl     =  8 conditions
#
# Run counts taper at high initpl to keep wall time manageable:
#   initpl 0.0–0.2  (idx 1–3): full  runs (Grover=500, QAOA/Plaq=200)
#   initpl 0.3–0.4  (idx 4–5): half  runs (Grover=250, QAOA/Plaq=100)
#   initpl 0.5–0.7  (idx 6–8): quarter runs (Grover=125, QAOA/Plaq=50)
#
# All BSM. Resumable: re-run the script to skip completed conditions.
#
# Usage (from qnpack repo root):
#   bash qnpack/dqc/experiments/queue_initpl_sweeps.sh 2>&1 | tee sweep_log.txt
#
# initpl sweep values: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
# rate-index is 1-based: 1=0, 2=0.1, ..., 8=0.7

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"
cd "$REPO_ROOT"

TOTAL=32
N=0

initpl_values=(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7)

# grover_runs[idx-1] and qaoa_runs[idx-1] give num_runs for each rate index
grover_runs=(500 500 500 250 250 125 125 125)
qaoa_runs=(200 200 200 100 100  50  50  50)

FAILED=0

run_one() {
    local desc="$1"; shift
    N=$((N + 1))
    echo ""
    echo "[$N/$TOTAL] $(date '+%Y-%m-%d %H:%M:%S')  START  $desc"
    if "$@"; then
        echo "[$N/$TOTAL] $(date '+%Y-%m-%d %H:%M:%S')  DONE    $desc"
    else
        echo "[$N/$TOTAL] $(date '+%Y-%m-%d %H:%M:%S')  FAILED  $desc (exit $?)" >&2
        FAILED=$((FAILED + 1))
    fi
}

echo "========================================"
echo "  init_photon_loss sweep — 32 conditions"
echo "  Started: $(date)"
echo "========================================"

# ── Grover4 2QPU ─────────────────────────────────────────────────────────────
GROVER_OUT="$REPO_ROOT/qnpack/dqc/results/grover4_bsm_ket_initphotonloss_sweep_20261113"
GROVER_MANIFEST="$REPO_ROOT/qnpack/dqc/experiments/grover4_initphotonloss_sweep.yml"

for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    runs="${grover_runs[$((idx-1))]}"
    run_one "Grover4 2QPU  initpl=${initpl}  runs=${runs}" \
        python -m qnpack.dqc.experiments.grover_channel_sweep \
            --manifest "$GROVER_MANIFEST" \
            --num-runs "$runs" --qpu-count 2 --rate-index "$idx" \
            --output-dir "$GROVER_OUT"
done

# ── QAOA 9q 2QPU BSM ─────────────────────────────────────────────────────────
for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    runs="${qaoa_runs[$((idx-1))]}"
    run_one "QAOA 9q 2QPU  initpl=${initpl}  runs=${runs}" \
        python -m qnpack.dqc.experiments.qaoa9_initphotonloss_sweep.run_sweep \
            --circuit-label 2qpu --rate-index "$idx" --num-runs "$runs"
done

# ── Plaquette 1d_2qpu BSM ────────────────────────────────────────────────────
for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    runs="${qaoa_runs[$((idx-1))]}"
    run_one "Plaquette 1d_2qpu  initpl=${initpl}  runs=${runs}" \
        python -m qnpack.dqc.experiments.plaquette_initpl_sweep_20261113.run_sweep \
            --circuit-label 1d_2qpu --rate-index "$idx" --num-runs "$runs"
done

# ── Plaquette 2d_2qpu BSM ────────────────────────────────────────────────────
for idx in 1 2 3 4 5 6 7 8; do
    initpl="${initpl_values[$((idx-1))]}"
    runs="${qaoa_runs[$((idx-1))]}"
    run_one "Plaquette 2d_2qpu  initpl=${initpl}  runs=${runs}" \
        python -m qnpack.dqc.experiments.plaquette_initpl_sweep_20261113.run_sweep \
            --circuit-label 2d_2qpu --rate-index "$idx" --num-runs "$runs"
done

echo ""
echo "========================================"
if [ "$FAILED" -eq 0 ]; then
    echo "  ALL 32 CONDITIONS COMPLETE"
else
    echo "  DONE — $FAILED condition(s) FAILED (see FAILED lines above)"
fi
echo "  Finished: $(date)"
echo "========================================"
exit "$FAILED"
