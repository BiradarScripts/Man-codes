`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2020 15:03:38
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder(
 in1,
        in2,
        in3,
        sum
);


input  [31:0] in1;
input  [31:0] in2;
input  [31:0] in3;
output  [31:0] sum;

  
    
    adders_0 your_instance_name (
  .in1(in1),              // input wire [31 : 0] in1
  .in2(in2),              // input wire [31 : 0] in2
  .in3(in3),              // input wire [31 : 0] in3
  .ap_return(sum)  // output wire [31 : 0] ap_return
);

endmodule
