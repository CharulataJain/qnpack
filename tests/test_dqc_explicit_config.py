"""Physical DQC settings must come from configuration, with no silent fallback."""

from pathlib import Path

import pytest

from qnpack.common.config import Config, MissingConfigError
from qnpack.dqc import config as config_util
from qnpack.dqc.network.topology import create_bsm_nodes, load_topology


DQC_DIR = Path(__file__).resolve().parents[1] / 'qnpack' / 'dqc'


def configured():
    return Config(str(DQC_DIR / 'parameters.yml'))


def test_formalism_must_be_declared():
    cfg = configured()
    del cfg.sim['formalism']
    with pytest.raises(MissingConfigError, match='formalism'):
        config_util.resolve_formalism(cfg)


@pytest.mark.parametrize('key', (
    'detection_window', 'system_delay', 'coupling_efficiency',
    'deterministic_bsm', 'detector_dead_time', 'error_on_fail',
))
def test_bsm_settings_must_be_declared(key):
    cfg = configured()
    cfg.entanglement.method = 'bsm'
    del cfg.bsm[key]
    with pytest.raises(MissingConfigError, match=key):
        config_util.require_entanglement_config(cfg)


def test_bsm_clock_uses_configured_frequency():
    cfg = configured()
    cfg.clock.HZ = cfg.clock.HZ / 2
    topology = load_topology(str(DQC_DIR / cfg.topology.file))
    nodes, _ = create_bsm_nodes(cfg, topology)
    assert nodes[0].subcomponents['BSM_Node1_CLK'].frequency == cfg.clock.HZ
