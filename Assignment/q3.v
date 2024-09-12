module mac_parallel (
    input wire clk ,  
    input wire reset          // Clock signal
     // 10 MAC results
);
wire [16:0] results [9:0]; 

    reg [3:0] addr;              // Address counter (4-bit to address 10 elements)
    wire [7:0] a_data;      // Data output from BRAM for array 'a'
    wire [7:0] b_data;      // Data output from BRAM for array 'b'
    wire [7:0] c_data;      // Data output from BRAM for array 'c'
    reg ena;
    
    initial
    begin
    ena=1;
    end
    

    // Instantiate 3 BRAMs for a, b, and c
   
      genvar i;
    
            blk_mem_gen_1 a (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(a_data)  // output wire [7 : 0] douta
);
           blk_mem_gen_1 b (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(b_data)  // output wire [7 : 0] douta
);
           blk_mem_gen_1 c (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(c_data)  // output wire [7 : 0] douta
);
       
  
    // Instantiate 10 MAC units and feed data from BRAMs
    generate
        for (i = 0; i < 10; i = i + 1) begin : mac_gen
           dsp_macro_0 mac_inst (
  .CLK(CLK),  // input wire CLK
  .A(a_data),      // input wire [7 : 0] A
  .B(b_data),      // input wire [7 : 0] B
  .C(c_data),      // input wire [7 : 0] C
  .P(results[i])      // output wire [16 : 0] P
);
        end
    endgenerate
    
    
ila_0 ila_ins (
	.clk(clk), // input wire clk


	.probe0(results[0]), // input wire [16:0] probe0
	.probe1(reset)
);



    // Address counter to iterate over BRAM locations
    always @(posedge clk) begin
        if (addr < 9)
            addr <= addr + 1;    // Increment address
        else
            addr <= 0;           // Reset address to loop over the array
    end

endmodule