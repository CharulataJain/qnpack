#!/usr/bin/env bash
# Smoke test for all three init_photon_loss sweeps.
# Runs 2 shots of one BSM condition per sweep (initpl=0.3, rate-index 4).
# Each should complete in under 5 minutes; a hang indicates BSM clock regression.
#
# Run from the qnpack repo root:
#   bash qnpack/dqc/experiments/smoke_test_initpl_sweeps.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"
DQC="$REPO_ROOT/qnpack/dqc"
EXPERIMENTS="$DQC/experiments"

echo "=== Smoke test: init_photon_loss sweeps ==="
echo "Repo root: $REPO_ROOT"
echo ""

# ── 1. Grover4 2QPU, initpl=0.3 (rate-index 4), 2 runs ─────────────────────
echo "--- [1/3] Grover4 2QPU BSM, initpl=0.3 ---"
(
  cd "$REPO_ROOT"
  python -m qnpack.dqc.experiments.grover_channel_sweep \
    --manifest "$EXPERIMENTS/grover4_initphotonloss_sweep.yml" \
    --num-runs 2 \
    --qpu-count 2 \
    --rate-index 4 \
    --output-dir /tmp/smoke_grover4_initpl
)
echo "PASS: Grover4 smoke test completed"
echo ""

# ── 2. QAOA 9q 2QPU BSM, initpl=0.3 (rate-index 4), 2 runs ─────────────────
echo "--- [2/3] QAOA 9q 2QPU BSM, initpl=0.3 ---"
(
  cd "$REPO_ROOT"
  python -m qnpack.dqc.experiments.qaoa9_initphotonloss_sweep.run_sweep \
    --num-runs 2 \
    --circuit-label 2qpu \
    --rate-index 4
)
echo "PASS: QAOA 9q smoke test completed"
echo ""

# ── 3. Plaquette 1d_2qpu BSM, initpl=0.3 (rate-index 4), 2 runs ─────────────
echo "--- [3/3] Plaquette 1d_2qpu BSM, initpl=0.3 ---"
(
  cd "$REPO_ROOT"
  python -m qnpack.dqc.experiments.plaquette_initpl_sweep_20261113.run_sweep \
    --num-runs 2 \
    --circuit-label 1d_2qpu \
    --rate-index 4
)
echo "PASS: Plaquette smoke test completed"
echo ""

echo "=== All smoke tests passed — no BSM hang detected ==="
