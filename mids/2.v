// 2. Modular Design with Multiple Counters:
// Create a modular Verilog design where each module controls a separate LED. The first module should blink an LED every 1 second, the second every 2 seconds, and the third every 3 seconds.
// The blinking should stop once the total count across all LEDs reaches 15. Display the final count on a 7-segment display. do the same for this question

module led_controller(
    input wire clk,           // Clock signal (e.g., 100 MHz)
    input wire reset,         // Reset signal
    output reg [6:0] seg,     // 7-segment display output
    output reg led1,          // LED1 output
    output reg led2,          // LED2 output
    output reg led3           // LED3 output
);

reg [3:0] total_count;        // Total count of LED blinks across all modules
wire led1_count, led2_count, led3_count;  // Blinking counts from the three LED modules

// Instantiate the three LED modules with different timing
led_blinker #(50000000) led1_module (
    .clk(clk),
    .reset(reset),
    .led(led1),
    .count(led1_count)
);

led_blinker #(100000000) led2_module (
    .clk(clk),
    .reset(reset),
    .led(led2),
    .count(led2_count)
);

led_blinker #(150000000) led3_module (
    .clk(clk),
    .reset(reset),
    .led(led3),
    .count(led3_count)
);

// Total count of all blinking LEDs
always @(posedge clk or posedge reset) begin
    if (reset) begin
        total_count <= 0;
    end else if (total_count < 15) begin
        total_count <= total_count + led1_count + led2_count + led3_count;
    end else begin
        led1 <= 0;
        led2 <= 0;
        led3 <= 0;  // Stop all LEDs when the total count reaches 15
    end
end

// Display the total count on a 7-segment display
always @(posedge clk) begin
    case (total_count)
        4'd0: seg = 7'b1000000; // Display 0
        4'd1: seg = 7'b1111001; // Display 1
        4'd2: seg = 7'b0100100; // Display 2
        4'd3: seg = 7'b0110000; // Display 3
        4'd4: seg = 7'b0011001; // Display 4
        4'd5: seg = 7'b0010010; // Display 5
        4'd6: seg = 7'b0000010; // Display 6
        4'd7: seg = 7'b1111000; // Display 7
        4'd8: seg = 7'b0000000; // Display 8
        4'd9: seg = 7'b0010000; // Display 9
        default: seg = 7'b1111111; // Blank display
    endcase
end

endmodule





module led_blinker #(parameter DELAY = 50000000)(
    input wire clk,        // Clock signal
    input wire reset,      // Reset signal
    output reg led,        // LED output
    output reg count       // Blink count signal
);

reg [31:0] counter;       // Counter for timing the LED blinking

initial begin
    led = 0;
    count = 0;
    counter = 0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        led <= 0;
        counter <= 0;
        count <= 0;
    end else if (counter >= DELAY) begin
        counter <= 0;
        led <= ~led;        // Toggle LED state
        count <= 1;         // Increment blink count
    end else begin
        counter <= counter + 1;
        count <= 0;
    end
end

endmodule
