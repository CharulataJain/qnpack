"""
config.py
---------
Resolve configuration into the concrete values a run needs.

Two jobs: work out which qubits to measure, and expand the noise
parameters into the list of configurations to sweep.

All simulation parameters **must** be explicitly specified in
``parameters.yml``.  No hardcoded fallback values are permitted —
if a required value is missing the simulation aborts with a clear
error message.
"""
import ast
import itertools
import logging
from collections import OrderedDict

from qnpack.common.config import MissingConfigError, require_cfg

log = logging.getLogger(__name__)

#: Noise parameters that can be swept, and the config block each lives in.
#: Each tuple is ``(param_name, config_block_name)``.  There are **no**
#: default values — every parameter must be present in ``parameters.yml``.
SWEEP_PARAMS = (
    ("two_q_depolar_prob", "qpu"),
    ("one_q_depolar_prob", "qpu"),
    ("emission_fidelity", "qpu"),
    ("collection_efficiency", "qpu"),
    ("T1", "memory"),
    ("T2", "memory"),
    ("one_q_gate_duration", "gate_durations"),
    ("two_q_gate_duration", "gate_durations"),
    ("photon_loss", "channel"),
    ("init_photon_loss", "channel"),
    ("fiber_depolar_rate", "channel"),
)


def resolve_measure_qubits(circuit_cfg):
    """Parse ``circuit.measure_qubits``, or return ``None`` to auto-derive.

    Only meaningful for ``mode='tket'``; every other mode derives the
    measured qubits from the circuit itself via the frontend.

    Returns
    -------
    dict or None
        ``{qpu_id: [position, …]}``, or ``None`` to derive from topology.
    """
    if circuit_cfg is None:
        raise MissingConfigError("circuit", "mode")
    mode = require_cfg(circuit_cfg, 'mode', 'circuit')
    if mode != 'tket':
        return None

    raw = getattr(circuit_cfg, 'measure_qubits', None)
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
    3. ``cfg``            — the value from parameters.yml (required)

    Every parameter in :data:`SWEEP_PARAMS` **must** be present in
    ``parameters.yml`` (under its respective section).  If it is missing,
    the simulation aborts with a :class:`MissingConfigError`.

    Returns
    -------
    tuple
        ``(param_names, combos)`` where each combo is a tuple of values in
        ``param_names`` order.
    """
    names, sweeps = [], []

    for name, block in SWEEP_PARAMS:
        module_cfg = getattr(cfg, block, None)
        if module_cfg is None:
            raise MissingConfigError(block, name)
        if name in varying_params:
            values = varying_params[name]
        elif name in fixed_params:
            values = [fixed_params[name]]
        else:
            values = [require_cfg(module_cfg, name, block)]
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


def require_epr_factory_config(cfg):
    """Validate that the ``epr_factory`` block exists and has all required keys.

    Called before each run.  If the block is missing entirely, the
    simulation aborts — users must explicitly set ``epr_factory.enabled``
    to ``false`` if they don't want the factory.

    When ``enabled`` is ``true``, every factory parameter is required.
    """
    epr = require_cfg(cfg, 'epr_factory', '<root>')

    # ``enabled`` is always required so the user makes a conscious choice.
    enabled = require_cfg(epr, 'enabled', 'epr_factory')

    # When disabled, no further keys are required.
    if not enabled:
        return

    # When enabled, validate every factory parameter.
    for key in (
        "pool_size_per_pair",
        "comm_qubits_reserved",
        "min_fidelity",
        "check_interval_ns",
        "pool_only",
        "drain_timeout_ns",
    ):
        require_cfg(epr, key, "epr_factory")
