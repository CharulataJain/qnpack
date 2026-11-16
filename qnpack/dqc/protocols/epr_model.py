"""
protocols/epr_model.py
----------------------
Compute effective EPR pair fidelity and herald success probability from the
DQC simulation's physical noise parameters.

The result drives a DepolariseMagicDistributor, replacing the full physical
BSM simulation (photon emission, channel, detection, retries) with an
abstract entanglement model that has the same expected fidelity and
per-attempt herald rate.

Physics
~~~~~~~
Fidelity is modelled as a Werner state:

    ρ = F |Φ+⟩⟨Φ+| + (1-F)/3 (|Φ-⟩⟨Φ-| + |Ψ+⟩⟨Ψ+| + |Ψ-⟩⟨Ψ-|)

F is computed by composing all depolarising noise sources in the same order
the DQC code applies them, one qubit at a time:

Memory qubit path  (H gate → CNOT):
    p_mem = compose(1q_gate_depol + T2_during_H,  2q_gate_depol + T2_during_CNOT)

Photon path (CNOT → emission → fiber):
    p_phot = compose(2q_gate_depol + T2,  emission_depol,  fiber_depolar_rate)

Combined Werner fidelity (independent depol on each half):
    F = (1 - p_mem)(1 - p_phot) + p_mem * p_phot / 3

Herald success probability per attempt:
    p_survive = (1-init_photon_loss) * (1-photon_loss)^L * collection_eff * coupling_eff
    P_herald  = bsm_factor * p_survive²    (bsm_factor=1 det BSM, 0.5 Pauli-tensor)

Attempt rate is gate-limited (H + CNOT cycle):
    rate_hz = 1e9 / (one_q_gate_duration + two_q_gate_duration)

Usage
~~~~~
    fidelity, p_herald, rate_hz = compute_epr_params(cfg)
"""

import math
import logging

log = logging.getLogger(__name__)


def _compose_depol(p1: float, p2: float) -> float:
    """Compose two sequential single-qubit depolarising channels.

    D(p2) ∘ D(p1): combined probability = p1 + p2*(1 - 4*p1/3).
    """
    return p1 + p2 * (1.0 - 4.0 * p1 / 3.0)


def compute_epr_params(cfg):
    """Compute effective (fidelity, success_probability, attempt_rate_hz).

    Reads the same physical parameters used by the BSM simulation
    (``cfg.qpu``, ``cfg.memory``, ``cfg.gate_durations``, ``cfg.channel``,
    ``cfg.bsm``) and returns the three quantities needed to configure a
    ``DepolariseMagicDistributor`` for the ``epr_model`` entanglement method.

    Parameters
    ----------
    cfg : munch.Munch
        Parsed ``parameters.yml`` (after :func:`~.config.apply_params` has
        been called for the current sweep step).

    Returns
    -------
    fidelity : float
        Effective Bell-pair Werner-state fidelity in [0.25, 1.0].
    success_probability : float
        Per-attempt herald success probability in (0, 1].
    attempt_rate_hz : float
        Entanglement generation attempt rate in Hz (gate-limited).
    """
    # ── Gate durations ────────────────────────────────────────────────────
    one_q_dur = float(cfg.gate_durations.one_q_gate_duration)
    two_q_dur = float(cfg.gate_durations.two_q_gate_duration)

    # ── QPU noise ─────────────────────────────────────────────────────────
    p_1q = float(cfg.qpu.one_q_depolar_prob)
    p_2q = float(cfg.qpu.two_q_depolar_prob)
    emf  = float(cfg.qpu.emission_fidelity)
    coll = float(cfg.qpu.collection_efficiency)

    # ── Memory T2 dephasing during gates ──────────────────────────────────
    T2 = float(cfg.memory.T2)

    def _t2_depol(dt: float) -> float:
        if T2 <= 0.0 or dt <= 0.0:
            return 0.0
        return 0.5 * (1.0 - math.exp(-dt / T2))

    # ── Channel ───────────────────────────────────────────────────────────
    ph_loss    = float(cfg.channel.photon_loss)
    init_pl    = float(cfg.channel.init_photon_loss)
    fib_depol  = float(cfg.channel.fiber_depolar_rate)
    sim_len_km = float(cfg.channel.simulated_length_km)

    # ── BSM ───────────────────────────────────────────────────────────────
    det_bsm  = bool(cfg.bsm.deterministic_bsm)
    coup_eff = float(cfg.bsm.coupling_efficiency)

    # ── Memory qubit: H gate then CNOT ───────────────────────────────────
    p_H_mem  = _compose_depol(p_1q,  _t2_depol(one_q_dur))
    p_CX_mem = _compose_depol(p_2q,  _t2_depol(two_q_dur))
    p_mem    = _compose_depol(p_H_mem, p_CX_mem)

    # ── Photon qubit: CNOT depol + emission noise + fiber ─────────────────
    p_CX_phot = _compose_depol(p_2q, _t2_depol(two_q_dur))
    p_em      = (4.0 / 3.0) * (1.0 - emf)
    p_phot    = _compose_depol(_compose_depol(p_CX_phot, p_em), fib_depol)

    # ── Werner fidelity (independent depol on each Bell-pair qubit) ───────
    fidelity = (1.0 - p_mem) * (1.0 - p_phot) + p_mem * p_phot / 3.0
    fidelity = min(max(fidelity, 0.25), 1.0)

    # ── Photon survival per path ──────────────────────────────────────────
    p_survive = (
        (1.0 - init_pl)
        * (1.0 - ph_loss) ** sim_len_km
        * coll
        * coup_eff
    )
    p_survive = min(max(p_survive, 0.0), 1.0)

    # bsm_factor: deterministic CNOT+H+measure = 1.0, Pauli-tensor = 0.5
    bsm_factor = 1.0 if det_bsm else 0.5
    success_probability = min(bsm_factor * p_survive ** 2, 1.0)
    # Avoid division by zero in geometric draws; keep ≥ 1e-12
    success_probability = max(success_probability, 1e-12)

    # ── Gate-limited attempt rate ─────────────────────────────────────────
    total_gate_ns = one_q_dur + two_q_dur
    attempt_rate_hz = 1e9 / total_gate_ns if total_gate_ns > 0.0 else 1e6

    log.info(
        "EPR model: fidelity=%.5f  p_herald=%.5f  rate_hz=%.3e  "
        "(p_mem=%.5f  p_phot=%.5f  p_survive=%.5f  bsm_factor=%.1f)",
        fidelity, success_probability, attempt_rate_hz,
        p_mem, p_phot, p_survive, bsm_factor,
    )
    return fidelity, success_probability, attempt_rate_hz
