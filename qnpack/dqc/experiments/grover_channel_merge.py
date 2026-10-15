"""Merge per-QPU fiber depolarization sweep directories into one result set.

Usage: python -m qnpack.dqc.experiments.grover_channel_merge \
           --manifest PATH --source DIR [--source DIR ...] [--output-dir DIR]

Each source directory holds the output of one `grover_channel_sweep` invocation
(typically `--qpu-count N --output-dir DIR`). The merge refuses to combine runs
whose physics configuration differs, so a merged summary always describes a
single experiment.
"""

import argparse
import json
from pathlib import Path

from .grover_channel_sweep import _load_manifest, _rate_tag, _sweep_spec
from .grover_sweep import _path, _read_csv, _write_csv


# Metadata keys that must agree across every condition in every source
# directory. Worker and thread counts are excluded: they vary by machine and
# do not affect the sampled distribution. The swept parameter is excluded at
# run time, since varying it is the whole point of the sweep.
SHARED_METADATA = (
    "algorithm", "target_bitstring", "circuit_mode", "entanglement_method",
    "formalism", "num_runs", "two_q_depolar_prob", "one_q_depolar_prob",
    "emission_fidelity", "collection_efficiency", "T1", "T2",
)


def _condition_metadata(source_dir, algorithm, qpu_count, rate, run_count, sweep_tag):
    tag = (f"{algorithm}_cisco_bsm_ket_{qpu_count}qpu_"
           f"{sweep_tag}{_rate_tag(rate)}_{run_count}runs")
    path = source_dir / f"{tag}.json"
    if not path.is_file():
        raise FileNotFoundError(
            f"{path} is missing; the merge needs each condition's metadata to "
            f"prove the runs share one configuration")
    with path.open(encoding="utf-8") as stream:
        return json.load(stream)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--source", type=Path, action="append", required=True,
                        help="Directory from one sweep invocation; repeat per QPU count")
    parser.add_argument("--output-dir", type=Path,
                        help="Destination; defaults to the manifest's output_dir")
    args = parser.parse_args(argv)

    manifest_path = args.manifest.expanduser().resolve()
    manifest = _load_manifest(manifest_path)
    algorithm = manifest["algorithm"]
    target = manifest["target_bitstring"]
    run_count = manifest["num_runs"]
    section, swept_key, rates, sweep_tag = _sweep_spec(manifest)
    # Varying the swept parameter is the point; comparing it would reject
    # every legitimate merge.
    shared_keys = tuple(key for key in SHARED_METADATA if key != swept_key)
    prefix = f"{algorithm}_cisco_bsm_ket"

    sources = [directory.expanduser().resolve() for directory in args.source]
    if len(set(sources)) != len(sources):
        raise ValueError("The same source directory was given twice")
    for directory in sources:
        if not directory.is_dir():
            raise NotADirectoryError(directory)
    output_dir = (_path(manifest_path.parent, manifest["output_dir"], "output_dir")
                  if args.output_dir is None else args.output_dir.expanduser().resolve())

    summary_rows = []
    combined_rows = []
    combined_fields = None
    seen = {}
    reference = None

    for directory in sources:
        summary_path = directory / f"{prefix}_target_{target}_summary.csv"
        runs_path = directory / f"{prefix}_all_runs.csv"
        for path in (summary_path, runs_path):
            if not path.is_file():
                raise FileNotFoundError(f"{path} is missing; did that sweep finish?")
        _, rows = _read_csv(summary_path)
        run_fields, runs = _read_csv(runs_path)

        if combined_fields is None:
            combined_fields = run_fields
        elif combined_fields != run_fields:
            raise ValueError(f"{runs_path}: raw CSV columns differ from the first source")

        value_column = "swept_value" if "swept_value" in rows[0] else "fiber_depolar_rate"
        for row in rows:
            qpu_count = int(row["qpu_count"])
            rate = float(row[value_column])
            if qpu_count not in manifest["qpu_circuits"]:
                raise ValueError(f"{summary_path}: qpu_count {qpu_count} is absent from the manifest")
            if not any(rate == float(value) for value in rates):
                raise ValueError(f"{summary_path}: rate {rate:g} is absent from the manifest")
            if int(row["num_runs"]) != run_count:
                raise ValueError(
                    f"{summary_path}: {qpu_count} QPU at rate {rate:g} has "
                    f"{row['num_runs']} runs, the manifest says {run_count}")
            if (qpu_count, rate) in seen:
                raise ValueError(
                    f"{qpu_count} QPU at rate {rate:g} appears in both "
                    f"{seen[(qpu_count, rate)]} and {directory}")
            seen[(qpu_count, rate)] = directory

            metadata = _condition_metadata(directory, algorithm, qpu_count, rate,
                                           run_count, sweep_tag)
            shared = {key: metadata[key] for key in shared_keys}
            if reference is None:
                reference = (shared, directory, qpu_count, rate)
            elif shared != reference[0]:
                differing = sorted(key for key in shared_keys
                                   if shared[key] != reference[0][key])
                raise ValueError(
                    f"{qpu_count} QPU at rate {rate:g} in {directory} disagrees with "
                    f"{reference[2]} QPU at rate {reference[3]:g} in {reference[1]} "
                    f"on: {', '.join(differing)}. These runs are not comparable.")
            summary_rows.append(row)

        matching = [run for run in runs]
        if len(matching) != len(rows) * run_count:
            raise ValueError(
                f"{runs_path}: holds {len(matching)} rows, expected "
                f"{len(rows) * run_count} for {len(rows)} conditions")
        combined_rows.extend(matching)

    expected = {(int(qpu), float(rate)) for qpu in manifest["qpu_circuits"] for rate in rates}
    if set(seen) != expected:
        missing = sorted(expected - set(seen))
        extra = sorted(set(seen) - expected)
        report = []
        if missing:
            report.append("missing " + ", ".join(f"{qpu} QPU @ {rate:g}" for qpu, rate in missing))
        if extra:
            report.append("unexpected " + ", ".join(f"{qpu} QPU @ {rate:g}" for qpu, rate in extra))
        raise ValueError("The sources do not cover the manifest exactly: " + "; ".join(report))

    sort_column = "swept_value" if "swept_value" in summary_rows[0] else "fiber_depolar_rate"
    summary_rows.sort(key=lambda row: (int(row["qpu_count"]), float(row[sort_column])))
    combined_rows.sort(key=lambda row: (int(row["qpu_count"]), int(row["sweep_index"]),
                                        int(row["run"])))

    output_dir.mkdir(parents=True, exist_ok=True)
    _write_csv(output_dir / f"{prefix}_target_{target}_summary.csv",
               list(summary_rows[0]), summary_rows)
    _write_csv(output_dir / f"{prefix}_all_runs.csv", combined_fields, combined_rows)
    print(f"merged {len(seen)} conditions / {len(combined_rows)} runs "
          f"from {len(sources)} directories into {output_dir}")


if __name__ == "__main__":
    main()
