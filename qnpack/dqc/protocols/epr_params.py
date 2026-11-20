"""
protocols/epr_params.py
-----------------------
Compute the magic-state delay that embodies physical EPR generation losses.

The four loss parameters (init_photon_loss, photon_loss, collection_efficiency,
coupling_efficiency) all reduce the per-attempt herald probability p_herald.
A lower p_herald means more BSM attempts per Bell pair, so each pair takes
longer to arrive (rate decreases).  Modelling this as a magic-state delay
lets sweeps over photon-loss parameters run without the full physical BSM
simulation.

Physics
~~~~~~~
Photon survival probability per path (both photons from each QPU must survive):

    p_survive = (1 - init_photon_loss)
              × (1 - photon_loss)^simulated_length_km
              × collection_efficiency
              × coupling_efficiency

Herald probability per attempt (both photons must survive and be detected):

    bsm_factor = 1.0  if deterministic_bsm (CNOT-H-measure)
               = 0.5  if Pauli-tensor BSM (50% success per attempt)
    p_herald   = bsm_factor × p_survive²

Expected attempts per Bell pair = 1 / p_herald.

Each attempt is gate-limited: the QPU runs an H gate then a CNOT to generate
the photon, so the per-attempt cycle time is:

    cycle_ns = one_q_gate_duration + two_q_gate_duration

Magic-state delay (ns per Bell pair):

    delay_ns = cycle_ns / p_herald

This is a conservative estimate — it omits protocol messaging overhead (~2×)
but correctly captures the relative rate change as losses vary.  The trend
of p_target vs initpl is accurate; absolute decoherence is slightly under-
estimated.

Usage
~~~~~
    from qnpack.dqc.protocols.epr_params import magic_delay_from_losses

    delay_ns = magic_delay_from_losses(cfg)
    cfg["entanglement"]["method"]               = "magic"
    cfg["entanglement"]["magic_state_delay_ns"] = delay_ns
"""


def magic_delay_from_losses(cfg) -> float:
    """Return magic-state delay (ns/pair) that models physical EPR generation losses.

    Parameters
    ----------
    cfg : munch.Munch or dict-like
        Parsed simulation config with sections ``channel``, ``qpu``, ``bsm``,
        and ``gate_durations``.

    Returns
    -------
    float
        Delay in nanoseconds per Bell pair.  Scales as 1/p_herald so that
        higher losses → slower rate → more decoherence → lower p_target.
    """
    # ── Loss parameters ──────────────────────────────────────────────────────
    init_pl = float(cfg.channel.init_photon_loss)
    ph_loss = float(cfg.channel.photon_loss)
    sim_len = float(cfg.channel.simulated_length_km)
    coll    = float(cfg.qpu.collection_efficiency)
    coup    = float(cfg.bsm.coupling_efficiency)
    det_bsm = bool(cfg.bsm.deterministic_bsm)

    # ── Gate-limited attempt cycle ────────────────────────────────────────────
    cycle_ns = (float(cfg.gate_durations.one_q_gate_duration)
                + float(cfg.gate_durations.two_q_gate_duration))

    # ── Photon survival (each of the two paths must succeed) ─────────────────
    p_survive = (1.0 - init_pl) * (1.0 - ph_loss) ** sim_len * coll * coup
    p_survive = max(min(p_survive, 1.0), 0.0)

    # ── Herald probability ────────────────────────────────────────────────────
    bsm_factor = 1.0 if det_bsm else 0.5
    p_herald   = bsm_factor * p_survive ** 2
    p_herald   = max(p_herald, 1e-12)   # guard zero-loss corner case

    return cycle_ns / p_herald
