`timescale 1ns / 1ps  // Set the time scale for simulation (1ns time unit, 1ps precision)

module tb;


reg clk;     // clk should be reg, not wire, because it is driven by always block
reg led;   // reset should be reg, not wire


blink blinkled(
     clk,
    led
    );
always begin
    #5 clk = ~clk;  // Toggle clock every 5 time units (10ns clock period)
end

initial begin
    // Initialize signals
    //  #100;
    clk = 0;
   

              // Wait for 100 time units before starting the test

    

    
    $finish;        // End simulation
end

endmodule
