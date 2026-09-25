"""Timing from a paired entanglement request to an available Bell pair."""

import netsquid as ns


class EntanglementTimingTracker:
    """Record one duration per remote Bell pair after both halves are ready."""

    def __init__(self):
        self.started_ns = {}
        self.participants = {}
        self.ready_ns = {}
        self.durations_s = {}

    def start(self, label, qpu_ids, time_ns):
        if label in self.started_ns:
            raise RuntimeError(f'Duplicate entanglement request {label!r}')
        self.started_ns[label] = time_ns
        self.participants[label] = frozenset(qpu_ids)
        self.ready_ns[label] = {}

    def endpoint_ready(self, label, qpu_id, time_ns):
        """Finish when the last endpoint has its corrected Bell-pair half."""
        if label not in self.started_ns:
            raise RuntimeError(f'Unknown entanglement request {label!r}')
        if qpu_id not in self.participants[label]:
            raise RuntimeError(f'Unexpected QPU {qpu_id} for {label!r}')
        ready = self.ready_ns[label]
        if qpu_id in ready:
            raise RuntimeError(f'QPU {qpu_id} reported {label!r} twice')
        ready[qpu_id] = time_ns
        if ready.keys() == self.participants[label]:
            self._finish(label, max(ready.values()))

    def magic_ready(self, label, time_ns):
        """The distributor has placed both perfect halves in QPU memories."""
        if label not in self.started_ns:
            raise RuntimeError(f'Unknown entanglement request {label!r}')
        self._finish(label, time_ns)

    def request_time_ns(self, label):
        return self.started_ns[label]

    def _finish(self, label, time_ns):
        if label in self.durations_s:
            raise RuntimeError(f'Entanglement request {label!r} completed twice')
        duration_ns = time_ns - self.started_ns[label]
        if duration_ns < 0:
            raise RuntimeError(f'Negative entanglement duration for {label!r}')
        self.durations_s[label] = duration_ns / ns.SECOND
