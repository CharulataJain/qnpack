OPENQASM 3.0;
include "stdgates.inc";
gate entanglement _gate_q_0, _gate_q_1 {
  h _gate_q_0;
  cx _gate_q_0, _gate_q_1;
}
bit[6] c;
bit[1] _clbit_comm_qubit1_1;
bit[1] _clbit_comm_qubit2_1;
qubit[1] _qubit1_2;
qubit[1] _qubit1_3;
qubit[1] _qubit1_1;
qubit[1] _qubit2_2;
qubit[1] _comm_qubit1_1;
qubit[1] _comm_qubit2_1;
qubit[1] _qubit2_3;
qubit[1] _qubit2_1;
rz(pi/2) _qubit1_2[0];
sx _qubit1_2[0];
rz(pi/2) _qubit1_2[0];
cx _qubit1_2[0], _qubit1_3[0];
cx _qubit1_3[0], _qubit1_1[0];
entanglement _comm_qubit1_1[0], _comm_qubit2_1[0];
cx _qubit1_1[0], _comm_qubit1_1[0];
c[0] = measure _qubit1_2[0];
c[1] = measure _qubit1_3[0];
_clbit_comm_qubit1_1[0] = measure _comm_qubit1_1[0];
reset _comm_qubit1_1[0];
if (_clbit_comm_qubit1_1[0]) {
  x _comm_qubit2_1[0];
}
cx _comm_qubit2_1[0], _qubit2_2[0];
cx _qubit2_2[0], _qubit2_3[0];
c[3] = measure _qubit2_2[0];
h _comm_qubit2_1[0];
cx _qubit2_3[0], _qubit2_1[0];
c[4] = measure _qubit2_3[0];
c[5] = measure _qubit2_1[0];
_clbit_comm_qubit2_1[0] = measure _comm_qubit2_1[0];
if (_clbit_comm_qubit2_1[0]) {
  z _qubit1_1[0];
}
c[2] = measure _qubit1_1[0];
reset _comm_qubit2_1[0];
