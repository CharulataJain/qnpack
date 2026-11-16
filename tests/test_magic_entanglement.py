"""Perfect direct Bell-pair delivery and DQC frontend coverage."""

from pathlib import Path

import netsquid as ns
import numpy as np
import pytest
from netsquid.components import QuantumMemory
from netsquid.nodes import Node
from netsquid.qubits import qubitapi as qapi
from netsquid_magic.magic_distributor import PerfectStateMagicDistributor
from netsquid_magic.model_parameters import PerfectModelParameters

from qnpack.dqc.sim import DQCSimulation
from qnpack.dqc.protocols.controller import ControllerProtocol
from qnpack.dqc.protocols.qpu import BSM_SUCCESS
from qnpack.oneG.lib.operators import create_meas_ops


DQC_DIR = Path(__file__).resolve().parents[1] / 'qnpack' / 'dqc'


def test_current_ket_bsm_success_state_matches_magic():
    """Both successful detector outcomes correct to the same Phi+ state."""
    ns.sim_reset()
    ns.set_qstate_formalism(ns.QFormalism.KET)
    qubit_dimension = len(ns.s0)
    initial = np.kron(ns.b00, ns.b00)
    # Reorder (memory A, photon A, memory B, photon B) into memory/photon axes.
    memory_photon = initial.reshape((qubit_dimension,) * 4)
    memory_photon = memory_photon.transpose(0, 2, 1, 3).reshape(
        len(ns.b00), len(ns.b00)
    )
    operators = create_meas_ops()
    target = np.outer(ns.b00, ns.b00.conj())

    for outcome in BSM_SUCCESS:
        index = outcome[0]
        postselected = memory_photon @ operators[index].arr.T
        memory_state = postselected @ postselected.conj().T
        memory_state /= np.trace(memory_state)
        correction = np.kron(np.eye(qubit_dimension), ns.X.arr)
        if outcome == BSM_SUCCESS[-1]:
            correction = np.kron(np.eye(qubit_dimension), ns.Z.arr) @ correction
        memory_state = correction @ memory_state @ correction.conj().T
        assert np.allclose(memory_state, target)


@pytest.mark.parametrize('formalism', ('KET', 'STAB'))
def test_perfect_distributor_delivers_phi_plus(formalism):
    ns.sim_reset()
    ns.set_qstate_formalism(getattr(ns.QFormalism, formalism))
    left = Node('left', qmemory=QuantumMemory('left_memory', num_positions=2))
    right = Node('right', qmemory=QuantumMemory('right_memory', num_positions=2))
    distributor = PerfectStateMagicDistributor(
        nodes=[left, right],
        model_params=PerfectModelParameters(state_delay=0),
    )
    before = ns.sim_time()
    distributor.add_delivery({left.ID: 1, right.ID: 0})
    ns.sim_run()
    first = left.qmemory.peek(1)[0]
    second = right.qmemory.peek(0)[0]
    assert qapi.fidelity([first, second], ns.b00, squared=True) == pytest.approx(1)
    assert ns.sim_time() == before
    distributor.stop()


@pytest.mark.parametrize('formalism', ('KET', 'STAB'))
@pytest.mark.parametrize('mode,source,measure', (
    ('tket', 'commands/ghz_6q_2qpu.txt', '{1: [20], 2: [20]}'),
    ('cisco', 'qasm/test_ghz.qasm', None),
    ('cisco_v2', 'qasm/test_magic_v2.qasm', None),
))
def test_magic_frontends(formalism, mode, source, measure, monkeypatch):
    ns.sim_reset()
    monkeypatch.chdir(DQC_DIR)

    def reject_bsm(*args, **kwargs):
        raise AssertionError('Magic generation started a BSM round')

    monkeypatch.setattr(
        ControllerProtocol, 'send_start_entanglement_to_bsm', reject_bsm
    )
    sim = DQCSimulation()
    sim.cfg.entanglement.method = 'magic'
    sim.cfg.sim.formalism = formalism
    sim.cfg.circuit.mode = mode
    if mode == 'tket':
        sim.cfg.circuit.dist_commands_file = source
        sim.cfg.circuit.measure_qubits = measure
    else:
        sim.cfg.circuit.qasm_file = source

    results = sim.start(num_runs=1)
    assert results[0]['counts']
    durations = sim._last_protocol.global_entanglement_durations
    assert durations
    assert all(duration == 0 for duration in durations.values())
