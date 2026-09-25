"""
network/builder.py
------------------
Assemble the simulated network.

:func:`build_network` is the single entry point: topology in, a wired
``Network`` out.  It decides between switch and direct mode and calls the
wiring functions in :mod:`.channels` in a fixed order.
"""
import logging

from netsquid.nodes import Network

from qnpack.dqc.models.switch_node_builder import (
    build_switch_connections,
    create_switch_nodes,
)

from .channels import (
    ChannelParams,
    connect_bsm_feedback,
    connect_controller,
    connect_direct_quantum,
    connect_factory_plane,
    connect_qpu_classical,
)
from .topology import create_bsm_nodes, create_controller_node, create_qpu_nodes

log = logging.getLogger(__name__)


def build_network(cfg, topology_data):
    """Build the entire network from parsed topology data.

    Creates QPU nodes, BSM nodes, and the controller, then wires every
    plane between them.

    With more than one BSM node the topology is assumed to be switched: a
    ``FullMeshOpticalSwitch`` and ``ClassicalSwitch`` replace the direct
    QPU↔BSM channels, and are exposed as ``net.q_switch`` / ``net.c_switch``
    (both ``None`` in direct mode).

    Parameters
    ----------
    cfg : Config
        Parsed ``parameters.yml``.
    topology_data : list
        As returned by :func:`.topology.load_topology`.

    Returns
    -------
    tuple
        ``(net, qpu_nodes, bsm_nodes, ctrl, qpu_info, bsm_info)``
    """
    net = Network("dqc-net")
    params = ChannelParams(cfg)

    # ── Nodes ────────────────────────────────────────────────────────────
    qpu_nodes, qpu_info = create_qpu_nodes(
        cfg, topology_data, params.fiber_depolar_rate
    )
    for node in qpu_nodes:
        net.add_node(node)
    label_to_qpu_node = {
        label: qpu_nodes[info["qpu_id"] - 1]
        for label, info in qpu_info.items()
    }

    bsm_nodes, bsm_info = create_bsm_nodes(cfg, topology_data)
    for node in bsm_nodes:
        net.add_node(node)
    label_to_bsm_node = {
        label: bsm_nodes[info["bsm_id"] - 1]
        for label, info in bsm_info.items()
    }

    use_switch = len(bsm_nodes) > 1
    if use_switch:
        log.info(
            f"Switch mode enabled: {len(bsm_nodes)} BSM nodes detected. "
            f"Using FullMeshOpticalSwitch + ClassicalSwitch."
        )

    ctrl = create_controller_node(cfg, len(qpu_nodes), len(bsm_nodes))
    net.add_node(ctrl)

    for node in net.nodes.values():
        log.debug(f"{node.name} Ports: {list(node.ports.keys())}")

    # ── Channels ─────────────────────────────────────────────────────────
    connect_controller(net, ctrl, qpu_nodes, bsm_nodes)
    connect_qpu_classical(net, qpu_info, label_to_qpu_node)

    if use_switch:
        _wire_switched(net, qpu_nodes, qpu_info, bsm_nodes, bsm_info, params)
    else:
        net.q_switch = None
        net.c_switch = None
        connect_direct_quantum(
            net, bsm_info, label_to_qpu_node, label_to_bsm_node, params
        )
        connect_factory_plane(
            net, bsm_info, label_to_qpu_node, label_to_bsm_node, params
        )
        connect_bsm_feedback(
            net, bsm_info, label_to_qpu_node, label_to_bsm_node, params
        )

    return net, qpu_nodes, bsm_nodes, ctrl, qpu_info, bsm_info


def _wire_switched(net, qpu_nodes, qpu_info, bsm_nodes, bsm_info, params):
    """Insert optical and classical switches between the QPUs and BSMs."""
    quantum_switch_node, classical_switch_node, q_switch, c_switch = (
        create_switch_nodes(
            qpu_nodes=qpu_nodes,
            qpu_info=qpu_info,
            bsm_nodes=bsm_nodes,
            bsm_info=bsm_info,
        )
    )
    net.add_node(quantum_switch_node)
    net.add_node(classical_switch_node)

    build_switch_connections(
        net=net,
        quantum_switch_node=quantum_switch_node,
        classical_switch_node=classical_switch_node,
        qpu_nodes=qpu_nodes,
        qpu_info=qpu_info,
        bsm_nodes=bsm_nodes,
        bsm_info=bsm_info,
        q_lightspeed=params.q_lightspeed,
        c_lightspeed=params.c_lightspeed,
        photon_loss=params.photon_loss,
        init_photon_loss=params.init_photon_loss,
        fiber_depolar_rate=params.fiber_depolar_rate,
        time_independent=params.time_independent,
    )

    # DQCProtocol reaches the switches through the network object.
    net.q_switch = q_switch
    net.c_switch = c_switch
    net.quantum_switch_node = quantum_switch_node
    net.classical_switch_node = classical_switch_node
    log.info("Switch network wiring complete")
