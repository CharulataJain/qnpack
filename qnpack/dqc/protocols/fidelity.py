"""
protocols/fidelity.py
---------------------
Fidelity estimation for entangled Bell pairs under T1/T2 decoherence.

Physics background
~~~~~~~~~~~~~~~~~~
A maximally entangled Bell pair shared between two quantum processing units
(QPUs) degrades over time due to amplitude damping (T1) and dephasing (T2)
in the quantum memories that store the constituent qubits.

For a *single* qubit undergoing independent T1 and T2 noise, the
relevant decay channels are:

* **Amplitude damping** (T1): the excited state |1⟩ decays to |0⟩ with
  probability  p₁(t) = 1 − exp(−t / T1).
* **Dephasing** (T2): off-diagonal elements of the density matrix decay
  as  exp(−t / T2),  where  1/T2 = 1/(2·T1) + 1/Tφ  (pure dephasing Tφ).

When *both* qubits of a Bell pair decohere independently under the same
noise model, the entangled-state fidelity evolves as:

    F(t) = ¼ · (1 + exp(−2t/T1) + 2·exp(−2t/T2))        [symmetric]

For asymmetric noise (different T1/T2 on each QPU, or different storage
durations):

    F(t) = ¼ · (1 + exp(−tₐ/T1ₐ)·exp(−t_b/T1_b)
                   + 2·exp(−tₐ/T2ₐ)·exp(−t_b/T2_b))     [asymmetric]

The ``FidelityTracker`` class provides methods to evaluate these
expressions and to determine the maximum age at which a Bell pair
remains above a configurable fidelity threshold.
"""

import math
import logging

log = logging.getLogger(__name__)


