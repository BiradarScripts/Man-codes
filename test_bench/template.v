`timescale 1ns / 1ps  // Set the time scale for simulation (1ns time unit, 1ps precision)

module tb;  // Testbench does not need inputs/outputs

// Declare signals for inputs and outputs of the DUT (Device Under Test)
reg clk;
reg rst;
reg D;
wire Q;

// Instantiate the DUT (e.g., your D Flip-Flop or any other module you're testing)
DFF uut (
    .clk(clk),
    .rst(rst),
    .D(D),
    .Q(Q)
);

// Clock generation
always begin
    #5 clk = ~clk;  // Toggle clock every 5 time units (10ns clock period)
end

// Test procedure
initial begin
    // Initialize all inputs
    // #100 delay for post synthesis and implementation
    clk = 0;
    rst = 0;
    D = 0;

    // Apply reset
    rst = 1;
    #10;  // Wait for 10 time units
    rst = 0;

    // Apply test stimuli
    #10 D = 1;  // Set D to 1
    #20 D = 0;  // After 20 time units, set D to 0
    #20 D = 1;  // After 20 time units, set D to 1 again

    // Add more test cases as required

    // Finish simulation after some time
    #100 $finish;  // Stop the simulation after 100 time units
end

// Monitor signals for debugging
initial begin
    $monitor("Time = %t | clk = %b | rst = %b | D = %b | Q = %b", $time, clk, rst, D, Q);
end

endmodule
