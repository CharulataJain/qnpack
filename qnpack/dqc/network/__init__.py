"""
network/
--------
Construction of the simulated DQC network.

    topology.py   read the topology file; create QPU, BSM, controller nodes
    channels.py   wire the classical, quantum, BSM-feedback, and factory planes
    builder.py    assemble the above into a ready Network

Most callers want :func:`build_network` and :func:`load_topology`.
"""
from .builder import build_network
from .topology import (
    DEFAULT_TOPOLOGY_FILE,
    create_bsm_nodes,
    create_controller_node,
    create_qpu_nodes,
    load_topology,
)

__all__ = [
    "build_network",
    "load_topology",
    "create_qpu_nodes",
    "create_bsm_nodes",
    "create_controller_node",
    "DEFAULT_TOPOLOGY_FILE",
]
