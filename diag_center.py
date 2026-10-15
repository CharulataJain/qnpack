import re, csv, sys
from pathlib import Path
from collections import Counter

QASM_DIR = Path("qnpack/dqc/qasm/plaquette_sweep")
CSV_DIR  = Path("qnpack/dqc/results/plaquette_sweep")

def measurement_order(qasm_path):
    order = {}
    pattern = re.compile(r"meas\[(\d+)\] = measure (_qcomp_qpu_\d+_r\d+c\d+)\[0\];")
    with qasm_path.open() as f:
        for line in f:
            m = pattern.match(line.strip())
            if m:
                order[int(m.group(1))] = m.group(2)
    return [order[i] for i in range(len(order))]

def chain_center(qasm_path):
    cx_pat = re.compile(r"cx (_q\w+)\[0\], (_q\w+)\[0\];")
    intra, comm_data = set(), {}
    with qasm_path.open() as f:
        for line in f:
            m = cx_pat.match(line.strip())
            if not m: continue
            a, b = m.groups()
            a_c, b_c = "qcomm" in a, "qcomm" in b
            if not a_c and not b_c:
                intra.add(frozenset((a, b)))
            elif a_c != b_c:
                comm, data = (a,b) if a_c else (b,a)
                comm_data.setdefault(comm, set()).add(data)
    adj = {}
    for edge in intra:
        a, b = tuple(edge)
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)
    by_qpu = {}
    for comm, datas in comm_data.items():
        qpu = re.search(r"_qpu_(\d+)_", comm).group(1)
        by_qpu.setdefault(qpu, Counter()).update(datas)
    bridge = {q: c.most_common(1)[0][0] for q, c in by_qpu.items()}
    bq = list(bridge.values())
    if len(bq) == 2:
        adj.setdefault(bq[0], set()).add(bq[1])
        adj.setdefault(bq[1], set()).add(bq[0])
    def ecc(src):
        dist = {src: 0}; frontier = [src]
        while frontier:
            nxt = []
            for u in frontier:
                for v in adj[u]:
                    if v not in dist: dist[v] = dist[u]+1; nxt.append(v)
            frontier = nxt
        return max(dist.values())
    eccs = {n: ecc(n) for n in adj}
    min_e = min(eccs.values())
    centers = [n for n, e in eccs.items() if e == min_e]
    return centers, adj

# Check 2QPU n=10 1D
qasm = QASM_DIR / "9qubit_2qpu_plaq121_obc_L9_g1.000_dt0.1000_n10.qasm"
mord = measurement_order(qasm)
print("meas order (2QPU 1D n=10):")
for i, r in enumerate(mord): print(f"  meas[{i}] = {r}")
centers, adj = chain_center(qasm)
print(f"\ncenter(s): {centers}")
print(f"graph nodes: {sorted(adj.keys())}")
if centers:
    c = centers[0]
    if c in mord:
        print(f"center meas index: {mord.index(c)}")
    else:
        print(f"CENTER NOT IN MEAS ORDER — it's a comm qubit!")

# Per-column P(1) from CSV at n=10
csv_p = QASM_DIR.parent.parent / "results/plaquette_sweep/1d_ideal/1d_ideal_n10.csv"
cols = {f"meas_{i}": [] for i in range(9)}
with csv_p.open() as f:
    for row in csv.DictReader(f):
        for k in cols:
            v = row.get(k,"").strip()
            if v: cols[k].append(int(v))
print("\nP(meas_i=1) from CSV 2QPU ideal n=10:")
for k, vals in cols.items():
    if vals: print(f"  {k}: {sum(vals)/len(vals):.4f} ({len(vals)} runs)")
