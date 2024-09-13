`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module mac #(
    parameter DATA_WIDTH = 2,
    parameter OUT_WIDTH = 4
)(
 input wire clk,
 input wire reset
      // Output should be an output, not a reg inside
);
     wire [7:0]a;
     wire [7:0]b;
     wire [7:0]C;
     wire [16:0] out;
    
    // Instantiate the VIO module

 
ila_0 ila_name (
	.clk(clk), // input wire clk
	.probe0(out), // input wire [16:0]  probe0  
	.probe1(a), // input wire [7:0]  probe1 
	.probe2(b), // input wire [7:0]  probe2 
	.probe3(C), // input wire [7:0]  probe3 
	.probe4(reset) // input wire [0:0]  probe4
);



vio_0 your_vio (
  .clk(clk),                // input wire clk
  .probe_in0(out),    // input wire [16 : 0] probe_in0
  .probe_out0(a),  // output wire [7 : 0] probe_out0
  .probe_out1(b),  // output wire [7 : 0] probe_out1
  .probe_out2(C)  // output wire [7 : 0] probe_out2
);

    // Always block for MAC operation
   dsp_macro_0 dsp_name (
      .CLK(clk),  // input wire CLK
      .A(a),      // input wire [7 : 0] A
      .B(b),      // input wire [7 : 0] B
      .C(C),      // input wire [7 : 0] C
      .P(out)      // output wire [16 : 0] P
);

endmodule
