OPENQASM 3.0;
include "stdgates.inc";
gate entanglement a, b {
  h a;
  cx a, b;
}
bit[4] meas;
qubit[1] _qcomm_qpu_0_r0c0;
qubit[1] _qcomm_qpu_1_r0c0;
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
meas[0] = measure _qcomm_qpu_0_r0c0[0];
meas[1] = measure _qcomm_qpu_1_r0c0[0];
entanglement _qcomm_qpu_0_r0c0[0], _qcomm_qpu_1_r0c0[0];
meas[2] = measure _qcomm_qpu_0_r0c0[0];
meas[3] = measure _qcomm_qpu_1_r0c0[0];
