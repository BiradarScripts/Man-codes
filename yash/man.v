`timescale 1ns / 1ps // Set the time scale for simulation (1ns time unit, 1ps precision)

module tb;
    reg clk;            // clk should be reg, not wire, because it is driven by always block
    wire led;          // led should be wire, as it is driven by another module

    // Instantiate the blink module
    blink blinkled (
        .clk(clk),
        .led(led)
    );

    // Toggle clock every 5 time units (10ns clock period)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        clk = 0;
        $finish; // End simulation
    end
endmodule
