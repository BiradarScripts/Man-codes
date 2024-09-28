module blink(
    input reest,        // Reset input signal
    input clk,          // Clock signal (e.g., 100 MHz)
    output reg led1,    // LED1 output
    output reg led2,    // LED2 output
    output reg led3,     // LED3 output
    output reg internal_count
    );

reg [31:0] count;      // 32-bit counter for timing
reg [1:0] state;       // State to track which LED to blink

initial begin
    count = 0;         // Initialize counter to 0
    state = 0;         // Start with the first LED (state 0)
    led1 = 0;          // Initialize all LEDs to off
    led2 = 0;
    led3 = 0;
end

always @(posedge clk or posedge reest) begin
    if (reset) begin
        // If reset is high, reset everything
        count <= 0;
        state <= 0;
        led1 <= 0;
        led2 <= 0;
        led3 <= 0;
    end else begin
        // Continue blinking sequence if reset is low
        if (count == 99999999) begin  // Assuming 1 second for each LED (100 MHz clock)
            count <= 0;               // Reset counter after 1 second
            case (state)
                2'b00: begin           // State 0: LED1 ON, others OFF
                    led1 <= 1;
                    led2 <= 0;
                    led3 <= 0;
                    state <= 2'b01;    // Move to state 1
                end
                2'b01: begin           // State 1: LED2 ON, others OFF
                    led1 <= 0;
                    led2 <= 1;
                    led3 <= 0;
                    state <= 2'b10;    // Move to state 2
                end
                2'b10: begin           // State 2: LED3 ON, others OFF
                    led1 <= 0;
                    led2 <= 0;
                    led3 <= 1;
                    internal_count <= internal_count + 1;
                    state <= 2'b00;    // Move back to state 0
                end
            endcase
        end else begin
            count <= count + 1;        // Increment the counter each clock cycle
        end
    end
end

endmodule
