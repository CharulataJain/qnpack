#!/bin/bash
# 12-qubit Grover — magic entanglement, gate depolarization only
# 1QPU + 2QPU + 3QPU, 100 runs each, multiprocessing (auto workers)
#
# Usage: bash qnpack/dqc/experiments/run_grover12_magic_gate_noise.sh
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

MANIFEST=qnpack/dqc/experiments/grover12_magic_gate_noise_100runs.yml

echo "============================================================"
echo " 12-qubit Grover — magic entanglement, gate depol only"
echo " 1QPU + 2QPU + 3QPU, 100 runs, max_workers=auto"
echo "============================================================"

python3 -m qnpack.dqc.experiments.grover_sweep --manifest "$MANIFEST"

echo ""
echo "Done."
