 /*******************************************************************************
Vendor: Xilinx 
Associated Filename: adders_test.c
Purpose: Vivado HLS tutorial example 
Device: All 
Revision History: March 1, 2013 - initial release
                                                
*******************************************************************************
Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.

This file contains confidential and proprietary information of Xilinx, Inc. and 
is protected under U.S. and international copyright and other intellectual 
property laws.

DISCLAIMER
This disclaimer is not a license and does not grant any rights to the materials 
distributed herewith. Except as otherwise provided in a valid license issued to 
you by Xilinx, and to the maximum extent permitted by applicable law: 
(1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX 
HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR 
FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether 
in contract or tort, including negligence, or under any other theory of 
liability) for any loss or damage of any kind or nature related to, arising under 
or in connection with these materials, including for any direct, or any indirect, 
special, incidental, or consequential loss or damage (including loss of data, 
profits, goodwill, or any type of loss or damage suffered as a result of any 
action brought by a third party) even if such damage or loss was reasonably 
foreseeable or Xilinx had been advised of the possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-safe, or for use in any 
application requiring fail-safe performance, such as life-support or safety 
devices or systems, Class III medical devices, nuclear facilities, applications 
related to the deployment of airbags, or any other applications that could lead 
to death, personal injury, or severe property or environmental damage 
(individually and collectively, "Critical Applications"). Customer asresultes the 
sole risk and liability of any use of Xilinx products in Critical Applications, 
subject only to applicable laws and regulations governing limitations on product 
liability. 

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT 
ALL TIMES.

*******************************************************************************/
#include<iostream>
#include "adders.h"

using namespace std;

int main()
{
	din_a_t in1=10;
	din_b_t in2=20;
	din_c_t in3=30;
	dout_t hw_dout3, sw_dout3;
	int err_cnt = 0;
	// Generate the expected result
	sw_dout3 = in1 + in2 + in3;

#ifdef HW_COSIM
	// Run the AutoESL matrix multiply block
	adders(in1, in2, in3, hw_dout3);
#endif
	// Print result matrix
	cout << "hw_dout3 = " << hw_dout3 << endl;
	cout << "sw_dout3 = " << sw_dout3 << endl;

#ifdef HW_COSIM
	if (hw_dout3 != sw_dout3) {
		err_cnt++;
		cout << "ERROR: " << err_cnt << " mismatches detected!" << endl;
	} else {
		cout << "Test passed." << endl;
	}

#endif

	return err_cnt;
	// Testbench
}
