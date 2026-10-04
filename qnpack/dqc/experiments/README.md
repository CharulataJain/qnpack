# File-driven Grover sweeps

Two runners, distinguished by what they vary and how entanglement is produced:

| Runner | Varies | Entanglement | Manifests |
|---|---|---|---|
| `grover_sweep` | gate depolarization pairs | `magic` | `grover4_sweep.yml`, `grover12_sweep.yml` |
| `grover_channel_sweep` | `channel.fiber_depolar_rate` | `bsm` (KET) | `grover4_channel_sweep.yml`, `grover12_channel_sweep.yml` |

Both are run from the repository root with the package dependencies installed:

```sh
python -m qnpack.dqc.experiments.grover_sweep --manifest qnpack/dqc/experiments/grover4_sweep.yml
python -m qnpack.dqc.experiments.grover_channel_sweep --manifest qnpack/dqc/experiments/grover4_channel_sweep.yml
```

Each manifest explicitly provides the QASM files for 1, 2, and 3 QPUs, the sweep values, the target bitstring, run count, worker count, and output location. Paths in a manifest resolve relative to that manifest; QASM paths resolve relative to its `base_dir`. The runner uses the Python interpreter that launched it, so the files can be moved with the repository to another machine with a working qnpack/NetSquid installation.

`max_workers` controls the number of spawned simulator processes. Set it to a positive integer appropriate for the machine, or explicitly set it to `auto` to use the detected CPU count. `numerical_threads_per_worker` controls numerical-library threads inside each process. Each shot gets fresh random state from the system and a fresh process. The output records a hash of each initial NetSquid random state to detect accidental reuse.

For a short check without changing a manifest's full output directory:

```sh
python -m qnpack.dqc.experiments.grover_sweep \
  --manifest qnpack/dqc/experiments/grover4_sweep.yml \
  --qpu-count 1 --noise-pair-index 1 --num-runs 2 --max-workers 2 \
  --output-dir ./grover-smoke-results
```

Each completed condition gets a named raw CSV, the exact effective parameters YAML, a log, and metadata containing the QASM/config hashes. The runner updates a summary CSV (`target_state_probability` is the fraction of shots matching the target) and an all-runs CSV after every completed condition. Rerunning the same manifest resumes from matching completed conditions and rejects stale results if the circuit or effective configuration changed. The result directories are ignored by Git; copy or explicitly add the CSVs you want to retain in version control.

The Grover 12 manifest uses the 3-QPU QASM variant with two communication qubits per QPU. The original 3-QPU file consumed substantially more memory during a KET pilot.

## What is kept under `results/`

The result directories have been pruned to **combined CSVs and plots only**. Each surviving directory holds its `*_all_runs.csv` (every shot), its `*_target_<bitstring>_summary.csv` (one row per condition), and the PNGs. The per-condition CSV/YAML/JSON/log files, the `batch*` subdirectories, and the cache directories were deleted on 2026-10-04 to reclaim space.

Two consequences worth knowing before you build on these:

- **The `raw_csv` column in each summary is now a dangling reference.** It names the per-condition file a row came from; those files no longer exist. The data itself is intact in `*_all_runs.csv`, keyed by `qpu_count` and `sweep_index`.
- **`grover_channel_merge` cannot extend these directories.** It reads each condition's `*.json` metadata to prove the runs share one configuration, and that metadata is gone. To merge a new sweep against one of these, rerun the old conditions, or merge the raw CSVs by hand and accept that nothing verifies the configurations match.

Current directories:

| Directory | Sweep |
|---|---|
| `grover4_noise_sweep_20260928` | gate depolarization, magic, 1000 shots/point |
| `grover4_bsm_ket_fiberdepolar_sweep_20261001` | fiber depolarization 0 → 0.1, 15 rates × 3 QPU, 500 shots/point |
| `grover4_bsm_ket_fiberdepolar_sweep_onlygatedepolar` | fiber depolarization, gate noise only |
| `grover4_bsm_ket_photonloss0p1_onlygatedepolar` | photon loss 0.1, merged from five 100-shot batches |

## Sweeps whose runner lives with its results

`grover4_gate_sweep_20260928/` holds the standalone runner for the Grover 4 gate-depolarization sweep, kept out of `results/` so pruning cannot remove it:

```sh
cd qnpack/dqc/experiments/grover4_gate_sweep_20260928
python run_sweep.py      # resumes; skips conditions whose CSV already exists
python plot_gate_noise.py
```

`run_sweep.py` reads its own `manifest.yml`, which carries absolute paths — edit `output_dir`, `base_dir`, `source_parameters`, and `python_executable` before running it on another machine. It predates the `grover_sweep` runner and has no `--qpu-count` filter, so it runs all three QPU counts in one process.

`plot_gate_noise.py` reads the summary CSV from `results/grover4_noise_sweep_20260928` and writes `grover4_cisco_magic_target_1011_vs_gate_noise.png` beside it, on a log x-axis. It checks that every (QPU, noise-pair) condition appears exactly once and that the one-qubit rate really is the two-qubit rate over ten before drawing.

