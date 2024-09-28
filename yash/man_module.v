// ARYAMAN PATHAK
module blink (
    input clk,                // Clock input
    output reg led           // LED output (controlled by this module)
);
    reg [31:0] count;        // 32-bit register for counting clock cycles

    initial begin
        // Initialize count and led
        count = 0;
        led = 0;
    end

    always @(posedge clk) begin
        if (count == 99999999) begin // Check if count has reached the threshold
            count <= 0;              // Reset count register
            led <= ~led;             // Toggle LED state every second
        end else begin
            count <= count + 1;      // Increment count
        end
    end
endmodule
