#!/usr/bin/env python3
"""Regression tests: no Clock may outlive the protocol that started it.

Background
----------
``BSMProtocol`` and ``ControllerProtocol`` start a NetSquid ``Clock`` that
is built with ``max_ticks=-1``, i.e. it reschedules its tick event for
ever.  Each protocol stops its clock at the end of its ``run()`` loop, but
teardown (``DQCProtocol.run()``) calls ``stop()`` on those protocols as
soon as the active QPUs are done, which discards the generator wherever it
is parked -- routinely between ``clk.start()`` and the matching
``clk.stop()``.

An orphaned clock keeps injecting events into the shared engine.  Since
``ns.sim_run()`` returns only once the event queue drains, the *next*
simulated run never terminates: pytest hangs with every protocol already
stopped, which makes the stall very hard to locate.

These tests pin the invariant at both levels: the unit level (stopping a
protocol stops its clock) and the integration level (a multi-run
simulation terminates and leaves no clock running).
"""
import os
import sys

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import netsquid as ns  # noqa: E402
from netsquid.components.clock import Clock  # noqa: E402

DQC_DIR = os.path.join(os.path.dirname(__file__), "..", "qnpack", "dqc")


@pytest.fixture
def in_dqc_dir():
    """Run inside qnpack/dqc so relative config paths resolve."""
    original = os.getcwd()
    os.chdir(DQC_DIR)
    try:
        yield
    finally:
        os.chdir(original)


def _running_clocks(net):
    """Names of every Clock still ticking in *net*."""
    return [
        f"{node.name}/{sub_name}"
        for node in net.nodes.values()
        for sub_name, sub in node.subcomponents.items()
        if isinstance(sub, Clock) and sub.is_running
    ]


def _build(sim, factory_enabled, num_runs=1):
    from qnpack.dqc import config as cfg_util
    from qnpack.dqc.frontends import load_frontend
    from qnpack.dqc.protocols import DQCProtocol

    sim.cfg.epr_factory.enabled = factory_enabled
    if factory_enabled:
        sim.cfg.epr_factory.pool_size_per_pair = 3
        sim.cfg.epr_factory.comm_qubits_reserved = 4
        sim.cfg.epr_factory.min_fidelity = 0.9
    sim.cfg.sim.iterations = num_runs
    sim.cfg.circuit.dist_commands_file = "commands/grover_4_2qpu.txt"
    sim.cfg.circuit.measure_qubits = "{1: [21, 20], 2: [21, 20]}"
    sim.cfg.memory.T1 = float(sim.cfg.memory.T1)
    sim.cfg.memory.T2 = float(sim.cfg.memory.T2)

    frontend, _ = load_frontend(sim.cfg.circuit, base_dir=None)
    topology_data = sim.load_topology()
    net, qpu_nodes, bsm_nodes, ctrl, qpu_info, bsm_info = \
        sim.setup_network_from_topology(topology_data)
    cfg_util.require_epr_factory_config(sim.cfg)

    protocol = DQCProtocol(
        sim.cfg, network=net, qpu_nodes=qpu_nodes, controller_node=ctrl,
        qpu_info=qpu_info, bsm_info=bsm_info, bsm_nodes=bsm_nodes,
        run_idx=0, frontend=frontend,
        q_switch=getattr(net, "q_switch", None),
        switch_node=getattr(net, "quantum_switch_node", None),
    )
    return net, protocol


def test_bsm_stop_halts_clock_mid_round(in_dqc_dir):
    """Stopping a BSMProtocol parked mid-round must stop its clock.

    This is the exact situation teardown creates: the clock has been
    started for an entanglement round and the generator is suspended
    waiting on a port, so the ``clk.stop()`` at the end of ``run()`` is
    never reached.
    """
    from qnpack.dqc.protocols.bsm import BSMProtocol
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    net, protocol = _build(sim, factory_enabled=False)

    bsm_protos = [p for p in protocol.subprotocols.values()
                  if isinstance(p, BSMProtocol)]
    assert bsm_protos, "expected at least one BSMProtocol"

    bsm = bsm_protos[0]
    bsm.start()
    # Simulate the mid-round state: clock running, generator parked.
    bsm.clk.start()
    assert bsm.clk.is_running

    bsm.stop()

    assert not bsm.clk.is_running, (
        "BSM clock still running after stop(); with max_ticks=-1 it would "
        "schedule tick events forever and hang the next ns.sim_run()"
    )


def test_controller_stop_halts_clock(in_dqc_dir):
    """Stopping a ControllerProtocol must stop its dispatch clock."""
    from qnpack.dqc.protocols.controller import ControllerProtocol
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    net, protocol = _build(sim, factory_enabled=False)

    ctrl = protocol.subprotocols["ControllerProtocol"]
    assert isinstance(ctrl, ControllerProtocol)

    ctrl.start()
    ctrl.clk.start()
    assert ctrl.clk.is_running

    ctrl.stop()

    assert not ctrl.clk.is_running, (
        "Controller clock still running after stop(); it would keep the "
        "event queue non-empty forever"
    )


@pytest.mark.parametrize("factory_enabled", [False, True])
def test_no_clock_survives_a_run(in_dqc_dir, factory_enabled):
    """After a full run + teardown, no clock may still be ticking."""
    from qnpack.dqc.sim import DQCSimulation

    ns.sim_reset()
    sim = DQCSimulation()
    net, protocol = _build(sim, factory_enabled=factory_enabled)

    protocol.start()
    ns.sim_run()
    protocol.stop()

    stranded = _running_clocks(net)
    assert not stranded, f"clocks still running after teardown: {stranded}"


@pytest.mark.parametrize("factory_enabled", [False, True])
def test_multi_run_simulation_terminates(in_dqc_dir, factory_enabled):
    """Several sequential runs must all terminate.

    A clock leaked by run *n* only manifests as a hang in run *n+1*, so a
    single run is not enough to catch the regression.
    """
    import random

    from qnpack.dqc.sim import DQCSimulation

    # Seed 50 deterministically reproduced the original hang.
    random.seed(50)
    ns.sim_reset()

    sim = DQCSimulation()
    sim.cfg.epr_factory.enabled = factory_enabled
    if factory_enabled:
        sim.cfg.epr_factory.pool_size_per_pair = 3
        sim.cfg.epr_factory.comm_qubits_reserved = 4
        sim.cfg.epr_factory.min_fidelity = 0.9
    sim.cfg.sim.iterations = 3
    sim.cfg.circuit.dist_commands_file = "commands/grover_4_2qpu.txt"
    sim.cfg.circuit.measure_qubits = "{1: [21, 20], 2: [21, 20]}"
    sim.cfg.memory.T1 = float(sim.cfg.memory.T1)
    sim.cfg.memory.T2 = float(sim.cfg.memory.T2)

    results = sim.start(num_runs=3)

    assert isinstance(results, list) and results, "expected result rows"
    assert len(results[0]["results"]) == 3, "expected one row per run"
