"""
simulation.py
-------------
``DQCSimulation`` — run a distributed quantum computing circuit.

The class owns the run loop and little else.  Network construction lives in
:mod:`.network`, configuration in :mod:`.config`, and reporting in
:mod:`.results`.

Three entry points:

``start()``               local sweep over the configured noise parameters
``start_from_labeled()``  run from a payload already labeled by the plugin
``_run_single_config()``  the inner loop both of the above share
"""
import json
import hashlib
import logging
import os
import multiprocessing as mp
import copy
import pickle
import random
from concurrent.futures import ProcessPoolExecutor
from types import SimpleNamespace

import numpy as np
from munch import munchify

import netsquid as ns
import pydynaa as pd
from netsquid.protocols import Signals
from netsquid.util.datacollector import DataCollector

from qnpack.common.logging import setup_logging
from qnpack.common.simulation import Simulation
from qnpack.dqc.frontends import load_frontend
from qnpack.dqc.frontends.base import BaseFrontend
from qnpack.dqc.protocols import DQCProtocol

from . import config as cfg_util
from . import results as results_util
from .network import build_network, load_topology

log = logging.getLogger(__name__)


def _run_isolated(job):
    """Execute exactly one NetSquid run in a disposable worker process."""
    config_data, base_dir, topology_data, measure_qubits, run_idx, payload = job
    simulation = DQCSimulation.__new__(DQCSimulation)
    simulation.cfg = munchify(config_data)
    simulation.base_dir = base_dir
    simulation._last_protocol = None
    ns.set_qstate_formalism(cfg_util.resolve_formalism(simulation.cfg))

    if payload is None:
        frontend, _ = load_frontend(simulation.cfg.circuit, base_dir=base_dir)
    else:
        frontend = simulation._frontend_for_payload(payload, measure_qubits)
        simulation._install_labeled_payload(payload)

    return simulation._run_one(run_idx, measure_qubits, frontend,
                               topology_data)


