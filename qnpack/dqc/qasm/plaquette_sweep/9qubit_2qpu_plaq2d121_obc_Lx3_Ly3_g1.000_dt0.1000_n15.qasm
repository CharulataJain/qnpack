OPENQASM 3.0;
include "stdgates.inc";
gate entanglement _gate_q_0, _gate_q_1 {
  h _gate_q_0;
  cx _gate_q_0, _gate_q_1;
}
bit[9] meas;
bit[1] _clbit_qcomm_qpu_0_r0c0;
bit[1] _clbit_qcomm_qpu_1_r0c0;
bit[1] _clbit_qcomm_qpu_0_r0c1;
bit[1] _clbit_qcomm_qpu_1_r0c1;
bit[1] _clbit_qcomm_qpu_1_r0c2;
bit[1] _clbit_qcomm_qpu_0_r0c2;
bit[1] _clbit_qcomm_qpu_1_r0c3;
bit[1] _clbit_qcomm_qpu_0_r0c3;
bit[1] _clbit_qcomm_qpu_0_r0c4;
bit[1] _clbit_qcomm_qpu_1_r0c4;
qubit[1] _qcomp_qpu_0_r1c0;
qubit[1] _qcomp_qpu_0_r1c1;
qubit[1] _qcomp_qpu_0_r1c2;
qubit[1] _qcomp_qpu_1_r1c0;
qubit[1] _qcomp_qpu_1_r1c1;
qubit[1] _qcomm_qpu_0_r0c0;
qubit[1] _qcomm_qpu_1_r0c0;
qubit[1] _qcomm_qpu_0_r0c1;
qubit[1] _qcomm_qpu_1_r0c1;
qubit[1] _qcomp_qpu_0_r1c3;
qubit[1] _qcomm_qpu_1_r0c2;
qubit[1] _qcomm_qpu_0_r0c2;
qubit[1] _qcomm_qpu_1_r0c3;
qubit[1] _qcomm_qpu_0_r0c3;
qubit[1] _qcomm_qpu_0_r0c4;
qubit[1] _qcomm_qpu_1_r0c4;
qubit[1] _qcomp_qpu_1_r1c2;
qubit[1] _qcomp_qpu_1_r1c3;
qubit[1] _qcomp_qpu_0_r1c4;
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c0[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
u1(-0.03333333333333333) _qcomp_qpu_0_r1c4[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c3[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c4[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c2[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c4[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_1_r0c4[0], _qcomm_qpu_0_r0c4[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.01717216809816518) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c2[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
reset _qcomm_qpu_0_r0c3[0];
h _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  x _qcomm_qpu_0_r0c4[0];
}
reset _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_0_r1c4[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c4[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.0005055014314985111) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
cx _qcomp_qpu_0_r1c3[0], _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.004672168098165177) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
h _qcomp_qpu_0_r1c1[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c3[0];
entanglement _qcomm_qpu_0_r0c3[0], _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008838834764831844) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c0[0];
u1(-0.01300550143149851) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c3[0];
}
h _qcomp_qpu_0_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_0_r1c3[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c4[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
h _qcomp_qpu_1_r1c3[0];
u1(-0.015088834764831844) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
h _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  x _qcomm_qpu_1_r0c3[0];
}
cx _qcomm_qpu_1_r0c3[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c3[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c0[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c0[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.006755501431498511) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
u1(-0.010922168098165177) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.0025888347648318445) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomp_qpu_0_r1c3[0];
h _qcomp_qpu_0_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c4[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c3[0];
h _qcomm_qpu_1_r0c4[0];
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
reset _qcomm_qpu_1_r0c4[0];
entanglement _qcomm_qpu_0_r0c4[0], _qcomm_qpu_1_r0c4[0];
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c4[0];
_clbit_qcomm_qpu_0_r0c4[0] = measure _qcomm_qpu_0_r0c4[0];
reset _qcomm_qpu_0_r0c4[0];
if (_clbit_qcomm_qpu_0_r0c4[0]) {
  x _qcomm_qpu_1_r0c4[0];
}
u1(-0.006755501431498511) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
u1(-0.010922168098165177) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(0) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
meas[0] = measure _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
meas[2] = measure _qcomp_qpu_0_r1c2[0];
h _qcomm_qpu_0_r0c3[0];
_clbit_qcomm_qpu_0_r0c3[0] = measure _qcomm_qpu_0_r0c3[0];
if (_clbit_qcomm_qpu_0_r0c3[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
reset _qcomm_qpu_0_r0c3[0];
cx _qcomm_qpu_1_r0c4[0], _qcomp_qpu_1_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c4[0];
h _qcomp_qpu_1_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c2[0];
meas[3] = measure _qcomp_qpu_1_r1c0[0];
meas[6] = measure _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c4[0];
}
_clbit_qcomm_qpu_1_r0c4[0] = measure _qcomm_qpu_1_r0c4[0];
if (_clbit_qcomm_qpu_1_r0c4[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
cx _qcomp_qpu_0_r1c1[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c1[0];
}
meas[1] = measure _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c4[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c3[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.03333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c3[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c3[0];
meas[4] = measure _qcomp_qpu_1_r1c1[0];
meas[7] = measure _qcomp_qpu_1_r1c3[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c4[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c4[0];
meas[5] = measure _qcomp_qpu_0_r1c3[0];
meas[8] = measure _qcomp_qpu_0_r1c4[0];
