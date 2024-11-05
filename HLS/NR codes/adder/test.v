`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2020 15:10:32
// Design Name: 
// Module Name: test
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


module test;


reg  [31:0] in1;
reg  [31:0] in2;
reg  [31:0] in3;
wire  [31:0] sum;
        
 adder eg1( in1, in2, in3,  sum);
 
 initial begin

in1= 10;
in2=20;
in3=20;


end
  
endmodule