class DQCSimulation(Simulation):
    """Drive a DQC circuit over a simulated quantum network."""

    def __init__(self, logfile=None, base_dir=None, topology_file=None,
                 *args, **kwargs):
        super().__init__(*args, **kwargs)

        ns.set_qstate_formalism(cfg_util.resolve_formalism(self.cfg))

        self.base_dir = base_dir
        self._topology_file = topology_file
        #: A serializable snapshot of the final run's protocol statistics.
        #: Live NetSquid objects remain inside their short-lived worker.
        self._last_protocol = None

        setup_logging(
            name=__name__,
            level=logging.DEBUG if self.cfg.sim.debug else logging.INFO,
            logfile=logfile,
        )
        log.debug(f"Configuration:\n{self.cfg}")

    def finalize(self):
        pass

    # ── Network ──────────────────────────────────────────────────────────

    def load_topology(self, topology_file=None):
        """Load the topology JSON for this simulation."""
        from qnpack.common.config import require_cfg
        topology_cfg = require_cfg(self.cfg, 'topology', '<root>')
        return load_topology(
            topology_file or self._topology_file or require_cfg(
                topology_cfg, 'file', 'topology'
            ),
            base_dir=self.base_dir,
        )

    def setup_network_from_topology(self, topology_data):
        """Build the network described by *topology_data*.

        Returns
        -------
        tuple
            ``(net, qpu_nodes, bsm_nodes, ctrl, qpu_info, bsm_info)``
        """
        return build_network(self.cfg, topology_data)

    # ── Measurement collection ───────────────────────────────────────────

    def setup_datacollector(self, qpu_nodes, measure_qubits, protocol):
        """Collect data-qubit measurements when the controller signals SUCCESS.

        Parameters
        ----------
        qpu_nodes : list of Node
            All QPU nodes, 0-indexed (QPU_1 is ``qpu_nodes[0]``).
        measure_qubits : dict
            ``{qpu_id: [position, …]}``, QPU ids being 1-based.
        protocol : DQCProtocol
            The protocol whose controller emits ``Signals.SUCCESS``.

        Returns
        -------
        DataCollector
        """
        targets = [
            (qid, qpu_nodes[qid - 1], pos)
            for qid, positions in measure_qubits.items()
            for pos in positions
        ]

        def collect(evexpr):
            row = {}
            for qid, node, pos in targets:
                qubit, = node.qmemory.peek(pos)
                outcome, _ = ns.qubits.measure(qubit)
                row[f"QPU_{qid}_q{pos}"] = outcome
                log.debug(f"DataCollector: {node.name} qubit {pos} = {outcome}")
            return row

        collector = DataCollector(collect, include_entity_name=False)
        collector.collect_on(
            pd.EventExpression(
                source=protocol, event_type=Signals.SUCCESS.value
            )
        )
        return collector

    # ── Run loop ─────────────────────────────────────────────────────────

    def _run_single_config(self, num_runs, measure_qubits, topology_data,
                           max_workers, labeled_payload=None):
        """Run each trial in a fresh spawned process and preserve run order."""
        if num_runs <= 0:
            raise ValueError("num_runs must be positive")
        jobs = (
            (self.cfg._munch, self.base_dir, topology_data, measure_qubits,
             run_idx, labeled_payload)
            for run_idx in range(num_runs)
        )
        completed = self._execute_jobs(jobs, max_workers, num_runs)

        results = [item[0] for item in completed]
        col_names = completed[0][1]
        self._last_protocol = completed[-1][4]
        results_util.log_measurement_table(results, col_names)
        return results, col_names, completed[0][2], completed[0][3]

    @staticmethod
    def _execute_jobs(jobs, max_workers, total_runs):
        with ProcessPoolExecutor(
            max_workers=min(max_workers, total_runs),
            mp_context=mp.get_context("spawn"),
            max_tasks_per_child=1,
        ) as executor:
            return list(executor.map(_run_isolated, jobs))

    def _run_one(self, run_idx, measure_qubits, frontend,
                 topology_data):
        """Run a single trial in the worker process."""
        ns.sim_reset()
        ns.set_random_state()
        random_state_sha256 = hashlib.sha256(
            pickle.dumps(ns.get_random_state().get_state())
        ).hexdigest()
        random.seed()
        np.random.seed()
        cfg_util.require_epr_factory_config(self.cfg)
        cfg_util.require_entanglement_config(self.cfg)
        net, qpu_nodes, bsm_nodes, ctrl, qpu_info, bsm_info = \
            self.setup_network_from_topology(topology_data)

        if run_idx == 0:
            self._log_network_summary(qpu_nodes, qpu_info, bsm_nodes,
                                      bsm_info, ctrl)
        if measure_qubits is None:
            measure_qubits = cfg_util.auto_derive_measure_qubits(qpu_info)

        protocol = DQCProtocol(
            self.cfg, network=net, qpu_nodes=qpu_nodes,
            controller_node=ctrl, qpu_info=qpu_info,
            bsm_info=bsm_info, bsm_nodes=bsm_nodes,
            run_idx=run_idx, frontend=frontend,
            q_switch=getattr(net, 'q_switch', None),
            switch_node=getattr(net, 'quantum_switch_node', None),
        )
        self._last_protocol = protocol

        collector = (
            self.setup_datacollector(qpu_nodes, measure_qubits, protocol)
            if frontend.needs_datacollector else None
        )

        start_time = ns.sim_time()
        log.info(
            f"--- Run {run_idx}: SIMULATION START TIME: {start_time} ns ---"
        )

        protocol.start()
        ns.sim_run()

        col_names = frontend.get_col_names(measure_qubits)
        row = self._collect_row(
            frontend, collector, col_names, protocol, run_idx, qpu_nodes
        )
        row["run"] = run_idx
        row["rng_state_sha256"] = random_state_sha256
        row["worker_pid"] = os.getpid()
        row["bitstring"] = frontend.get_bitstring(row, col_names)

        bit_vals = "  ".join(f"{c}={row.get(c, '?')}" for c in col_names)
        log.info(
            f"--- Run {run_idx}: {bit_vals}  =>  "
            f"bitstring={row['bitstring']} ---"
        )

        end_time = ns.sim_time()
        duration_ns = end_time - start_time
        log.info(
            f"--- Run {run_idx}: SIMULATION END TIME: {end_time} ns ---"
        )
        log.info(
            f"--- Run {run_idx}: SIMULATION DURATION: "
            f"{duration_ns} ns ({duration_ns / ns.SECOND:.6f} s) ---"
        )

        row["sim_duration_s"] = duration_ns / ns.SECOND
        durations = getattr(protocol, 'global_entanglement_durations', None)
        if durations:
            row["entanglement_durations"] = durations.copy()
        row["entl_time_s"] = results_util.mean_entanglement_time_per_run(row)

        protocol.stop()
        self._halt_free_running_clocks(net, run_idx)
        protocol_snapshot = SimpleNamespace(
            global_entanglement_durations=dict(
                getattr(protocol, 'global_entanglement_durations', {})
            ),
            subprotocols={
                name: SimpleNamespace(
                    epr_factory=SimpleNamespace(stats=dict(factory.stats))
                )
                for name, subprotocol in protocol.subprotocols.items()
                if (factory := getattr(subprotocol, 'epr_factory', None)) is not None
            },
        )
        return (
            row, col_names,
            getattr(frontend, 'num_output_bits', len(col_names)),
            getattr(frontend, 'output_reg_name', 'm'),
            protocol_snapshot,
        )

    @staticmethod
    def _halt_free_running_clocks(net, run_idx):
        """Stop any ``Clock`` still ticking after a run has been torn down.

        The BSM and controller clocks are created with ``max_ticks=-1``, so a
        clock that outlives its protocol keeps scheduling tick events for
        ever.  ``ns.sim_run()`` returns only once the event queue drains, so a
        single orphaned clock makes the *next* run hang indefinitely — with
        every protocol already stopped, which makes the stall hard to place.

        The protocols now stop their own clocks on teardown, so reaching this
        helper means something slipped through.  It is a backstop, not the
        primary fix, and it warns so the real leak is not silently masked.
        """
        from netsquid.components.clock import Clock

        stranded = []
        for node in net.nodes.values():
            for sub_name, sub in node.subcomponents.items():
                if isinstance(sub, Clock) and sub.is_running:
                    sub.stop()
                    stranded.append(f"{node.name}/{sub_name}")

        if stranded:
            log.warning(
                f"--- Run {run_idx}: stopped {len(stranded)} clock(s) still "
                f"running after teardown: {', '.join(stranded)}.  A clock "
                f"outliving its protocol would hang the next run."
            )

    @staticmethod
    def _collect_row(frontend, collector, col_names, protocol, run_idx,
                     qpu_nodes):
        """Read one run's measurements, from the collector or the frontend."""
        if collector is None:
            return frontend.get_result_row(
                protocol, run_idx, col_names, qpu_nodes
            )
        if len(collector.dataframe) > 0:
            return collector.dataframe.iloc[-1].to_dict()
        return {c: None for c in col_names}

    @staticmethod
    def _log_network_summary(qpu_nodes, qpu_info, bsm_nodes, bsm_info, ctrl):
        """Log what was built, once per configuration."""
        log.debug("=== Network Summary ===")
        log.debug(f"QPU Nodes: {len(qpu_nodes)}")
        for label, info in qpu_info.items():
            types = [
                f"q{q['local_index']}={q['type']}" for q in info['qubits']
            ]
            log.debug(
                f"  {label} (QPU_{info['qpu_id']}): {', '.join(types)}"
            )
        log.debug(f"BSM Nodes: {len(bsm_nodes)}")
        for label, info in bsm_info.items():
            log.debug(
                f"  {label} ({info['node_name']}): "
                f"left={info['left_qpu']}, right={info['right_qpu']}"
            )
        log.debug(f"Controller: {ctrl.name}")
        log.debug("=" * 40)

    # ── Entry points ─────────────────────────────────────────────────────

    def _parallel_settings(self, total_runs):
        from qnpack.common.config import require_cfg

        if total_runs <= 0:
            raise ValueError('At least one simulation run is required')
        sim_cfg = require_cfg(self.cfg, 'sim', '<root>')
        if 'starting_seed' in sim_cfg:
            raise ValueError('Remove sim.starting_seed; each shot uses fresh random state')
        worker_setting = require_cfg(sim_cfg, 'max_workers', 'sim')
        if worker_setting == 'auto':
            max_workers = os.cpu_count()
            if max_workers is None:
                raise RuntimeError('Cannot detect CPU count; set sim.max_workers')
        elif isinstance(worker_setting, int) and not isinstance(worker_setting, bool) and worker_setting > 0:
            max_workers = worker_setting
        else:
            raise ValueError('sim.max_workers must be a positive integer or auto')

        return max_workers

    def start(self, num_runs=None, qncp_host=None):
        """Run the simulation, sweeping every configured noise combination.

        With *qncp_host* set the circuit is instead sent to the QNCP plugin
        and simulated from the labeled payload it returns.

        Parameters
        ----------
        num_runs : int or None
            Defaults to ``cfg.sim.iterations``.
        qncp_host : str or None
            QNCP control-plane address.

        Returns
        -------
        list of dict
            One entry per noise configuration.
        """
        if num_runs is None:
            num_runs = self.cfg.sim.iterations

        if qncp_host:
            payload = self._send_to_plugin(qncp_host)
            return self.start_from_labeled(payload, num_runs=num_runs)

        ns.set_qstate_formalism(cfg_util.resolve_formalism(self.cfg))

        from qnpack.common.config import MissingConfigError, require_cfg

        circuit_cfg = getattr(self.cfg, "circuit", None)
        if circuit_cfg is None:
            raise MissingConfigError("circuit", "mode")
        results_cfg = require_cfg(self.cfg, 'results', '<root>')
        frontend, source = load_frontend(circuit_cfg, base_dir=self.base_dir)
        log.info(
            f"Frontend loaded: mode={circuit_cfg.mode!r}, source={source}"
        )

        measure_qubits = cfg_util.resolve_measure_qubits(circuit_cfg)
        topology_data = self.load_topology()

        param_names, combos = cfg_util.build_sweep(
            self.cfg, self.varying_params, self.fixed_params
        )
        log.info(
            f"Total combinations: {len(combos)} × {num_runs} runs each"
        )

        max_workers = self._parallel_settings(len(combos) * num_runs)
        log.info('Using up to %s workers', max_workers)
        scheduled = []
        for combo_idx, combo in enumerate(combos):
            params = dict(zip(param_names, combo))
            cfg_util.apply_params(self.cfg, params)
            noise_label = results_util.build_noise_label(params)
            scheduled.append((params, noise_label, copy.deepcopy(self.cfg._munch)))

        jobs = (
            (config_data, self.base_dir, topology_data, measure_qubits,
             run_idx, None)
            for _, _, config_data in scheduled
            for run_idx in range(num_runs)
        )
        completed = self._execute_jobs(jobs, max_workers, len(combos) * num_runs)
        self._last_protocol = completed[-1][4]

        final_data = []
        for combo_idx, (params, noise_label, _) in enumerate(scheduled):
            config_runs = completed[combo_idx * num_runs:(combo_idx + 1) * num_runs]
            results = [item[0] for item in config_runs]
            col_names = config_runs[0][1]
            num_output_bits = config_runs[0][2]
            log.info(f"=== Config: {noise_label} ===")
            results_util.log_measurement_table(results, col_names)

            counts, top_5 = results_util.summarise_bitstrings(
                results, col_names,
                require_cfg(results_cfg, 'top_n_bitstrings', 'results'),
            )

            final_data.append({
                "noise_label": noise_label,
                "two_q_prob": params["two_q_depolar_prob"],
                "one_q_prob": params["one_q_depolar_prob"],
                "emission_fidelity": params["emission_fidelity"],
                "collection_efficiency": params["collection_efficiency"],
                "T1": params["T1"],
                "T2": params["T2"],
                "one_q_gate_duration": params["one_q_gate_duration"],
                "two_q_gate_duration": params["two_q_gate_duration"],
                "photon_loss": params["photon_loss"],
                "init_photon_loss": params["init_photon_loss"],
                "fiber_depolar_rate": params["fiber_depolar_rate"],
                "counts": counts,
                "col_names": col_names,
                "num_runs": num_runs,
                "num_output_bits": num_output_bits,
                "results": results,
                "mean_entl_time_s": (
                    results_util.mean_entanglement_time_across_runs(results)
                ),
                "top_5_bitstrings": top_5,
            })

        results_util.write_csv(
            final_data, self.output_dir, circuit_cfg, num_runs,
            self.cfg.entanglement.method,
        )
        return final_data

    def plot(self, final_data, filename=None):
        """Plot bitstring histograms, one panel per noise configuration."""
        from qnpack.common.config import require_cfg
        if filename is None:
            results_cfg = require_cfg(self.cfg, 'results', '<root>')
            filename = require_cfg(results_cfg, 'plot_filename', 'results')
        return results_util.plot_histograms(
            final_data, self.output_dir, filename
        )

    # ── QNCP plugin pipeline ─────────────────────────────────────────────

    def _send_to_plugin(self, host):
        """Send the circuit to the QNCP DQC plugin and return its payload.

        Parameters
        ----------
        host : str
            QNCP control-plane address (e.g. ``"localhost"``).

        Returns
        -------
        dict
            The ``simulation_payload`` from the plugin response.
        """
        import asyncio
        from quantnet_mq.rpcclient import RPCClient
        from quantnet_mq.schema.models import Schema

        from qnpack.common.config import MissingConfigError, require_cfg

        circuit_cfg = getattr(self.cfg, "circuit", None)
        if circuit_cfg is None:
            raise MissingConfigError("circuit", "mode")
        _, source = load_frontend(circuit_cfg, base_dir=self.base_dir)
        mode = require_cfg(circuit_cfg, "mode", "circuit")
        with open(source) as f:
            circuit_content = f.read()

        Schema.load_schema(self._find_plugin_schema(), ns="dqc")
        log.info(f"Sending {os.path.basename(source)} to QNCP at {host} ...")

        async def _rpc():
            client = RPCClient("dqc-sim-client", host=host)
            client.set_handler(
                "dqcRequest", None,
                "quantnet_mq.schema.models.dqc.dqcRequest",
            )
            await client.start()
            try:
                raw = await client.call(
                    "dqcRequest",
                    {"circuit_mode": mode, "circuit_content": circuit_content},
                    timeout=120.0,
                )
                return json.loads(raw)
            finally:
                await client.stop()

        response = asyncio.run(_rpc())
        status = response.get("status", {})
        if status.get("value") != "OK":
            log.error(f"Plugin error: {status.get('message')}")
            raise SystemExit(1)
        return response["data"]["simulation_payload"]

    @staticmethod
    def _find_plugin_schema():
        """Locate ``dqc.yaml``, falling back to the last candidate path."""
        here = os.path.dirname(__file__)
        candidates = [
            os.path.join(here, "..", "..", "..", "qn-plugins", "plugins",
                         "schema", "dqc.yaml"),
            os.path.join(os.getcwd(), "..", "..", "..", "qn-plugins",
                         "plugins", "schema", "dqc.yaml"),
            os.path.join(os.getcwd(), "schema", "dqc.yaml"),
            os.path.join(here, "schema", "dqc.yaml"),
        ]
        return next(
            (p for p in candidates if os.path.exists(p)), candidates[-1]
        )

    def start_from_labeled(self, labeled_payload, num_runs=None):
        """Run from a payload already labeled by the plugin.

        Parameters
        ----------
        labeled_payload : dict
            As returned by :meth:`_send_to_plugin`.
        num_runs : int or None
            Defaults to ``cfg.sim.iterations``.

        Returns
        -------
        list of dict
            Result rows, one per run.
        """
        if num_runs is None:
            num_runs = self.cfg.sim.iterations

        topology_data = (
            labeled_payload.get("topology") or self.load_topology()
        )
        circuit_cfg = getattr(self.cfg, "circuit", None)
        measure_qubits = cfg_util.resolve_measure_qubits(circuit_cfg)
        max_workers = self._parallel_settings(num_runs)
        results, _, _, _ = self._run_single_config(
            num_runs=num_runs,
            measure_qubits=measure_qubits,
            topology_data=topology_data,
            max_workers=max_workers,
            labeled_payload=labeled_payload,
        )
        return results

    def _install_labeled_payload(self, labeled_payload):
        """Install the plugin's labels inside one disposable worker."""
        import copy

        labeled_commands = {
            int(k): v
            for k, v in labeled_payload["labeled_commands"].items()
        }
        process_maps = self._restore_process_maps(
            labeled_payload["process_maps"]
        )
        # DQCProtocol takes the plugin's labels at construction so the
        # controller does not re-parse the circuit.
        original_init = DQCProtocol.__init__

        def patched_init(protocol, *args, **kwargs):
            kwargs["frontend"] = None
            kwargs["pre_labeled_commands"] = copy.deepcopy(labeled_commands)
            kwargs["pre_process_maps"] = {
                "start_qpus": copy.deepcopy(process_maps["start_qpus"]),
                "end_qpus": copy.deepcopy(process_maps["end_qpus"]),
                "entanglement_gen_labels": set(
                    process_maps["entanglement_gen_labels"]
                ),
            }
            original_init(protocol, *args, **kwargs)

        DQCProtocol.__init__ = patched_init

    @staticmethod
    def _restore_process_maps(raw_maps):
        """Rebuild process maps from JSON, restoring int keys and sets."""
        def restore_key(k):
            try:
                return int(k)
            except (ValueError, TypeError):
                return k

        return {
            "start_qpus": {
                restore_key(k): {int(x) for x in v}
                for k, v in raw_maps.get("start_qpus", {}).items()
            },
            "end_qpus": {
                restore_key(k): {int(x) for x in v}
                for k, v in raw_maps.get("end_qpus", {}).items()
            },
            "entanglement_gen_labels": set(
                raw_maps.get("entanglement_gen_labels", [])
            ),
        }

    @staticmethod
    def _frontend_for_payload(labeled_payload, measure_qubits):
        """Build a frontend that only has to report results.

        Parsing already happened in the plugin, so this frontend exists to
        name the output register and, in tket mode, the measured qubits.
        """
        if measure_qubits is not None:
            from qnpack.dqc.frontends.tket_frontend import TketFrontend
            frontend = TketFrontend()
            frontend._num_output_bits = (
                labeled_payload.get("num_output_bits")
                or sum(len(p) for p in measure_qubits.values())
            )
            frontend._ir = {"measure_qubits": measure_qubits}
        else:
            frontend = BaseFrontend()
            frontend._num_output_bits = (
                labeled_payload.get("num_output_bits") or 0
            )

        frontend._output_reg_name = labeled_payload.get("output_reg_name", "m")
        return frontend
