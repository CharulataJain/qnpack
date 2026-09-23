"""
frontends/__init__.py
---------------------
Frontend registry.  Import ``load_frontend`` to get the correct
frontend instance and resolved source path for a given circuit config.

Supported modes
---------------
    'tket'     — dist_commands.txt or JSON schedule  (TketFrontend)
    'cisco'    — QASM 3.0 file path, v1 naming       (QASM3Frontend)
    'cisco_v2' — QASM 3.0 file path, v2 naming       (QASM3V2Frontend)
                 (``_qcomp_qpu_``/``_qcomm_qpu_`` register names)
"""

import os
from .tket_frontend import TketFrontend
from .qasm3_frontend import QASM3Frontend
from .qasm3v2_frontend import QASM3V2Frontend

_REGISTRY = {
    "tket":     TketFrontend,
    "cisco":    QASM3Frontend,
    "cisco_v2": QASM3V2Frontend,
}

# Maps mode -> which circuit_cfg field holds the source path
_SOURCE_FIELD = {
    "tket":     "dist_commands_file",
    "cisco":    "qasm_file",
    "cisco_v2": "qasm_file",
}


def load_frontend(circuit_cfg, base_dir=None):
    """Instantiate and load the appropriate frontend for *circuit_cfg*.

    Parameters
    ----------
    circuit_cfg : object
        Config object with at least a ``mode`` attribute and the
        mode-specific source-path attribute (see ``_SOURCE_FIELD``).
    base_dir : str | None
        Optional directory prepended to the source path.

    Returns
    -------
    tuple[BaseFrontend, str]
        ``(frontend, resolved_source_path)``
    """
    mode = getattr(circuit_cfg, 'mode', 'tket')

    cls = _REGISTRY.get(mode)
    if cls is None:
        raise ValueError(
            f"Unknown circuit mode {mode!r}. "
            f"Valid modes: {sorted(_REGISTRY.keys())}"
        )

    source_field = _SOURCE_FIELD[mode]
    source = getattr(circuit_cfg, source_field, None)
    if source is None:
        raise ValueError(
            f"circuit.mode={mode!r} requires 'circuit.{source_field}' "
            f"to be set in parameters.yml"
        )

    if base_dir is not None:
        source = os.path.join(base_dir, source)

    frontend = cls()
    frontend.load(source)   # uniform call — both frontends implement load()

    return frontend, source