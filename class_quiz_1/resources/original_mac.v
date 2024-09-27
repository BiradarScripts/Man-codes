module mac #(
    parameter DATA_WIDTH = 4,
    parameter OUT_WIDTH = 8
)(
    input wire clk,                        // Clock input
    input wire reset,                      // Synchronous reset input
    input wire [DATA_WIDTH-1:0] a,         // Input 'a'
    input wire [DATA_WIDTH-1:0] b,         // Input 'b'
    input wire [DATA_WIDTH-1:0] c,         // Input 'c'
    output reg [OUT_WIDTH-1:0] out         // Output 'out'
);

    // Synchronous MAC operation
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;                      // Output reset to 0 when reset is active
        end else begin
            out <= (a * b) + c;            // Perform MAC operation when reset is inactive
        end
    end

endmodule
