OPENQASM 3.0;
include "stdgates.inc";
gate entanglement _gate_q_0, _gate_q_1 {
  h _gate_q_0;
  cx _gate_q_0, _gate_q_1;
}
bit[9] meas;
bit[1] _clbit_qcomm_qpu_2_r0c0;
bit[1] _clbit_qcomm_qpu_1_r0c0;
bit[1] _clbit_qcomm_qpu_2_r0c1;
bit[1] _clbit_qcomm_qpu_1_r0c1;
bit[1] _clbit_qcomm_qpu_2_r0c2;
bit[1] _clbit_qcomm_qpu_1_r0c2;
bit[1] _clbit_qcomm_qpu_0_r0c0;
bit[1] _clbit_qcomm_qpu_0_r0c1;
bit[1] _clbit_qcomm_qpu_0_r0c2;
qubit[1] _qcomp_qpu_2_r1c0;
qubit[1] _qcomp_qpu_2_r1c1;
qubit[1] _qcomp_qpu_2_r1c2;
qubit[1] _qcomp_qpu_1_r1c0;
qubit[1] _qcomm_qpu_2_r0c0;
qubit[1] _qcomm_qpu_1_r0c0;
qubit[1] _qcomm_qpu_2_r0c1;
qubit[1] _qcomm_qpu_1_r0c1;
qubit[1] _qcomp_qpu_1_r1c1;
qubit[1] _qcomm_qpu_2_r0c2;
qubit[1] _qcomm_qpu_1_r0c2;
qubit[1] _qcomp_qpu_1_r1c2;
qubit[1] _qcomp_qpu_0_r1c0;
qubit[1] _qcomm_qpu_0_r0c0;
qubit[1] _qcomm_qpu_0_r0c1;
qubit[1] _qcomp_qpu_0_r1c1;
qubit[1] _qcomm_qpu_0_r0c2;
qubit[1] _qcomp_qpu_0_r1c2;
u1(-0.1) _qcomp_qpu_2_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
u1(-0.1) _qcomp_qpu_0_r1c2[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomm_qpu_1_r0c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c0[0];
u1(-0.08737734478532141) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
u1(-0.05404401145198809) _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
h _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
h _qcomp_qpu_2_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_2_r0c1[0];
}
cx _qcomm_qpu_2_r0c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
h _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_2_r0c2[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_2_r0c2[0];
}
cx _qcomm_qpu_2_r0c2[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.2) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomm_qpu_0_r0c1[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c2[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c0[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
u1(-0.13333333333333333) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c0[0];
u1(-0.08737734478532141) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
u1(-0.05404401145198809) _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
h _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c0[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c1[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_2_r0c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_2_r0c1[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
h _qcomp_qpu_2_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
reset _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_2_r0c0[0];
}
cx _qcomm_qpu_2_r0c0[0], _qcomp_qpu_2_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
h _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_2_r0c1[0];
}
cx _qcomm_qpu_2_r0c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.2) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_0_r1c2[0];
u1(-0.08737734478532141) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05404401145198809) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
u1(-0.13333333333333333) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c0[0];
u1(-0.08737734478532141) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
u1(-0.05404401145198809) _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
h _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.2) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c2[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_2_r0c0[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_2_r0c2[0];
}
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
h _qcomp_qpu_2_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
cx _qcomm_qpu_2_r0c2[0], _qcomp_qpu_2_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
h _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_2_r0c0[0];
}
cx _qcomm_qpu_2_r0c0[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.2) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.08737734478532141) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05404401145198809) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c2[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c1[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c2[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c0[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_2_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
u1(-0.13333333333333333) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c0[0];
u1(-0.08737734478532141) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
u1(-0.05404401145198809) _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
h _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
u1(-0.2) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_2_r0c1[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_2_r0c2[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
h _qcomp_qpu_2_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_2_r0c1[0];
}
cx _qcomm_qpu_2_r0c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
h _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_2_r0c2[0];
}
cx _qcomm_qpu_2_r0c2[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.2) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.08737734478532141) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05404401145198809) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c2[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c0[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
u1(-0.13333333333333333) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c0[0];
u1(-0.08737734478532141) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
u1(-0.05404401145198809) _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c0[0];
h _qcomp_qpu_2_r1c0[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c2[0];
u1(-0.2) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c0[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_0_r0c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c1[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
reset _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_2_r0c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_2_r0c1[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.13333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
h _qcomp_qpu_2_r1c2[0];
u1(-0.05202200572599404) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
reset _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_2_r0c0[0];
}
cx _qcomm_qpu_2_r0c0[0], _qcomp_qpu_2_r1c2[0];
u1(-0.01868867239266071) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_2_r1c2[0];
h _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
cx _qcomp_qpu_1_r1c0[0], _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_2_r0c1[0];
}
cx _qcomm_qpu_2_r0c1[0], _qcomp_qpu_2_r1c2[0];
h _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.1) _qcomp_qpu_2_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomp_qpu_2_r1c1[0];
h _qcomp_qpu_2_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c0[0], _qcomp_qpu_2_r1c1[0];
meas[0] = measure _qcomp_qpu_2_r1c0[0];
h _qcomm_qpu_2_r0c1[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  z _qcomp_qpu_1_r1c0[0];
}
reset _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_0_r0c1[0], _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
h _qcomp_qpu_0_r1c2[0];
u1(-0.08737734478532141) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05404401145198809) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c0[0];
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.13333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_2_r0c0[0], _qcomm_qpu_1_r0c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomp_qpu_1_r1c1[0];
u1(-0.05202200572599404) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_2_r0c1[0], _qcomm_qpu_1_r0c1[0];
h _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
u1(-0.01868867239266071) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_1_r1c1[0];
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c0[0];
_clbit_qcomm_qpu_2_r0c0[0] = measure _qcomm_qpu_2_r0c0[0];
reset _qcomm_qpu_2_r0c0[0];
if (_clbit_qcomm_qpu_2_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
reset _qcomm_qpu_1_r0c2[0];
entanglement _qcomm_qpu_2_r0c2[0], _qcomm_qpu_1_r0c2[0];
cx _qcomp_qpu_1_r1c2[0], _qcomp_qpu_1_r1c1[0];
h _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
u1(-0.06666666666666667) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_2_r1c2[0];
cx _qcomp_qpu_2_r1c1[0], _qcomp_qpu_2_r1c2[0];
meas[1] = measure _qcomp_qpu_2_r1c1[0];
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_1_r0c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_2_r0c1[0] = measure _qcomm_qpu_2_r0c1[0];
reset _qcomm_qpu_2_r0c1[0];
if (_clbit_qcomm_qpu_2_r0c1[0]) {
  x _qcomm_qpu_1_r0c1[0];
}
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c0[0];
h _qcomp_qpu_1_r1c0[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c0[0];
cx _qcomm_qpu_1_r0c1[0], _qcomp_qpu_1_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
cx _qcomp_qpu_2_r1c2[0], _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_1_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_2_r0c2[0] = measure _qcomm_qpu_2_r0c2[0];
reset _qcomm_qpu_2_r0c2[0];
if (_clbit_qcomm_qpu_2_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c0[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_2_r1c2[0];
}
meas[2] = measure _qcomp_qpu_2_r1c2[0];
reset _qcomm_qpu_1_r0c2[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  x _qcomm_qpu_0_r0c0[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_0_r0c2[0], _qcomm_qpu_1_r0c2[0];
u1(-0.2) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c0[0];
u1(-0.05202200572599404) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c0[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_0_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.01868867239266071) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.035355339059327376) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
h _qcomp_qpu_1_r1c2[0];
u1(-0.02601100286299702) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c1[0];
entanglement _qcomm_qpu_1_r0c1[0], _qcomm_qpu_0_r0c1[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c0[0];
h _qcomp_qpu_0_r1c0[0];
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  x _qcomm_qpu_1_r0c2[0];
}
cx _qcomm_qpu_1_r0c2[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
u1(-0.009344336196330355) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c0[0], _qcomp_qpu_1_r1c1[0];
meas[3] = measure _qcomp_qpu_1_r1c0[0];
u1(-0.017677669529663688) _qcomp_qpu_1_r1c2[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
cx _qcomp_qpu_0_r1c0[0], _qcomm_qpu_0_r0c0[0];
_clbit_qcomm_qpu_0_r0c0[0] = measure _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_0_r0c0[0]) {
  x _qcomm_qpu_1_r0c0[0];
}
cx _qcomm_qpu_1_r0c0[0], _qcomp_qpu_1_r1c2[0];
h _qcomm_qpu_1_r0c0[0];
_clbit_qcomm_qpu_1_r0c0[0] = measure _qcomm_qpu_1_r0c0[0];
reset _qcomm_qpu_1_r0c0[0];
h _qcomp_qpu_1_r1c2[0];
u1(-0.06666666666666667) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_1_r1c2[0];
cx _qcomp_qpu_1_r1c1[0], _qcomp_qpu_1_r1c2[0];
meas[4] = measure _qcomp_qpu_1_r1c1[0];
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c1[0];
_clbit_qcomm_qpu_1_r0c1[0] = measure _qcomm_qpu_1_r0c1[0];
reset _qcomm_qpu_1_r0c1[0];
if (_clbit_qcomm_qpu_1_r0c0[0]) {
  z _qcomp_qpu_0_r1c0[0];
}
reset _qcomm_qpu_0_r0c0[0];
if (_clbit_qcomm_qpu_1_r0c1[0]) {
  x _qcomm_qpu_0_r0c1[0];
}
reset _qcomm_qpu_0_r0c2[0];
entanglement _qcomm_qpu_1_r0c2[0], _qcomm_qpu_0_r0c2[0];
h _qcomp_qpu_0_r1c2[0];
u1(-0.08737734478532141) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.05404401145198809) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.02601100286299702) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
u1(-0.009344336196330355) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c0[0];
cx _qcomm_qpu_0_r0c1[0], _qcomp_qpu_0_r1c0[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c1[0];
_clbit_qcomm_qpu_0_r0c1[0] = measure _qcomm_qpu_0_r0c1[0];
if (_clbit_qcomm_qpu_0_r0c1[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
cx _qcomp_qpu_1_r1c2[0], _qcomm_qpu_1_r0c2[0];
_clbit_qcomm_qpu_1_r0c2[0] = measure _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_1_r0c2[0];
reset _qcomm_qpu_0_r0c1[0];
u1(-0.017677669529663688) _qcomp_qpu_0_r1c1[0];
if (_clbit_qcomm_qpu_1_r0c2[0]) {
  x _qcomm_qpu_0_r0c2[0];
}
cx _qcomm_qpu_0_r0c2[0], _qcomp_qpu_0_r1c0[0];
h _qcomm_qpu_0_r0c2[0];
_clbit_qcomm_qpu_0_r0c2[0] = measure _qcomm_qpu_0_r0c2[0];
if (_clbit_qcomm_qpu_0_r0c2[0]) {
  z _qcomp_qpu_1_r1c2[0];
}
meas[5] = measure _qcomp_qpu_1_r1c2[0];
reset _qcomm_qpu_0_r0c2[0];
cx _qcomp_qpu_0_r1c2[0], _qcomp_qpu_0_r1c1[0];
h _qcomp_qpu_0_r1c1[0];
u1(-0.06666666666666667) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c1[0];
cx _qcomp_qpu_0_r1c0[0], _qcomp_qpu_0_r1c1[0];
meas[6] = measure _qcomp_qpu_0_r1c0[0];
u1(-0.1) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
u1(-0.03333333333333333) _qcomp_qpu_0_r1c2[0];
cx _qcomp_qpu_0_r1c1[0], _qcomp_qpu_0_r1c2[0];
meas[7] = measure _qcomp_qpu_0_r1c1[0];
meas[8] = measure _qcomp_qpu_0_r1c2[0];
