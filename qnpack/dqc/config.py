"""
config.py
---------
Resolve configuration into the concrete values a run needs.

Two jobs: work out which qubits to measure, and expand the noise
parameters into the list of configurations to sweep.
"""
import ast
import itertools
import logging
from collections import OrderedDict

log = logging.getLogger(__name__)

#: Noise parameters that can be swept, and the config block each lives in.
SWEEP_PARAMS = (
    ("two_q_depolar_prob", "qpu", 0),
    ("one_q_depolar_prob", "qpu", 0),
    ("emission_fidelity", "qpu", 1.0),
    ("collection_efficiency", "qpu", 1.0),
    ("T1", "memory", 1e15),
    ("T2", "memory", 1e15),
    ("one_q_gate_duration", "gate_durations", 0),
    ("two_q_gate_duration", "gate_durations", 0),
    ("photon_loss", "channel", 0),
    ("init_photon_loss", "channel", 0),
    ("fiber_depolar_rate", "channel", 0),
)

#: Defaults used when the ``epr_factory`` block is absent entirely.
EPR_FACTORY_DEFAULTS = {
    "enabled": False,
    "pool_size_per_pair": 3,
    "comm_qubits_reserved": 4,
    "min_fidelity": 0.9,
    "check_interval_ns": 1_000_000,
}


def resolve_measure_qubits(circuit_cfg):
    """Parse ``circuit.measure_qubits``, or return ``None`` to auto-derive.

    Only meaningful for ``mode='tket'``; every other mode derives the
    measured qubits from the circuit itself via the frontend.

    Returns
    -------
    dict or None
        ``{qpu_id: [position, …]}``, or ``None`` to derive from topology.
    """
    mode = getattr(circuit_cfg, 'mode', 'tket') if circuit_cfg else 'tket'
    if mode != 'tket':
        return None

    raw = getattr(circuit_cfg, 'measure_qubits', None) if circuit_cfg else None
    if raw is None:
        log.info(
            "circuit.measure_qubits not set — will auto-derive from topology"
        )
        return None

    try:
        return {int(k): list(v) for k, v in ast.literal_eval(str(raw)).items()}
    except (ValueError, SyntaxError) as e:
        log.warning(
            f"Could not parse circuit.measure_qubits={raw!r}: {e}. "
            f"Will auto-derive from topology."
        )
        return None


def auto_derive_measure_qubits(qpu_info):
    """Measure every data qubit, in QPU then position order.

    Used when neither the config nor the frontend names the output qubits.

    Parameters
    ----------
    qpu_info : dict
        As returned by the network builder.

    Returns
    -------
    OrderedDict
        ``{qpu_id: [local_index, …]}``
    """
    measure_qubits = OrderedDict()
    for info in sorted(qpu_info.values(), key=lambda x: x["qpu_id"]):
        positions = sorted(
            q["local_index"] for q in info["qubits"] if q["type"] == "data"
        )
        if positions:
            measure_qubits[info["qpu_id"]] = positions

    log.info(
        f"Auto-derived measure_qubits from topology: {dict(measure_qubits)}"
    )
    return measure_qubits


def build_sweep(cfg, varying_params, fixed_params):
    """Expand the noise parameters into every combination to simulate.

    Resolution priority, highest first:

    1. ``varying_params`` — a list of values to sweep
    2. ``fixed_params``   — a single scalar override
    3. ``cfg``            — the default from parameters.yml

    Returns
    -------
    tuple
        ``(param_names, combos)`` where each combo is a tuple of values in
        ``param_names`` order.
    """
    names, sweeps = [], []

    for name, block, default in SWEEP_PARAMS:
        module_cfg = getattr(cfg, block, None)
        if name in varying_params:
            values = varying_params[name]
        elif name in fixed_params:
            values = [fixed_params[name]]
        else:
            values = [getattr(module_cfg, name, default) or default]
        names.append(name)
        sweeps.append(values)

    combos = list(itertools.product(*sweeps))
    log.info(
        f"Running simulation with parameters: {dict(zip(names, sweeps))}"
    )
    log.info(f"Fixed parameters: {fixed_params}")
    return names, combos


def apply_params(cfg, params):
    """Write one sweep combination back into *cfg*.

    The network builder reads its values from ``cfg``, so a sweep step has
    to land there before the next network is built.
    """
    cfg.qpu.two_q_depolar_prob = params["two_q_depolar_prob"]
    cfg.qpu.one_q_depolar_prob = params["one_q_depolar_prob"]
    cfg.qpu.emission_fidelity = params["emission_fidelity"]
    cfg.qpu.collection_efficiency = params["collection_efficiency"]
    cfg.memory.T1 = params["T1"]
    cfg.memory.T2 = params["T2"]
    cfg.gate_durations.one_q_gate_duration = params["one_q_gate_duration"]
    cfg.gate_durations.two_q_gate_duration = params["two_q_gate_duration"]
    cfg.channel.photon_loss = params["photon_loss"]
    cfg.channel.init_photon_loss = params["init_photon_loss"]
    cfg.channel.fiber_depolar_rate = params["fiber_depolar_rate"]


def ensure_epr_factory_defaults(cfg):
    """Add an ``epr_factory`` block if the config file omits one."""
    if not hasattr(cfg, 'epr_factory'):
        from munch import Munch
        cfg._munch.epr_factory = Munch(dict(EPR_FACTORY_DEFAULTS))
