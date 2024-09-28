// 1. Advanced LED Blinking and Timing Control:
// Write Verilog code to blink four LEDs in a specific sequence (e.g., LED1 -> LED2 -> LED3 -> LED4 -> repeat) with precise timing control such that the gap between each LED blink is 500ms, and after completing one full sequence, all LEDs stay off for 1 second before restarting.
// Modify the code to include a switch that, when pressed, stops the blinking sequence and restarts it from the beginning when released.


module blink(
    input wire reset,          // Reset input signal
    input wire clk,            // Clock signal (e.g., 100 MHz)
    input wire switch,         // Switch input to stop/restart blinking
    output reg led1,           // LED1 output
    output reg led2,           // LED2 output
    output reg led3,           // LED3 output
    output reg led4,           // LED4 output
    output reg [31:0] internal_count  // Internal count for completed sequences
);

reg [31:0] count;              // 32-bit counter for timing
reg [2:0] state;               // State to track which LED to blink
reg stopped;                   // Indicates if the blinking is stopped

initial begin
    count = 0;                 // Initialize counter to 0
    state = 0;                 // Start with the first LED (state 0)
    led1 = 0;                  // Initialize all LEDs to off
    led2 = 0;
    led3 = 0;
    led4 = 0;
    stopped = 0;               // Not stopped initially
    internal_count = 0;         // Initialize internal_count to 0
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // If reset is high, reset everything
        count <= 0;
        state <= 0;
        led1 <= 0;
        led2 <= 0;
        led3 <= 0;
        led4 <= 0;
        stopped <= 0;          // Restart blinking sequence
        internal_count <= 0;    // Reset internal_count
    end else if (switch) begin
        // If switch is pressed, stop the sequence
        stopped <= 1;
        count <= 0;            // Reset counter when stopped
        led1 <= 0;
        led2 <= 0;
        led3 <= 0;
        led4 <= 0;
    end else if (stopped && !switch) begin
        // If switch is released, restart the sequence
        stopped <= 0;
        state <= 0;            // Restart from first LED
    end else if (!stopped) begin
        // Continue blinking sequence if not stopped
        if (count >= 49999999) begin // 500ms delay for each LED (assuming 100 MHz clock)
            count <= 0;               // Reset counter after 500ms
            case (state)
                3'b000: begin          // State 0: LED1 ON, others OFF
                    led1 <= 1;
                    led2 <= 0;
                    led3 <= 0;
                    led4 <= 0;
                    state <= 3'b001;   // Move to state 1
                end
                3'b001: begin          // State 1: LED2 ON, others OFF
                    led1 <= 0;
                    led2 <= 1;
                    led3 <= 0;
                    led4 <= 0;
                    state <= 3'b010;   // Move to state 2
                end
                3'b010: begin          // State 2: LED3 ON, others OFF
                    led1 <= 0;
                    led2 <= 0;
                    led3 <= 1;
                    led4 <= 0;
                    state <= 3'b011;   // Move to state 3
                end
                3'b011: begin          // State 3: LED4 ON, others OFF
                    led1 <= 0;
                    led2 <= 0;
                    led3 <= 0;
                    led4 <= 1;
                    state <= 3'b100;   // Move to off-state
                end
                3'b100: begin          // State 4: All LEDs OFF for 1 second
                    led1 <= 0;
                    led2 <= 0;
                    led3 <= 0;
                    led4 <= 0;
                    state <= 3'b000;   // Restart sequence from LED1
                    internal_count <= internal_count + 1;  // Increment internal_count on full cycle
                    count <= 99999999; // Set counter for 1-second off time (1 second delay)
                end
            endcase
        end else begin
            count <= count + 1;        // Increment the counter each clock cycle
        end
    end
end

endmodule
