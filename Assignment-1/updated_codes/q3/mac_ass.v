module mac_parallel (
    input wire clk,   // Clock signal
    input wire reset  // Reset signal
);

    wire [16:0] results [9:0];  // Array to store results from 10 MAC operations
    reg [3:0] addr;  // Address counter (4-bit to address 10 elements)
    wire [7:0] a_data;  // Data output from BRAM for array 'a'
    wire [7:0] b_data;  // Data output from BRAM for array 'b'
    wire [7:0] c_data;  // Data output from BRAM for array 'c'
    reg [7:0] a_data_d, b_data_d, c_data_d;
    reg ena;            // Enable signal for BRAMs
    
    // Initialize the enable signal
    initial begin
        ena = 1;  // Set enable signal for BRAMs
    end
    
    // Instantiate 3 BRAMs for a, b, and c
    blk_mem_gen_0 a_bram (
        .clka(clk),    // input wire clka
        .ena(ena),     // input wire ena
        .addra(addr),  // input wire [3 : 0] addra (4-bit address)
        .douta(a_data) // output wire [7 : 0] douta
    );
    blk_mem_gen_0 b_bram (
        .clka(clk),    // input wire clka
        .ena(ena),     // input wire ena
        .addra(addr),  // input wire [3 : 0] addra (4-bit address)
        .douta(b_data) // output wire [7 : 0] douta
    );
    blk_mem_gen_0 c_bram (
        .clka(clk),    // input wire clka
        .ena(ena),     // input wire ena
        .addra(addr),  // input wire [3 : 0] addra (4-bit address)
        .douta(c_data) // output wire [7 : 0] douta
    );
    
    // Register delay for BRAM outputs
    always @(posedge clk) begin
        if (reset) begin
            a_data_d <= 0;
            b_data_d <= 0;
            c_data_d <= 0;
        end else begin
            a_data_d <= a_data;
            b_data_d <= b_data;
            c_data_d <= c_data;
        end
    end
    
    // Instantiate 10 MAC DSP modules
    MAC_DSP your_dsp_1 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[0])  // Store result of A * B + C in results[0]
    );
    MAC_DSP your_dsp_2 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[1])  // Store result of A * B + C in results[1]
    );
    MAC_DSP your_dsp_3 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[2])  // Store result of A * B + C in results[2]
    );
    MAC_DSP your_dsp_4 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[3])  // Store result of A * B + C in results[3]
    );
    MAC_DSP your_dsp_5 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[4])  // Store result of A * B + C in results[4]
    );
    MAC_DSP your_dsp_6 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[5])  // Store result of A * B + C in results[5]
    );
    MAC_DSP your_dsp_7 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[6])  // Store result of A * B + C in results[6]
    );
    MAC_DSP your_dsp_8 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[7])  // Store result of A * B + C in results[7]
    );
    MAC_DSP your_dsp_9 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[8])  // Store result of A * B + C in results[8]
    );
    MAC_DSP your_dsp_10 (
        .clk(clk),
        .A(a_data_d),
        .B(b_data_d),
        .C(c_data_d),
        .P(results[9])  // Store result of A * B + C in results[9]
    );

    // ILA for debugging
    ila_0 ila_ins_1 (
        .clk(clk),            // input wire clk
        .probe0(results[0]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_2 (
        .clk(clk),            // input wire clk
        .probe0(results[1]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_3 (
        .clk(clk),            // input wire clk
        .probe0(results[2]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_4 (
        .clk(clk),            // input wire clk
        .probe0(results[3]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_5 (
        .clk(clk),            // input wire clk
        .probe0(results[4]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_6 (
        .clk(clk),            // input wire clk
        .probe0(results[5]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_7 (
        .clk(clk),            // input wire clk
        .probe0(results[6]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_8 (
        .clk(clk),            // input wire clk
        .probe0(results[7]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_9 (
        .clk(clk),            // input wire clk
        .probe0(results[8]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );
    ila_0 ila_ins_10 (
        .clk(clk),            // input wire clk
        .probe0(results[9]),  // input wire [16:0] probe0 for result monitoring
        .probe1(reset)        // input wire for reset signal monitoring
    );

    // Address counter to iterate over BRAM locations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            addr <= 0;         // Reset the address counter
        end else if (addr < 9) begin
            addr <= addr + 1;  // Increment address
        end else begin
            addr <= 0;         // Reset address to loop over the array
        end
    end

endmodule
