`timescale 1ns / 1ps  // Set the time scale for simulation (1ns time unit, 1ps precision)

module tb;

reg [1:0] a;
reg [1:0] b;
wire [2:0] sum;
reg clk;     // clk should be reg, not wire, because it is driven by always block
reg reset;   // reset should be reg, not wire

adder testing (
    .clk(clk),
    .rst(reset),
    .a(a),
    .b(b),
    .sum(sum)
);

always begin
    #5 clk = ~clk;  // Toggle clock every 5 time units (10ns clock period)
end

initial begin
    // Initialize signals
     #100;
    clk = 0;
    reset = 0;
    a = 0;
    b = 0;

              // Wait for 100 time units before starting the test

    reset = 1;      // Apply reset
    #10;
    reset = 0;      // Deassert reset
    a = 2'b00;
    b = 2'b01;
    #10;
    a = 2'b01;
    b = 2'b01;
    #10;
    
    $finish;        // End simulation
end

endmodule
