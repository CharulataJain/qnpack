"""
network/channels.py
-------------------
Connect the nodes.

Each function here wires one plane of the network and mutates *net* in
place.  They are deliberately separate because the planes fail
independently: a missing factory port looks nothing like a missing BSM
result channel, and keeping them apart makes that obvious.

Planes
------
``connect_controller``   controller ↔ QPU and controller ↔ BSM (clk/ctrl/comm)
``connect_qpu_classical``  QPU ↔ QPU classical mesh
``connect_direct_quantum`` QPU → BSM quantum channels (non-switch topologies)
``connect_bsm_feedback``   BSM → QPU result and clock channels
``connect_factory_plane``  the EPR factory's dedicated BSM → QPU channels
"""
import logging

from netsquid.components.cchannel import ClassicalChannel
from netsquid.components.models.delaymodels import FibreDelayModel
from netsquid.components.models.qerrormodels import FibreLossModel
from netsquid.components.qchannel import QuantumChannel

from qnpack.dqc.models.node_builder import SafeDepolarNoiseModel

log = logging.getLogger(__name__)

# Nominal channel length placeholder: the delay model carries propagation
# delay, so the topology's real lengths are logged rather than applied.
CHANNEL_LENGTH_KM = 0.01


class ChannelParams:
    """Channel-level physical parameters read from the ``channel:`` config."""

    def __init__(self, cfg):
        ch = cfg.channel
        self.q_lightspeed = getattr(ch, 'q_lightspeed', 200000)
        self.c_lightspeed = getattr(ch, 'c_lightspeed', 200000)
        self.photon_loss = getattr(ch, 'photon_loss', 0)
        self.init_photon_loss = getattr(ch, 'init_photon_loss', 0)
        self.fiber_depolar_rate = getattr(ch, 'fiber_depolar_rate', 0)
        self.time_independent = getattr(ch, 'time_independent', False)

    def quantum_models(self):
        """Delay, loss, and noise models for a quantum channel."""
        models = {"delay_model": FibreDelayModel(c=self.q_lightspeed * 1000)}
        if self.photon_loss or self.init_photon_loss:
            models["quantum_loss_model"] = FibreLossModel(
                p_loss_init=self.init_photon_loss,
                p_loss_length=self.photon_loss,
            )
        if self.fiber_depolar_rate:
            models["quantum_noise_model"] = SafeDepolarNoiseModel(
                depolar_rate=self.fiber_depolar_rate,
                time_independent=self.time_independent,
            )
        return models

    def classical_models(self):
        """Delay model for a classical channel."""
        return {"delay_model": FibreDelayModel(c=self.c_lightspeed * 1000)}


def _connect(net, src, dst, name, port_src, port_dst, label, models=None,
             quantum=False):
    """Add one channel between two nodes."""
    channel_cls = QuantumChannel if quantum else ClassicalChannel
    kwargs = {"name": name, "length": CHANNEL_LENGTH_KM}
    if models:
        kwargs["models"] = models
    net.add_connection(
        src, dst,
        channel_to=channel_cls(**kwargs),
        port_name_node1=port_src,
        port_name_node2=port_dst,
        label=label,
    )


def connect_controller(net, ctrl, qpu_nodes, bsm_nodes):
    """Wire the controller to every QPU and BSM.

    Each peer gets three channels: clock out, control out, and comm back.
    """
    for i, node in enumerate(qpu_nodes, start=1):
        _connect(net, ctrl, node, f"cch_clk_ctrl_to_{node.name}",
                 f"clk{i}_port", "clk_port", f"clk_{node.name}")
        _connect(net, ctrl, node, f"cch_ctrl_ctrl_to_{node.name}",
                 f"ctrl{i}_port", "ctrl_port", f"ctrl_{node.name}")
        _connect(net, node, ctrl, f"cch_comm_{node.name}_to_ctrl",
                 "comm_port", f"comm{i}_port", f"comm_{node.name}")
        log.debug(f"Controller <-> {node.name}: clk/ctrl/comm wired")

    for i, node in enumerate(bsm_nodes, start=1):
        _connect(net, ctrl, node, f"cch_clk_ctrl_to_{node.name}",
                 f"clk_bsm{i}_port", "clk_port", f"clk_{node.name}")
        _connect(net, ctrl, node, f"cch_ctrl_ctrl_to_{node.name}",
                 f"ctrl_bsm{i}_port", "ctrl_port", f"ctrl_{node.name}")
        _connect(net, node, ctrl, f"cch_comm_{node.name}_to_ctrl",
                 "comm_port", f"comm_bsm{i}_port", f"comm_{node.name}")
        log.debug(f"Controller <-> {node.name}: clk/ctrl/comm wired")


