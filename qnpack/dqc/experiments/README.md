# File-driven Grover sweeps

From the repository root, with the package dependencies installed:

```sh
python -m qnpack.dqc.experiments.grover_sweep --manifest qnpack/dqc/experiments/grover4_sweep.yml
python -m qnpack.dqc.experiments.grover_sweep --manifest qnpack/dqc/experiments/grover12_sweep.yml
```

Each manifest explicitly provides the QASM files for 1, 2, and 3 QPUs, four paired gate-noise values, the target bitstring, run count, worker count, seed range, and output location. Paths in a manifest resolve relative to that manifest; QASM paths resolve relative to its `base_dir`. The runner uses the Python interpreter that launched it, so the files can be moved with the repository to another machine with a working qnpack/NetSquid installation.

`max_workers` controls the number of spawned simulator processes. Set it to a positive integer appropriate for the machine, or explicitly set it to `auto` to use the detected CPU count. `numerical_threads_per_worker` controls numerical-library threads inside each process. Each shot gets a distinct seed and a fresh process.

For a short check without changing a manifest's full output directory:

```sh
python -m qnpack.dqc.experiments.grover_sweep \
  --manifest qnpack/dqc/experiments/grover4_sweep.yml \
  --qpu-count 1 --noise-pair-index 1 --num-runs 2 --max-workers 2 \
  --output-dir ./grover-smoke-results
```

Each completed condition gets a named raw CSV, the exact effective parameters YAML, a log, and metadata containing the QASM/config hashes. The runner updates a summary CSV (`target_state_probability` is the fraction of shots matching the target) and an all-runs CSV after every completed condition. Rerunning the same manifest resumes from matching completed conditions and rejects stale results if the circuit or effective configuration changed. The result directories are ignored by Git; copy or explicitly add the CSVs you want to retain in version control.

The Grover 12 manifest uses the 3-QPU QASM variant with two communication qubits per QPU. The original 3-QPU file consumed substantially more memory during a KET pilot. The Grover 4 results already produced with 1,000 shots per point are stored separately under `qnpack/dqc/results/grover4_noise_sweep_20260928`.
