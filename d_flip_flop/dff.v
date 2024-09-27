module DFF(
    input wire clk,    // Clock input
    input wire rst,    // Reset input (active high)
    input wire D,      // Data input
    output reg Q       // Data output
);

// D Flip-Flop with synchronous reset
always @(posedge clk or posedge rst) begin
    if (rst) begin
        Q <= 1'b0;     // Reset the output
    end else begin
        Q <= D;        // Store input D to output Q on clock edge
    end
end

endmodule