def connect_qpu_classical(net, qpu_info, label_to_qpu_node):
    """Wire the QPU ↔ QPU classical mesh described by the topology."""
    connected = set()
    for label, info in qpu_info.items():
        node = label_to_qpu_node[label]
        qpu_id = info["qpu_id"]
        for neighbor_label, conn in info["classical_neighbors"].items():
            if neighbor_label not in qpu_info:
                continue
            if (label, neighbor_label) in connected:
                continue
            neighbor = label_to_qpu_node[neighbor_label]
            neighbor_id = qpu_info[neighbor_label]["qpu_id"]
            c_to, c_from = f"c_to_{neighbor_id}", f"c_from_{qpu_id}"
            _connect(net, node, neighbor,
                     f"cch_{node.name}_to_{neighbor.name}", c_to, c_from,
                     f"classical_{node.name}_to_{neighbor.name}")
            connected.add((label, neighbor_label))
            log.debug(
                f"Classical: {node.name}.{c_to} -> {neighbor.name}.{c_from} "
                f"(length={conn.get('length', 1)} km)"
            )


def connect_direct_quantum(net, bsm_info, label_to_qpu_node,
                           label_to_bsm_node, params):
    """Wire QPU → BSM quantum channels for a topology without a switch."""
    for bsm_label, info in bsm_info.items():
        bsm_node = label_to_bsm_node[bsm_label]
        bsm_name = info["node_name"]

        for side, length_key in (("left", "q_left"), ("right", "q_right")):
            qpu_label = info[f"{side}_qpu"]
            if not qpu_label or qpu_label not in label_to_qpu_node:
                continue
            qpu_node = label_to_qpu_node[qpu_label]
            _connect(
                net, qpu_node, bsm_node,
                f"qch_{qpu_node.name}_to_{bsm_node.name}",
                f"q_to_{bsm_label}", f"{bsm_name}_{side}_port",
                f"quantum_{qpu_node.name}_to_{bsm_node.name}_{side}",
                models=params.quantum_models(), quantum=True,
            )
            log.debug(
                f"Quantum: {qpu_node.name}.q_to_{bsm_label} -> "
                f"{bsm_node.name}.{bsm_name}_{side}_port "
                f"(length={info['channel_lengths'].get(length_key, 1)} km)"
            )


def connect_bsm_feedback(net, bsm_info, label_to_qpu_node,
                         label_to_bsm_node, params):
    """Wire BSM → QPU result and clock channels."""
    models = params.classical_models()

    for kind, info_prefix, port_prefix, qpu_prefix in (
        ("result", "result", "BSM_res_to", "bsm_res_from"),
        ("clock", "clk", "clk_to", "clk_from"),
    ):
        for bsm_label, info in bsm_info.items():
            bsm_node = label_to_bsm_node[bsm_label]
            for side in ("left", "right"):
                entry = info.get(f"{info_prefix}_{side}")
                if not entry:
                    continue
                target_label = entry["target"]
                if target_label not in label_to_qpu_node:
                    continue
                target = label_to_qpu_node[target_label]
                suffix = "" if side == "left" else "_right"
                short = "res" if kind == "result" else "clk"
                _connect(
                    net, bsm_node, target,
                    f"cch_bsm_{short}_{bsm_node.name}_to_{target.name}{suffix}",
                    f"{port_prefix}_{side}", f"{qpu_prefix}_{bsm_label}",
                    f"bsm_{short}_{bsm_node.name}_to_{target.name}{suffix}",
                    models=models,
                )
                log.debug(
                    f"BSM {kind}: {bsm_node.name}.{port_prefix}_{side} -> "
                    f"{target.name}.{qpu_prefix}_{bsm_label} "
                    f"(length={entry['length']} km)"
                )


def connect_factory_plane(net, bsm_info, label_to_qpu_node,
                          label_to_bsm_node, params):
    """Wire the EPR factory's dedicated BSM → QPU classical plane.

    Physically these are the same fibres as the circuit-plane result and
    clock channels, but they are separate NetSquid ports so the factory
    worker and the circuit worker never contend for one port.  The factory
    listens on ``factory_clk_from_{bsm}`` and ``factory_bsm_res_from_{bsm}``.
    """
    models = params.classical_models()

    for bsm_label, info in bsm_info.items():
        bsm_node = label_to_bsm_node[bsm_label]
        for side in ("left", "right"):
            for kind, info_key, bsm_port, qpu_port in (
                ("res", f"result_{side}", f"factory_BSM_res_to_{side}",
                 f"factory_bsm_res_from_{bsm_label}"),
                ("clk", f"clk_{side}", f"factory_clk_to_{side}",
                 f"factory_clk_from_{bsm_label}"),
            ):
                entry = info.get(info_key)
                if not entry:
                    continue
                target_label = entry["target"]
                if target_label not in label_to_qpu_node:
                    continue
                target = label_to_qpu_node[target_label]
                if qpu_port not in target.ports:
                    target.add_ports([qpu_port])
                _connect(
                    net, bsm_node, target,
                    f"cch_factory_{kind}_{bsm_node.name}_to_"
                    f"{target.name}_{side}",
                    bsm_port, qpu_port,
                    f"factory_{kind}_{bsm_node.name}_to_{target.name}_{side}",
                    models=models,
                )
                log.debug(
                    f"Factory {kind}: {bsm_node.name}.{bsm_port} -> "
                    f"{target.name}.{qpu_port}"
                )
