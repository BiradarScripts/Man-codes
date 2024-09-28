// To implement a binary counter that uses four LEDs to represent a 4-bit binary number and increments every second, while also displaying the overflow count on a 7-segment display, we need to modify the provided blink module significantly. Below is the updated Verilog code that meets the specified requirements:

// Verilog Code for Binary Counter with LED and 7-Segment Display Feedback



module binary_counter(
    input reset,                // Reset input signal
    input clk,                  // Clock signal (e.g., 100 MHz)
    output reg led1,            // LED1 output (LSB)
    output reg led2,            // LED2 output
    output reg led3,            // LED3 output
    output reg led4,            // LED4 output (MSB)
    output reg [6:0] seg        // 7-segment display output
);

reg [31:0] count;              // 32-bit counter for timing
reg [3:0] binary_count;        // 4-bit binary counter
reg [31:0] overflow_count;     // Overflow count for 4-bit counter
reg [31:0] timer;              // Timer for counting seconds

initial begin
    count = 0;                 // Initialize count to 0
    binary_count = 0;         // Initialize binary counter to 0
    overflow_count = 0;       // Initialize overflow count to 0
    timer = 0;                // Initialize timer to 0
    led1 = 0;                 // Initialize LEDs to off
    led2 = 0;
    led3 = 0;
    led4 = 0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // If reset is high, reset everything
        count <= 0;
        binary_count <= 0;
        overflow_count <= 0;
        timer <= 0;
        led1 <= 0;
        led2 <= 0;
        led3 <= 0;
        led4 <= 0;
    end else begin
        // Increment timer every clock cycle
        timer <= timer + 1;

        if (timer == 99999999) begin // Assuming 100 MHz clock, reset timer after 1 second
            timer <= 0;               // Reset timer
            binary_count <= binary_count + 1; // Increment binary counter
            
            // Update LEDs based on the binary counter
            {led4, led3, led2, led1} <= binary_count;

            // Check for overflow
            if (binary_count == 4'b1111) begin
                binary_count <= 0;     // Reset binary counter
                overflow_count <= overflow_count + 1; // Increment overflow count
            end
        end
    end
end

// 7-Segment Display Decoder
always @(*) begin
    case (overflow_count)
        0: seg = 7'b0000001; // Display 0
        1: seg = 7'b1001111; // Display 1
        2: seg = 7'b0010010; // Display 2
        3: seg = 7'b0000110; // Display 3
        4: seg = 7'b1001100; // Display 4
        5: seg = 7'b0100100; // Display 5
        6: seg = 7'b0100000; // Display 6
        7: seg = 7'b0001111; // Display 7
        8: seg = 7'b0000000; // Display 8
        9: seg = 7'b0000100; // Display 9
        10: seg = 7'b0001000; // Display A
        11: seg = 7'b1100000; // Display B
        12: seg = 7'b0110001; // Display C
        13: seg = 7'b1000010; // Display D
        14: seg = 7'b0110000; // Display E
        15: seg = 7'b0111000; // Display F
        default: seg = 7'b1111111; // Blank for counts > 15
    endcase
end

endmodule
