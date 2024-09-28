module led_blink(
    input clk,
    output reg led1,
    output reg led2
);

    reg [31:0] count;
    reg [1:0] ena;
    reg [3:0] count1;
    reg [3:0] count2;

    // Initial block for initialization
    initial begin
        count = 0;
        led1 = 0;
        ena = 2'b00;
        count1 = 4'b0000;
        count2 = 4'b0000;
    end

    // Always block triggered on the positive edge of the clock
    always @(posedge clk) begin
        if (count == 32'h3211111) begin // Time is up
            count <= 0; // Reset count register
            
            if (count1 == 4'b1001 && ena == 2'b00) begin
                ena <= 2'b01;
                led1 <= 0;
            end
            else if (count2 == 4'b1001 && ena == 2'b01) begin
                ena <= 2'b10;
            end

            if (ena == 2'b00) begin
                led1 <= ~led1; // Toggle led1 (every second)
                count1 <= count1 + 4'b0001;
            end
            else if (ena == 2'b01) begin
                led2 <= ~led2; // Toggle led2
                count2 <= count2 + 4'b0001;
            end
            else begin
                led1 <= 0;
                led2 <= 0;
            end
        end
        else begin
            count <= count + 1; // Increment count, assuming 100MHz clock
        end
    end

endmodule
