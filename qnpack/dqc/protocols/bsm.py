"""
protocols/bsm.py
----------------
BSMProtocol — runs on a Bell State Measurement node.

Listens for 'start_entanglement' messages from the Controller, triggers
the gated quantum detector, and sends BSM results back to the QPU nodes.
"""

import logging
import netsquid as ns
from netsquid.protocols.nodeprotocols import NodeProtocol
from netsquid.components.component import Message

log = logging.getLogger(__name__)

# BSM detector output values that indicate successful Bell measurement
BSM_SUCCESS = [[2], [3]]


class BSMProtocol(NodeProtocol):
    """Protocol running on a BSM (Bell State Measurement) node.

    Listens for ``'start_entanglement'`` control messages from the
    :class:`~.controller.ControllerProtocol`, drives the gated quantum
    detector, and forwards BSM results to both QPU nodes.

    Parameters
    ----------
    node : Node
        The BSM node this protocol runs on.
    bsm_id : int
        1-based BSM node index.
    cfg : Munch
        Simulation configuration (must expose ``cfg.bsm.max_emission_retries``
        and ``cfg.bsm.detection_window``).
    channel_length : float
        Length of the quantum channel (km).  Currently informational only.
    name : str or None
        Protocol name (auto-generated if None).
    """

    def __init__(self, node, bsm_id, cfg=None, channel_length=1, name=None):
        super().__init__(node, name=name)
        self.bsm_id = bsm_id
        self.cfg = cfg
        self.channel_length = channel_length
        self.ctrl_port = self.node.ports["ctrl_port"]
        self.detector = self.node.subcomponents[f"{self.node.name}_Detector"]
        self.clk = self.node.subcomponents[f"{self.node.name}_CLK"]

    def stop(self):
        """Stop the protocol **and** its free-running detection clock.

        ``run()`` stops ``self.clk`` at the end of each entanglement round,
        but that line is only reached on the normal path.  Teardown (see
        :meth:`~.core.DQCProtocol.run`) calls ``stop()`` on every BSM as soon
        as the active QPUs report done, which discards the generator wherever
        it happens to be parked — frequently mid-round, after ``clk.start()``
        and before the matching ``clk.stop()``.

        The clock is built with ``max_ticks=-1``, so once orphaned it keeps
        scheduling tick events forever.  ``ns.sim_run()`` returns only when
        the event queue drains, so the *next* run never terminates: the
        simulation hangs with every protocol already stopped.

        Tying the clock's lifetime to the protocol's makes teardown total,
        regardless of where the generator was suspended.
        """
        super().stop()
        self._stop_clock()

    def reset(self):
        """Reset the protocol, ensuring the clock does not survive the reset."""
        super().reset()
        self._stop_clock()

    def _stop_clock(self):
        """Idempotently halt the detection clock."""
        clk = getattr(self, "clk", None)
        if clk is not None and clk.is_running:
            clk.stop()
            log.debug(
                f"[{self.node.name}] Detection clock stopped during teardown "
                f"(num_ticks={clk.num_ticks})"
            )

    def _send_result_to_qpus(self, result_msg, factory=False):
        """Broadcast a BSM result message to both QPU nodes.

        When *factory* is ``True`` the message is emitted on the dedicated
        EPR-factory classical plane (``factory_BSM_res_to_*``) so that the
        factory worker protocols receive it without contending with the
        circuit-execution workers on the shared ports.
        """
        if factory:
            port_names = ("factory_BSM_res_to_left", "factory_BSM_res_to_right")
        else:
            port_names = ("BSM_res_to_left", "BSM_res_to_right")
        for port_name in port_names:
            if port_name in self.node.ports:
                self.node.ports[port_name].tx_output(result_msg)

    def _send_clock_to_qpus(self, clk_msg, factory=False):
        """Broadcast a clock tick to both QPU nodes on the correct plane."""
        if factory:
            port_names = ("factory_clk_to_left", "factory_clk_to_right")
        else:
            port_names = ("clk_to_left", "clk_to_right")
        for port_name in port_names:
            if port_name in self.node.ports:
                self.node.ports[port_name].tx_output(clk_msg)

    def run(self):
        log.debug(
            f"[{self.node.name}] BSMProtocol started, waiting for "
            f"Start Entanglement messages..."
        )

        while True:
            yield self.await_port_input(self.ctrl_port)
            msg = self.ctrl_port.rx_input()

            if msg is None:
                continue

            item = msg.items[0]
            msg_type = item.get('type')

            if msg_type not in ('start_entanglement', 'factory_start_entanglement'):
                log.debug(
                    f"[{self.node.name}] Received unknown message type: {msg_type}"
                )
                continue

            start_label = item.get('start_label')
            qpu_ids = item.get('qpu_ids', [])
            is_factory = (msg_type == 'factory_start_entanglement')

            log.debug(
                f"[{self.node.name}] Received "
                f"{'factory ' if is_factory else ''}'Start Entanglement' "
                f"for start_label={start_label}, QPUs={qpu_ids}"
            )

            max_retries = self.cfg.bsm.max_emission_retries

            if not self.clk.is_running:
                self.clk.start()
            log.debug(
                f"{ns.sim_time()} [{self.node.name}] Clock "
                f"running={self.clk.is_running}, "
                f"num_ticks={self.clk.num_ticks}"
            )

            yield self.await_port_output(self.clk.ports["cout"])
            clk_msg = self.clk.ports["cout"].rx_output()

            self._send_clock_to_qpus(clk_msg, factory=is_factory)
            log.debug(f"[{self.node.name}] Sent clock tick to left & right QPUs")

            retries = 0
            success = False
            detection_window = self.cfg.bsm.detection_window
            log.debug(f"[{self.node.name}] detection_window={detection_window} ns")

            while retries <= max_retries:
                log.debug(
                    f"[{self.node.name}] Detection attempt "
                    f"{retries}/{max_retries} (time={ns.sim_time()})"
                )

                self.detector.ports["gate_trigger"].tx_input(
                    f"Trigger BSM start_label={start_label}"
                )

                wait_detector_dead = self.await_timer(duration=detection_window)
                wait_detected = self.await_port_output(self.detector.ports["cout0"])
                evexpr = yield wait_detector_dead | wait_detected

                if evexpr.second_term.value:
                    m = self.detector.ports["cout0"].rx_output()
                    bsm_data = m.items if m is not None else None
                    log.debug(f"[{self.node.name}] Detector output: {bsm_data}")

                    if bsm_data is not None and bsm_data in BSM_SUCCESS:
                        log.debug(
                            f"[{self.node.name}] BSM SUCCESS "
                            f"(start_label={start_label}, retries={retries})"
                        )
                        result_msg = Message(items={
                            'type': 'bsm_result',
                            'status': 'success',
                            'data': bsm_data,
                            'start_label': start_label,
                            'retries': retries,
                            'bsm_node': self.node.name,
                        })
                        self._send_result_to_qpus(result_msg, factory=is_factory)
                        success = True
                        break
                    else:
                        log.debug(
                            f"[{self.node.name}] BSM NOT_DETECTED (data={bsm_data})"
                        )
                        result_msg = Message(items={
                            'type': 'bsm_result',
                            'status': 'not_detected',
                            'data': bsm_data,
                            'start_label': start_label,
                            'retries': retries,
                            'bsm_node': self.node.name,
                        })
                        self._send_result_to_qpus(result_msg, factory=is_factory)
                else:
                    log.debug(
                        f"[{self.node.name}] Detector timeout "
                        f"(detection_window={detection_window} ns at {ns.sim_time()})"
                    )
                    result_msg = Message(items={
                        'type': 'bsm_result',
                        'status': 'detector_failure',
                        'data': None,
                        'start_label': start_label,
                        'retries': retries,
                        'bsm_node': self.node.name,
                    })
                    self._send_result_to_qpus(result_msg, factory=is_factory)

                retries += 1

                if retries <= max_retries:
                    if not self.clk.is_running:
                        self.clk.start()
                    yield self.await_port_output(self.clk.ports["cout"])
                    retry_clk_msg = self.clk.ports["cout"].rx_output()
                    self._send_clock_to_qpus(retry_clk_msg, factory=is_factory)
                    log.debug(
                        f"[{self.node.name}] Sent retry clock tick "
                        f"(attempt {retries}) to QPUs"
                    )

            if self.clk.is_running:
                self.clk.stop()

            if not success:
                log.warning(
                    f"[{self.node.name}] Entanglement FAILED "
                    f"after {max_retries} retries "
                    f"(start_label={start_label})"
                )

            log.debug(
                f"[{self.node.name}] Entanglement round complete "
                f"for start_label={start_label} "
                f"(success={success}, retries={retries})"
            )
