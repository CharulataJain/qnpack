OPENQASM 3.0;
include "stdgates.inc";
gate entanglement _gate_q_0, _gate_q_1 {
  h _gate_q_0;
  cx _gate_q_0, _gate_q_1;
}
bit[8] meas;
bit[1] _clbit_qcomm_qpu_0_r0c0;
bit[1] _clbit_qcomm_qpu_1_r0c0;
bit[1] _clbit_qcomm_qpu_0_r0c1;
bit[1] _clbit_qcomm_qpu_1_r0c1;
bit[1] _clbit_qcomm_qpu_1_r0c2;
bit[1] _clbit_qcomm_qpu_0_r0c2;
bit[1] _clbit_qcomm_qpu_1_r0c3;
bit[1] _clbit_qcomm_qpu_0_r0c3;
qubit[1] _qcomp_qpu_0_r1c1;
qubit[1] _qcomp_qpu_0_r1c2;
qubit[1] _qcomp_qpu_0_r1c3;
qubit[1] _qcomp_qpu_0_r1c0;
qubit[1] _qcomp_qpu_1_r1c1;
qubit[1] _qcomm_qpu_0_r0c0;
qubit[1] _qcomm_qpu_1_r0c0;
qubit[1] _qcomm_qpu_0_r0c1;
qubit[1] _qcomm_qpu_1_r0c1;
qubit[1] _qcomp_qpu_1_r1c2;
qubit[1] _qcomm_qpu_1_r0c2;
qubit[1] _qcomm_qpu_0_r0c2;
qubit[1] _qcomm_qpu_1_r0c3;
qubit[1] _qcomm_qpu_0_r0c3;
qubit[1] _qcomp_qpu_1_r1c3;
qubit[1] _qcomp_qpu_1_r1c0;
u1(-0.025) _qcomp_qpu_0_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.008333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.008333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.008333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
u1(-0.025) _qcomp_qpu_1_r1c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c3[0];
entanglement _qcomm_qpu_1_r0c3[0], _qcomm_qpu_0_r0c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
u1(-0.34950937914128566) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.21617604580795236) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u2(0, pi) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
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
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
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
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c3[0];
u2(0, pi) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.025) _qcomp_qpu_0_r1c1[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c2[0];
u2(0, pi) _qcomp_qpu_0_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.008333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
meas[0] = measure _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.05) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
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
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.10404401145198808) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03737734478532142) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
u1(-0.008333333333333333) _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c3[0];
meas[1] = measure _qcomp_qpu_0_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_1_r0c3[0] = measure _qcomm_qpu_1_r0c3[0];
reset _qcomm_qpu_1_r0c3[0];
if (_clbit_qcomm_qpu_1_r0c3[0]) {
  x _qcomm_qpu_0_r0c3[0];
}
cx _qcomm_qpu_0_r0c3[0], _qcomp_qpu_0_r1c0[0];
u2(0, pi) _qcomp_qpu_0_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
u1(-0.008333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c3[0], _qcomp_qpu_0_r1c0[0];
meas[2] = measure _qcomp_qpu_0_r1c3[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
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
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
u1(-0.20808802290397616) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u1(-0.07475468957064284) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.10404401145198808) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
u1(-0.1414213562373095) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c3[0];
u2(0, pi) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03737734478532142) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
meas[3] = measure _qcomp_qpu_0_r1c0[0];
reset _qcomm_qpu_1_r0c1[0];
u1(-0.07071067811865475) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c2[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
meas[4] = measure _qcomp_qpu_1_r1c1[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.17475468957064283) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.10808802290397618) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.016666666666666666) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c3[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c3[0];
meas[5] = measure _qcomp_qpu_1_r1c2[0];
u2(0, pi) _qcomp_qpu_1_r1c0[0];
u1(-0.025) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
u1(-0.008333333333333333) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c3[0], _qcomp_qpu_1_r1c0[0];
meas[6] = measure _qcomp_qpu_1_r1c3[0];
meas[7] = measure _qcomp_qpu_1_r1c0[0];






