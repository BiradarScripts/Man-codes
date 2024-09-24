module mac #(
    parameter DATA_WIDTH = 4,
    parameter OUT_WIDTH = 8
)(
    input wire clk,
    input wire reset // Synchronous reset
);

wire [DATA_WIDTH-1:0] a;
wire [DATA_WIDTH-1:0] b;
wire [DATA_WIDTH-1:0] c;
reg [OUT_WIDTH-1:0] out;

vio_1 your_instance_name (
  .clk(clk),                // input wire clk
  .probe_in0(out),    // input wire [7 : 0] probe_in0
  .probe_out0(a),  // output wire [3 : 0] probe_out0
  .probe_out1(b),  // output wire [3 : 0] probe_out1
  .probe_out2(c)  // output wire [3 : 0] probe_out2
);

    always @(posedge clk) begin
        if (reset) begin
            out <= 0; // Disable MAC, output is 0 when reset is active
        end else begin
            out <= (a * b) + c; // Perform MAC operation when reset is inactive
        end
    end

endmodule
