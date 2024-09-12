module alu (
    input [17:0] A, B, D,        // 18-bit inputs
    input [47:0] C,              // 48-bit input
    input [1:0] select,          // 2-bit select input
    input carryin,               // 1-bit carry input
    input clk,                   // clock input
    output reg [47:0] P          // 48-bit output
);

// Internal signals for computation
reg [47:0] temp_mult, temp_add_AD;

always @(posedge clk) begin
    case (select)
        2'b00: begin
            // Sel = 00: output = A * B + C
            temp_mult = A * B;
            P = temp_mult + C;
        end

        2'b01: begin
            // Sel = 01: output = A * B
            P = A * B;
        end

        2'b10: begin
            // Sel = 10: output = A + D
            P = A + D;
        end

        2'b11: begin
            // Sel = 11: output = (A + D) * B + C + carryin
            temp_add_AD = A + D;
            P = (temp_add_AD * B) + C + carryin;
        end

        default: P = 48'b0; // default case to handle invalid select values
    endcase
end

endmodule
