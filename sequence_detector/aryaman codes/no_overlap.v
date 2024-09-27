module PatternDetector (
    input wire clock_100Mhz,
    input wire reset,
    input wire [0:0] bit, // Single-bit input from Block RAM
    input wire one_second_enable,
    output wire [7:0] pattern_count // Output count of non-overlapping occurrences
    
);

    reg [3:0] shift_reg; // 4-bit shift register for pattern matching
    reg [3:0] pattern = 4'b1011; // Pattern to search for
    reg [7:0] internal_count;
    reg[2:0] counter = 2'b00;
    
    initial begin
        internal_count = 0;
        shift_reg = 4'b0000; // Initialize shift register
    end
    
    assign pattern_count = internal_count;
    
    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000; // Clear shift register on reset
            internal_count <= 0;
           
        end else if (one_second_enable) begin
            // Shift left and add new bit
            shift_reg <= {shift_reg[2:0], bit};
                
//            internal_count <= internal_count + 1;
    
                if (shift_reg == pattern) begin
                internal_count <= internal_count + 1;
                shift_reg <= 4'b0000;
          
            end 
                
            
                
                
            end
    


        
            
            // Check if shift_reg matches the pattern
        
            
            // Print the current pattern count at each clock cycle
         
        end


endmodule