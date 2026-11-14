#!/usr/bin/env bash
# Run all three init_photon_loss sweeps sequentially.
# Each sweep's conditions run one at a time with timestamps.
# Resumable: conditions with existing CSVs are skipped automatically.
#
# Run from the qnpack repo root:
#   bash qnpack/dqc/experiments/run_all_initpl_sweeps.sh
#
# To run a single sweep, use the individual commands at the bottom of this script.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"
cd "$REPO_ROOT"

echo "============================================="
echo "  init_photon_loss sweep — all three circuits"
echo "  Repo root: $REPO_ROOT"
echo "  Started:   $(date)"
echo "============================================="
echo ""

# ── 1. Grover4 2 & 3 QPU, cisco/BSM/KET ─────────────────────────────────────
echo "[$(date '+%H:%M:%S')] ===== SWEEP 1/3: Grover4 (2QPU + 3QPU) ====="
python -m qnpack.dqc.experiments.grover_channel_sweep \
  --manifest qnpack/dqc/experiments/grover4_initphotonloss_sweep.yml
echo "[$(date '+%H:%M:%S')] ===== SWEEP 1/3 DONE: Grover4 ====="
echo ""

# ── 2. QAOA 9q 1QPU (magic) + 2QPU (BSM), tket/KET ─────────────────────────
echo "[$(date '+%H:%M:%S')] ===== SWEEP 2/3: QAOA 9q (1QPU + 2QPU) ====="
python -m qnpack.dqc.experiments.qaoa9_initphotonloss_sweep.run_sweep
echo "[$(date '+%H:%M:%S')] ===== SWEEP 2/3 DONE: QAOA 9q ====="
echo ""

# ── 3. Plaquette n=6, 1D + 2D, 1QPU (magic) + 2QPU (BSM), cisco_v2/KET ─────
echo "[$(date '+%H:%M:%S')] ===== SWEEP 3/3: Plaquette n=6 (4 circuits) ====="
python -m qnpack.dqc.experiments.plaquette_initpl_sweep_20261113.run_sweep
echo "[$(date '+%H:%M:%S')] ===== SWEEP 3/3 DONE: Plaquette n=6 ====="
echo ""

echo "============================================="
echo "  ALL SWEEPS COMPLETE"
echo "  Finished: $(date)"
echo "============================================="
