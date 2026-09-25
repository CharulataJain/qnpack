"""
network/topology.py
-------------------
Read the topology file and turn it into nodes.

This module answers "what exists": QPUs, BSMs, and the controller. It does
not connect anything — see :mod:`.channels` for that.

All physical parameters are **required** from ``parameters.yml`` — no
hardcoded defaults.
"""
import json
import logging
import os

from netsquid.components.clock import Clock
from netsquid.nodes import Node

from qnpack.common.config import require_cfg
from qnpack.dqc.models.node_builder import (
    QPUNodeBuilder,
    create_bsm_nodes_from_topology,
)

log = logging.getLogger(__name__)

DEFAULT_TOPOLOGY_FILE = "topology/topology_v2.json"


def load_topology(topology_file=None, base_dir=None):
    """Load topology from a local JSON file.

    Parameters
    ----------
    topology_file : str or None
        Path to the topology JSON file.  Defaults to
        ``topology/topology_v2.json``.  Relative paths are resolved against
        *base_dir* when that is set.
    base_dir : str or None
        Directory to resolve a relative *topology_file* against.

    Returns
    -------
    list
        Parsed topology data.
    """
    if topology_file is None:
        topology_file = DEFAULT_TOPOLOGY_FILE

    if base_dir is not None and not os.path.isabs(topology_file):
        topology_file = os.path.join(base_dir, topology_file)

    with open(topology_file, "r") as f:
        data = json.load(f)

    log.debug(f"Loaded topology from {topology_file}")
    log.debug(
        f"Topology: {data[0]['num_nodes']} nodes, "
        f"{data[0]['num_channels']} channels"
    )
    return data


def create_qpu_nodes(cfg, topology_data, fiber_depolar_rate):
    """Build the QPU nodes described by *topology_data*.

    Node count and per-QPU qubit counts come from the topology file, which
    is authoritative: ``create_nodes_from_topology`` overrides both, so the
    ``cfg`` values are only fallbacks for the (unused) path that builds QPUs
    without a topology.

    All physical parameters are **required** from ``parameters.yml``.

    Returns
    -------
    tuple
        ``(qpu_nodes, qpu_info)``
    """
    builder = QPUNodeBuilder(
        n=require_cfg(cfg.qpu, 'num_qpu_nodes', 'qpu'),
        num_qubits=require_cfg(cfg.qpu, 'qubits', 'qpu'),
        T1=float(require_cfg(cfg.memory, 'T1', 'memory')),
        T2=float(require_cfg(cfg.memory, 'T2', 'memory')),
        two_q_depolar_prob=require_cfg(cfg.qpu, 'two_q_depolar_prob', 'qpu'),
        one_q_depolar_prob=require_cfg(cfg.qpu, 'one_q_depolar_prob', 'qpu'),
        emission_fidelity=require_cfg(cfg.qpu, 'emission_fidelity', 'qpu'),
        collection_efficiency=require_cfg(cfg.qpu, 'collection_efficiency', 'qpu'),
        one_q_gate_duration=require_cfg(
            cfg.gate_durations, 'one_q_gate_duration', 'gate_durations'
        ),
        two_q_gate_duration=require_cfg(
            cfg.gate_durations, 'two_q_gate_duration', 'gate_durations'
        ),
        fiber_depolar_rate=fiber_depolar_rate,
    )
    return builder.create_nodes_from_topology(topology_data)


def create_bsm_nodes(cfg, topology_data):
    """Build the BSM nodes described by *topology_data*.

    All BSM parameters are **required** from ``parameters.yml``.

    Returns
    -------
    tuple
        ``(bsm_nodes, bsm_info)``
    """
    return create_bsm_nodes_from_topology(
        topology_data,
        detection_window=require_cfg(cfg.bsm, 'detection_window', 'bsm'),
        system_delay=require_cfg(cfg.bsm, 'system_delay', 'bsm'),
        coupling_efficiency=require_cfg(cfg.bsm, 'coupling_efficiency', 'bsm'),
        deterministic_bsm=require_cfg(cfg.bsm, 'deterministic_bsm', 'bsm'),
    )


def create_controller_node(cfg, num_qpu_nodes, num_bsm_nodes):
    """Build the central controller, with one port trio per QPU and BSM.

    Each peer gets a clock, a control, and a comm port; the controller also
    carries the simulation clock as a subcomponent.

    Returns
    -------
    Node
    """
    port_names = []
    for i in range(1, num_qpu_nodes + 1):
        port_names += [f"clk{i}_port", f"ctrl{i}_port", f"comm{i}_port"]
    for i in range(1, num_bsm_nodes + 1):
        port_names += [
            f"clk_bsm{i}_port", f"ctrl_bsm{i}_port", f"comm_bsm{i}_port"
        ]

    ctrl = Node("Central Controller", port_names=port_names)
    ctrl.add_subcomponent(
        Clock("CtrlCLK", cfg.clock.HZ, max_ticks=cfg.clock.max_ticks)
    )
    return ctrl
