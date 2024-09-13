`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module mac #(
    parameter DATA_WIDTH = 8,  // Use 8 bits for a, b, and c (as required)
    parameter OUT_WIDTH = 16   // Output width based on multiplication (8*8 = 16 bits)
)(
 input wire clk,
 input wire reset
);

    // Define 8-bit wires for inputs a, b, and C (instead of c)
    wire [7:0] a;
    wire [7:0] b;
    wire [7:0] C;  // Make sure C is 8 bits, not 1 bit
    reg  [15:0] out;  // Output for MAC result

    // Instantiate the VIO module
    vio_0 vio_name (
        .clk(clk),          // Input wire clk
        .probe_in0(out),    // Input wire [15:0] probe_in0
        .probe_out0(a),     // Output wire [7:0] probe_out0
        .probe_out1(b),     // Output wire [7:0] probe_out1
        .probe_out2(C)      // Output wire [7:0] probe_out2 (corrected from c to C)
    );

    // Instantiate the ILA module
    ila_0 your_instance_name (
        .clk(clk),      // Input wire clk
        .probe0(out),   // Input wire [15:0] probe0
        .probe1(a),     // Input wire [7:0] probe1
        .probe2(b),     // Input wire [7:0] probe2
        .probe3(C),     // Input wire [7:0] probe3 (corrected from c to C)
        .probe4(reset)  // Input wire [0:0] probe4
    );

    // Always block for MAC operation
    always @(posedge clk) begin
        if (reset)
            out <= 0;  // Reset the output
        else
            out <= a * b + C;  // Perform MAC operation
    end

endmodule