class FidelityTracker:
    """Estimate Bell-pair fidelity decay based on T1/T2 noise parameters.

    Parameters
    ----------
    T1 : float
        Amplitude-damping time constant in nanoseconds.
    T2 : float
        Dephasing time constant in nanoseconds.  Must satisfy T2 ≤ 2·T1.
    min_fidelity : float, optional
        Fidelity threshold below which a pair is considered stale
        (default 0.9).
    """

    def __init__(self, T1: float, T2: float, min_fidelity: float = 0.9):
        if T1 <= 0 or T2 <= 0:
            raise ValueError(
                f"T1 and T2 must be positive; got T1={T1}, T2={T2}"
            )
        if T2 > 2 * T1:
            raise ValueError(
                f"T2 must satisfy T2 ≤ 2·T1; got T1={T1}, T2={T2}"
            )
        if not (0.0 < min_fidelity < 1.0):
            raise ValueError(
                f"min_fidelity must be in (0, 1); got {min_fidelity}"
            )

        self.T1 = T1
        self.T2 = T2
        self.min_fidelity = min_fidelity

        # Pre-compute and cache the max useful age
        self._max_useful_age: float | None = None

        log.debug(
            "FidelityTracker created: T1=%.1f ns, T2=%.1f ns, "
            "min_fidelity=%.3f",
            T1, T2, min_fidelity,
        )

    # ------------------------------------------------------------------
    # Symmetric fidelity model
    # ------------------------------------------------------------------

    def estimated_fidelity(self, age_ns: float) -> float:
        """Compute Bell-pair fidelity after *age_ns* nanoseconds (symmetric).

        Both qubits are assumed to have the same T1/T2 parameters and to
        have been stored for the same duration *age_ns*.

        Parameters
        ----------
        age_ns : float
            Time elapsed since entanglement generation, in nanoseconds.

        Returns
        -------
        float
            Estimated fidelity in [0.25, 1.0].
        """
        if age_ns <= 0.0:
            return 1.0
        t = age_ns
        return 0.25 * (
            1.0
            + math.exp(-2.0 * t / self.T1)
            + 2.0 * math.exp(-2.0 * t / self.T2)
        )

    # ------------------------------------------------------------------
    # Asymmetric fidelity model
    # ------------------------------------------------------------------

    @staticmethod
    def estimated_fidelity_asymmetric(
        age_ns_A: float,
        age_ns_B: float,
        T1_A: float,
        T2_A: float,
        T1_B: float,
        T2_B: float,
    ) -> float:
        """Compute Bell-pair fidelity for the asymmetric case.

        Each qubit may have different noise parameters and may have been
        stored for different durations (e.g. if generation timestamps
        differ or QPUs have distinct hardware).

        Parameters
        ----------
        age_ns_A : float
            Storage time of qubit A in nanoseconds.
        age_ns_B : float
            Storage time of qubit B in nanoseconds.
        T1_A, T2_A : float
            Noise parameters for qubit A in nanoseconds.
        T1_B, T2_B : float
            Noise parameters for qubit B in nanoseconds.

        Returns
        -------
        float
            Estimated fidelity in [0.25, 1.0].
        """
        if age_ns_A <= 0.0 and age_ns_B <= 0.0:
            return 1.0
        tA = max(age_ns_A, 0.0)
        tB = max(age_ns_B, 0.0)
        return 0.25 * (
            1.0
            + math.exp(-tA / T1_A) * math.exp(-tB / T1_B)
            + 2.0 * math.exp(-tA / T2_A) * math.exp(-tB / T2_B)
        )

    # ------------------------------------------------------------------
    # Maximum useful age
    # ------------------------------------------------------------------

    def max_useful_age_ns(self) -> float:
        """Solve for the age *t* at which F(t) = min_fidelity (symmetric).

        Uses bisection search to avoid a scipy dependency.  The result is
        cached after the first call.

        Returns
        -------
        float
            Maximum age in nanoseconds before fidelity drops below
            ``min_fidelity``.  Returns ``float('inf')`` if fidelity at
            t = 0 is already below the threshold (should not happen with
            valid parameters, since F(0) = 1.0).
        """
        if self._max_useful_age is not None:
            return self._max_useful_age

        # F(0) = 1.0, which should be above min_fidelity.
        # F(t → ∞) → 0.25.  So a root exists iff min_fidelity > 0.25.
        if self.min_fidelity <= 0.25:
            self._max_useful_age = float("inf")
            log.debug(
                "min_fidelity=%.3f ≤ 0.25; max_useful_age = inf",
                self.min_fidelity,
            )
            return self._max_useful_age

        # Bracket: find an upper bound where F(t_hi) < min_fidelity.
        t_lo = 0.0
        t_hi = max(self.T1, self.T2)  # start with the longer time constant
        while self.estimated_fidelity(t_hi) >= self.min_fidelity:
            t_hi *= 2.0

        # Bisection search (converge to ~0.1 ns precision)
        for _ in range(200):
            t_mid = 0.5 * (t_lo + t_hi)
            if t_hi - t_lo < 0.1:
                break
            if self.estimated_fidelity(t_mid) >= self.min_fidelity:
                t_lo = t_mid
            else:
                t_hi = t_mid

        self._max_useful_age = 0.5 * (t_lo + t_hi)
        log.debug(
            "max_useful_age = %.1f ns (T1=%.1f, T2=%.1f, min_fid=%.3f)",
            self._max_useful_age, self.T1, self.T2, self.min_fidelity,
        )
        return self._max_useful_age

    # ------------------------------------------------------------------
    # Staleness check
    # ------------------------------------------------------------------

    def is_stale(self, generation_time_ns: float, current_time_ns: float) -> bool:
        """Return True if a Bell pair has decohered below min_fidelity.

        Parameters
        ----------
        generation_time_ns : float
            Simulation time (in nanoseconds) at which the pair was created.
        current_time_ns : float
            Current simulation time in nanoseconds.

        Returns
        -------
        bool
            True if the pair's estimated fidelity is below the threshold.
        """
        age = current_time_ns - generation_time_ns
        if age < 0.0:
            log.warning(
                "Negative age detected: generation_time=%.1f > "
                "current_time=%.1f; treating pair as fresh",
                generation_time_ns, current_time_ns,
            )
            return False
        return age > self.max_useful_age_ns()

    # ------------------------------------------------------------------
    # Representation
    # ------------------------------------------------------------------

    def __repr__(self) -> str:
        return (
            f"FidelityTracker(T1={self.T1}, T2={self.T2}, "
            f"min_fidelity={self.min_fidelity})"
        )
