module blink(
    input clk,
    output reg led
);

reg [31:0] count;

initial begin
    count = 0;   // Initialize count to 0
    led = 0;     // Initialize LED to off
end

always @(posedge clk) begin
    if (count == 9) begin // Blink every 10 clock cycles (assuming clk is 100 MHz, this would be 0.1 second)
        count <= 0;       // Reset count register
        led <= ~led;      // Toggle LED
    end else begin
        count <= count + 1;      
    end
end

endmodule
