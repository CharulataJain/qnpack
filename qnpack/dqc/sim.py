"""
sim.py
------
Command-line entry point for the DQC simulator (``dqc-sim``).

The simulator itself is split across sibling modules:

    simulation.py   DQCSimulation — the run loop
    network/        topology parsing and network construction
    config.py       measure-qubit resolution and noise sweeps
    results.py      bitstring aggregation, CSV, plots

``DQCSimulation`` is re-exported here so that ``from qnpack.dqc.sim import
DQCSimulation`` keeps working.
"""
import argparse
import json
import logging
import os

from qnpack.common.constants import Constants

from .simulation import DQCSimulation

__all__ = ["DQCSimulation", "main"]

log = logging.getLogger(__name__)


def build_parser():
    """Build the ``dqc-sim`` argument parser."""
    parser = argparse.ArgumentParser(
        prog="dqc-sim",
        description="Run a Distributed Quantum Computing (DQC) simulation.",
    )
    parser.add_argument(
        "-p", "--parameters",
        default=Constants.DEFAULT_PARAM_FILE,
        metavar="FILE",
        help=(
            "Path to the parameters YAML configuration file "
            f"(default: {Constants.DEFAULT_PARAM_FILE})"
        ),
    )
    parser.add_argument(
        "-b", "--base-dir",
        default=None,
        metavar="DIR",
        help=(
            "Base directory for resolving relative circuit file paths "
            "(QASM files, dist_commands files).  When set, the path in "
            "parameters.yml (e.g. circuit.qasm_file) is joined with this "
            "directory."
        ),
    )
    parser.add_argument(
        "-t", "--topology",
        default=None,
        metavar="FILE",
        help="Path to the topology JSON file (overrides default).",
    )
    parser.add_argument(
        "-o", "--output-dir",
        default=Constants.DEFAULT_OUTPUT_DIR,
        metavar="DIR",
        help=(
            "Directory for output results "
            f"(default: {Constants.DEFAULT_OUTPUT_DIR})"
        ),
    )
    parser.add_argument(
        "-n", "--num-runs",
        type=int,
        default=None,
        metavar="N",
        help=(
            "Number of simulation iterations (overrides the value in "
            "the parameters file)."
        ),
    )
    parser.add_argument(
        "--qncp",
        default=None,
        metavar="HOST",
        help=(
            "Address of the QNCP control plane (e.g. localhost or "
            "192.168.1.10). When provided, the circuit is sent to the DQC "
            "plugin via RPC and the simulation is run from the returned "
            "labeled payload.  Requires --qasm or --circuit-content; skips "
            "parameters.yml circuit settings."
        ),
    )
    parser.add_argument(
        "-d", "--debug",
        action="store_true",
        default=False,
        help="Enable debug-level logging.",
    )
    return parser


def _emit_plugin_results(results, output_dir):
    """Write plugin-mode results to JSON, or print them when unredirected."""
    payload = json.dumps(results, indent=2)

    if output_dir and output_dir != Constants.DEFAULT_OUTPUT_DIR:
        os.makedirs(output_dir, exist_ok=True)
        out_file = os.path.join(output_dir, "results.json")
        with open(out_file, "w") as f:
            f.write(payload)
        log.info(f"Results written to {out_file}")
    else:
        print(payload)


def main():
    args = build_parser().parse_args()

    fixed_params = {}
    if args.debug:
        fixed_params.setdefault("sim", {})["debug"] = True

    sim = DQCSimulation(
        fixed_params=fixed_params,
        varying_params={},
        parameter_file=args.parameters,
        output_dir=args.output_dir,
        base_dir=args.base_dir,
        topology_file=args.topology,
    )

    if args.debug:
        logging.basicConfig(level=logging.DEBUG)

    num_runs = (
        args.num_runs if args.num_runs is not None else sim.cfg.sim.iterations
    )
    results = sim.start(num_runs=num_runs, qncp_host=args.qncp)

    if args.qncp and results is not None:
        _emit_plugin_results(results, args.output_dir)


if __name__ == "__main__":
    main()
