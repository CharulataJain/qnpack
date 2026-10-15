"""Plaquette sweep plot: classical reference + 1QPU Aer + 2QPU DQC (det. BSM).

2QPU results use deterministic_bsm: true so EJPP teleportation succeeds every
time, restoring the expected center-qubit wave.
"""
import sys, csv
from pathlib import Path
sys.path.insert(0, "qnpack/dqc/experiments/plaquette")

import matplotlib.pyplot as plt
from plaquette_chain_121 import build_plaquette_circuit_121
from plaquette_2d_121 import build_plaquette_circuit_2d_121
from qiskit.quantum_info import Statevector

ROOT = Path("qnpack/dqc")
OUT_1QPU   = ROOT / "results" / "plaquette_sweep"
OUT_DETBSM = ROOT / "results" / "plaquette_sweep_detbsm"
N_STEPS_SPARSE = [0, 2, 4, 6, 8, 10]
CENTER = 4

def classical_ref(lattice):
    xs, ys = [], []
    for n in range(0, 21):
        if lattice == "1d":
            qc = build_plaquette_circuit_121(9, 0.1, n, 1.0)
        else:
            qc = build_plaquette_circuit_2d_121(3, 3, 0.1, n, 1.0)
        sv = Statevector(qc)
        xs.append(n)
        ys.append(sv.probabilities([CENTER])[1])
    return xs, ys

def read_p1_aer(lattice, noise_key, n):
    tag = f"1qpu_{lattice}_{noise_key}"
    p = OUT_1QPU / tag / f"{tag}_n{n}.csv"
    if not p.exists():
        return None
    vals = []
    with p.open() as f:
        for row in csv.DictReader(f):
            v = row.get(f"meas_{CENTER}", "").strip()
            if v:
                vals.append(int(v))
    return sum(vals) / len(vals) if vals else None

def read_p1_dqc(lattice, noise_key, n):
    tag = f"{lattice}_{noise_key}"
    p = OUT_DETBSM / tag / f"{tag}_n{n}.csv"
    if not p.exists():
        return None
    vals = []
    with p.open() as f:
        for row in csv.DictReader(f):
            v = row.get("meas_4", "").strip()
            if v:
                vals.append(int(v))
    return sum(vals) / len(vals) if vals else None

# Categorical palette: black, blue, orange, green — validated for CVD separation
COLORS = {
    "ref":       "#000000",
    "1qpu_ideal": "#1f6fbd",
    "1qpu_noisy": "#e07b00",
    "2qpu_ideal": "#1a8c4e",
}

fig, axes = plt.subplots(1, 2, figsize=(13, 5), sharey=False)

for ax, lattice, title in zip(
    axes,
    ["1d", "2d"],
    ["1D chain (L=9, OBC)", "2D lattice (3×3, OBC)"],
):
    print(f"\n=== {title} ===")

    ref_x, ref_y = classical_ref(lattice)
    ax.plot(ref_x, ref_y, "-", lw=1.8, color=COLORS["ref"],
            label="Classical (exact)", zorder=5)

    for noise_key, label, color, marker in [
        ("ideal", "1QPU ideal (Aer)", COLORS["1qpu_ideal"], "o"),
        ("noisy", "1QPU noisy (Aer)", COLORS["1qpu_noisy"], "s"),
    ]:
        xs, ys = [], []
        for n in N_STEPS_SPARSE:
            p = read_p1_aer(lattice, noise_key, n)
            if p is not None:
                xs.append(n); ys.append(p)
                print(f"  1QPU {noise_key} n={n}: {p:.4f}")
        ax.plot(xs, ys, marker=marker, ls="none", color=color, ms=7, label=label)

    # 2QPU ideal only (det. BSM) — noisy 2D not yet collected
    xs, ys = [], []
    for n in N_STEPS_SPARSE:
        p = read_p1_dqc(lattice, "ideal", n)
        if p is not None:
            xs.append(n); ys.append(p)
            print(f"  2QPU DQC ideal n={n}: {p:.4f}")
    if xs:
        ax.plot(xs, ys, marker="^", ls="none", color=COLORS["2qpu_ideal"],
                ms=8, label="2QPU DQC ideal (det. BSM)")

    ax.axhline(0.5, color=COLORS["2qpu_ideal"], ls="--", lw=0.8, alpha=0.5, zorder=1)
    ax.set_xlabel("Trotter step count")
    ax.set_ylabel("P(center qubit = 1)")
    ax.set_title(title)
    ax.set_xlim(-0.5, 20.5)
    ax.set_ylim(-0.02, 0.58)
    ax.set_xticks(range(0, 21, 2))
    ax.grid(True, alpha=0.25, lw=0.8)
    ax.legend(fontsize=8, framealpha=0.9)

fig.suptitle(
    "Center-site excitation probability: 1QPU (Aer) vs 2QPU DQC (deterministic BSM)",
    fontsize=11,
)
fig.tight_layout()
out_dir = OUT_1QPU
for ext in ("png", "svg"):
    out = out_dir / f"plaquette_1qpu_vs_2qpu_center_p1.{ext}"
    fig.savefig(out, dpi=200)
    print(f"Saved {out}")
plt.close()
