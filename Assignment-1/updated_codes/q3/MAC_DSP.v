`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.09.2024 15:17:26
// Design Name: 
// Module Name: MAC_DSP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Multiply-Accumulate (MAC) operation using DSP block.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module MAC_DSP(
    input wire clk,        // Clock signal
    input wire [7:0] A,    // Input A
    input wire [7:0] B,    // Input B
    input wire [7:0] C,    // Input C
    output wire [16:0] P   // Output P (result of A * B + C)
);

    // Instantiate DSP block for A * B + C operation
    dsp_macro_1 your_instance_name (
        .CLK(clk),  // Connect clk to DSP clock input
        .A(A),      // Connect input A
        .B(B),      // Connect input B
        .C(C),      // Connect input C
        .P(P)       // Output P (result of A * B + C)
    );

endmodule
