#include "adders.h"

void adders(din_a_t in1, din_b_t in2, din_c_t in3, dout_t &out3) { // Pass out3 by reference
#pragma HLS INTERFACE ap_ctrl_none port=return

// Prevent IO protocols on all input ports
#pragma HLS INTERFACE ap_none port=in3
#pragma HLS INTERFACE ap_none port=in2
#pragma HLS INTERFACE ap_none port=in1

	out3 = in1 + in2 + in3;
}
