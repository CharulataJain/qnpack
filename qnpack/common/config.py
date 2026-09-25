import sys
import yaml
import munch
from qnpack.common.constants import Constants


class MissingConfigError(SystemExit):
    """Raised when a required configuration parameter is absent.

    Subclasses ``SystemExit`` so the simulation aborts immediately with a
    clear, actionable error message instead of continuing with a silent
    default value.
    """

    def __init__(self, section: str, key: str):
        msg = (
            f"\n{'=' * 60}\n"
            f"  MISSING REQUIRED CONFIGURATION\n"
            f"{'=' * 60}\n"
            f"  Section : {section}\n"
            f"  Key     : {key}\n"
            f"\n"
            f"  Please add '{key}' under the '{section}:' block in your\n"
            f"  parameters.yml file.  The simulation cannot proceed with\n"
            f"  a missing value — no hardcoded defaults are allowed.\n"
            f"{'=' * 60}\n"
        )
        super().__init__(msg)


_SENTINEL = object()


def require_cfg(cfg_section, key: str, section_name: str = "<unknown>"):
    """Read a **required** value from a config section, aborting if absent.

    This replaces ``getattr(cfg_section, key, <default>)`` throughout the
    DQC codebase.  Every simulation parameter must be explicitly specified
    in ``parameters.yml``; there are no silent fallback values.

    Values of ``0``, ``False``, and ``""`` are perfectly valid — only a
    genuinely missing key triggers the error.

    Parameters
    ----------
    cfg_section : object
        A ``Munch`` (or other attribute-bearing) config sub-object,
        e.g. ``cfg.qpu``, ``cfg.channel``.
    key : str
        The parameter name to look up.
    section_name : str
        Human-readable section label for the error message
        (e.g. ``"qpu"``, ``"channel"``).

    Returns
    -------
    object
        The value found in the config.

    Raises
    ------
    MissingConfigError
        If *key* is not present on *cfg_section*.
    """
    val = getattr(cfg_section, key, _SENTINEL)
    if val is _SENTINEL:
        raise MissingConfigError(section_name, key)
    return val


class Config:
    def __init__(self, config_file=Constants.DEFAULT_PARAM_FILE):
        self._config = yaml.safe_load(open(config_file))
        self._munch = munch.munchify(self._config)

    def __getattr__(self, name):
        return getattr(self._munch, name)

    def __str__(self):
        return yaml.safe_dump(self._munch)

    def _apply_fixed_params(self, fixed_params: dict):
        if not fixed_params:
            return False
    
        updated = False
    
        for section_name, params in fixed_params.items():
            if hasattr(self._munch, section_name):
                section = getattr(self._munch, section_name)
                for key, value in params.items():
                    if hasattr(section, key):
                        old_val = getattr(section, key)
                        setattr(section, key, value)
                        print(f"Updated {section_name}.{key}: {old_val} -> {value}")
                        updated = True
    
        return updated