Across all four decades tested (two-qubit 1e-7 → 1e-4), Grover 4 stays flat at 0.951–0.974 for every QPU count — within sampling noise of a single value at 1000 shots. Unlike Grover 12, the 4-qubit circuit is too shallow for gate depolarization at these rates to register.

---

## Running a channel sweep per QPU count on a server

A whole manifest in one process runs every QPU count back to back. On a server you usually want them as three independent jobs: they are fully independent, a crash costs you one job instead of all three, and 1 QPU finishes in a fraction of the time of 3 QPU. Split with `--qpu-count`, giving **each job its own output directory**:

```sh
cd /path/to/charu-qnpack/qnpack

for N in 1 2 3; do
  nohup python -m qnpack.dqc.experiments.grover_channel_sweep \
    --manifest qnpack/dqc/experiments/grover4_channel_sweep.yml \
    --qpu-count "$N" \
    --max-workers 16 \
    --output-dir /data/grover4_fiber/qpu"$N" \
    > /data/grover4_fiber/qpu"$N".out 2>&1 &
done
wait
```

Under a scheduler, submit the same command three times as an array job — with Slurm, `--array=1-3` and `--qpu-count $SLURM_ARRAY_TASK_ID`, setting `--max-workers` to the cores you requested per task.

Three rules that matter:

- **One output directory per job.** Two concurrent jobs sharing a directory will both rewrite `*_summary.csv` and `*_all_runs.csv` from only their own conditions, and the last writer wins. The per-condition CSVs survive, but the roll-ups silently become wrong.
- **`--output-dir` is mandatory** whenever you pass `--qpu-count`, `--rate-index`, `--num-runs`, or `--max-workers`. The runner enforces this so a filtered run can never overwrite a full sweep's directory.
- **`--max-workers` is per job.** Three concurrent jobs at `--max-workers 16` want 48 cores. Size it as `cores / concurrent_jobs`, and keep `numerical_threads_per_worker: 1` so each worker stays single-threaded.

### Resuming

Rerun the exact same command. Completed conditions print `RESUME` and are reused; only missing ones are simulated. The runner compares the stored `*.json` metadata against the configuration it would use now and **aborts** if they disagree, so an interrupted job is safe to restart but an edited manifest will not silently blend into old results.

To rerun a single point, delete both its `.csv` and `.json` (they must be removed together — the runner rejects either one existing alone) and rerun, or target it directly:

```sh
python -m qnpack.dqc.experiments.grover_channel_sweep \
  --manifest qnpack/dqc/experiments/grover4_channel_sweep.yml \
  --qpu-count 2 --rate-index 7 --output-dir /data/grover4_fiber/qpu2
```

`--rate-index` is **one-based** into the manifest's `fiber_depolar_rates` list, in the order written there.

## When and how to merge

Merge once **every** QPU count has finished every rate. The merge is a pure read-and-concatenate of finished output — it never simulates, so running it early just fails; it does not produce a partial result you might mistake for a complete one.

```sh
python -m qnpack.dqc.experiments.grover_channel_merge \
  --manifest qnpack/dqc/experiments/grover4_channel_sweep.yml \
  --source /data/grover4_fiber/qpu1 \
  --source /data/grover4_fiber/qpu2 \
  --source /data/grover4_fiber/qpu3
```

It writes `<algorithm>_cisco_bsm_ket_target_<target>_summary.csv` and `<algorithm>_cisco_bsm_ket_all_runs.csv` into the manifest's `output_dir` (override with `--output-dir`), sorted by QPU count then rate. Then plot:

```sh
python -m qnpack.dqc.experiments.grover_channel_plot \
  --manifest qnpack/dqc/experiments/grover4_channel_sweep.yml
```

The merge refuses rather than producing a quietly-wrong file when:

- a source is missing its summary or all-runs CSV (that sweep never finished);
- the sources do not cover the manifest exactly — it names which `QPU @ rate` are missing or unexpected;
- the same `(qpu_count, rate)` appears in two sources, or a source is listed twice;
- a condition's `num_runs` disagrees with the manifest;
- any condition's `.json` metadata disagrees with another's on the physics — gate depolarization, emission fidelity, collection efficiency, T1/T2, formalism, target. It names the differing key and both conditions.

Worker and thread counts are deliberately **not** compared: they vary legitimately between machines and do not affect the sampled distribution. So you can run 1 QPU on your laptop and 2–3 QPU on the server and still merge, as long as the physics matches.

`plot.x_scale: symlog` with `plot.x_linear_threshold` keeps the rate-0 point visible on an otherwise logarithmic axis; a plain log axis cannot show zero at all.

### Merging across separate sweeps

The same command merges sweeps run at different times — e.g. an earlier coarse sweep plus a later fine-grained one. The requirement is that the manifest you pass to the merge lists the **union** of all rates, and that the configurations genuinely match. The metadata check enforces the second part; nothing enforces that you remembered the first, beyond the coverage error naming what is missing.

Conditions from different sweeps must not overlap. If an old directory and a new one both contain `2 QPU @ 0.01`, the merge stops and tells you which two directories collide — decide which to keep and remove or move the other, rather than letting one arbitrarily win.
