module tb_blink; 

    // Testbench signals
    reg reest;         // Reset signal
    reg clk;           // Clock signal
    wire led1, led2, led3; // Outputs for LEDs

    // Instantiate the blink module
    blink uut (
        .reest(reest),
        .clk(clk),
        .led1(led1),
        .led2(led2),
        .led3(led3)
    );

    // Clock generation (10ns period for 100MHz clock)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5ns
    end

    // Stimulus process
    initial begin
        // Initialize signals
        reest = 1;   // Apply reset initially
        #20;         // Wait for 20ns
        reest = 0;   // Release reset

        // Run the simulation for some time to observe the LED blinking
        #200000000;  // Simulate long enough (200ms to see a few cycles of LED blinking)
        $finish;     // End simulation
    end

    // Monitor the output for debugging purposes
    initial begin
        $monitor("Time = %0dns, LED1 = %b, LED2 = %b, LED3 = %b", $time, led1, led2, led3);
    end

endmodule
