"""Request-to-ready timing and hierarchical Bell-pair averages."""

from pathlib import Path

import netsquid as ns
import pytest

from qnpack.dqc.protocols.entanglement_timing import EntanglementTimingTracker
from qnpack.dqc.protocols.switch import SwitchedEntanglementWorker
from qnpack.dqc.results import (
    mean_entanglement_time_across_runs,
    mean_entanglement_time_per_run,
    to_dataframe,
)
from qnpack.dqc.sim import DQCSimulation

DQC_DIR = Path(__file__).resolve().parents[1] / 'qnpack' / 'dqc'


def test_pair_finishes_when_both_endpoints_are_ready():
    tracker = EntanglementTimingTracker()
    start_ns = ns.SECOND
    tracker.start('pair', {1, 2}, start_ns)
    tracker.endpoint_ready('pair', 1, start_ns + ns.NANOSECOND)
    assert tracker.durations_s == {}
    tracker.endpoint_ready('pair', 2, start_ns + ns.SECOND)
    assert tracker.durations_s['pair'] == pytest.approx(1)


def test_across_runs_uses_per_run_means():
    rows = [
        {'run': 0, 'entanglement_durations': {'a': 1, 'b': 3}},
        {'run': 1, 'entanglement_durations': {'c': 10}},
    ]
    assert mean_entanglement_time_per_run(rows[0]) == pytest.approx(2)
    assert mean_entanglement_time_per_run(rows[1]) == pytest.approx(10)
    assert mean_entanglement_time_across_runs(rows) == pytest.approx(6)

    entry = {
        'noise_label': 'test', 'col_names': [], 'results': rows,
        'mean_entl_time_s': mean_entanglement_time_across_runs(rows),
        'two_q_prob': 0, 'one_q_prob': 0, 'emission_fidelity': 1,
        'collection_efficiency': 1, 'T1': 1, 'T2': 1,
        'one_q_gate_duration': 0, 'two_q_gate_duration': 0,
        'photon_loss': 0, 'init_photon_loss': 0, 'fiber_depolar_rate': 0,
    }
    df = to_dataframe([entry])
    assert df['entl_time_s'].tolist() == pytest.approx([2, 10])
    assert df['mean_entl_time_s'].tolist() == pytest.approx([6, 6])


def test_bsm_duration_includes_forced_retry(monkeypatch, tmp_path):
    original_emit = SwitchedEntanglementWorker._emit_photon
    failed_once = set()

    def fail_first_emission(self, position):
        if self.qpu_protocol.qpu_id not in failed_once:
            failed_once.add(self.qpu_protocol.qpu_id)
            return False
        return original_emit(self, position)

    monkeypatch.setattr(
        SwitchedEntanglementWorker, '_emit_photon', fail_first_emission
    )
    monkeypatch.chdir(tmp_path)
    sim = DQCSimulation(
        parameter_file=str(DQC_DIR / 'parameters.yml'),
        base_dir=str(DQC_DIR), output_dir=str(tmp_path),
    )
    sim.cfg.sim.formalism = 'KET'
    sim.cfg.circuit.mode = 'cisco_v2'
    sim.cfg.circuit.qasm_file = 'qasm/test_magic_v2.qasm'
    sim.cfg.entanglement.method = 'bsm'
    retry_wait_ns = sim.cfg.gate_durations.two_q_gate_duration
    sim.cfg.bsm.retry_duration = retry_wait_ns

    result = sim.start(num_runs=1)[0]
    durations = result['results'][0]['entanglement_durations']
    assert failed_once == {1, 2}
    assert len(durations) == 2
    assert max(durations.values()) >= sim.cfg.bsm.detection_window / ns.SECOND
