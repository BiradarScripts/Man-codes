module PatternDetector (
    input wire clock_100Mhz,
    input wire reset,
    input wire [0:0] bit, // Single-bit input from Block RAM
    
    output reg [7:0] pattern_count // Output count of non-overlapping occurrences
);

    reg [3:0] shift_reg; // 4-bit shift register for pattern matching
    reg [3:0] pattern = 4'b1011; // Pattern to search for

    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000; // Clear shift register on reset
            pattern_count <= 0;
        end else begin
            // Shift left and add new bit
            shift_reg <= {shift_reg[2:0], bit};
            
            // Check if shift_reg matches the pattern
            if (shift_reg == pattern) begin
                pattern_count <= pattern_count + 1;
                // Shift register will be updated to the next state in the next clock cycle
            end
        end
    end

endmodule
