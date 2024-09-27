`timescale 1ns / 1ps

module mac_3(input clk, input reset);

reg  address;
wire [16:0] out [9:0];
wire [79:0] din [2:0];
wire [79:0] dout [2:0];
reg ena, wea;

ila_0 ila_instance (
    .clk(clk), // input wire clk
    .probe0(dout[0]), // input wire [7:0]  probe0  
    .probe1(dout[1]), // input wire [7:0]  probe1 
    .probe2(dout[2]), // input wire [7:0]  probe2 
    .probe3(out[0]), // input wire [16:0]  probe3 
    .probe4(out[1]), // input wire [16:0]  probe4 
    .probe5(out[2]), // input wire [16:0]  probe5 
    .probe6(out[3]), // input wire [16:0]  probe6 
    .probe7(out[4]), // input wire [16:0]  probe7 
    .probe8(out[5]), // input wire [16:0]  probe8 
    .probe9(out[6]), // input wire [16:0]  probe9 
    .probe10(out[7]), // input wire [16:0]  probe10 
    .probe11(out[8]), // input wire [16:0]  probe11 
    .probe12(out[9])  // input wire [16:0]  probe12
);

genvar i;
generate
    for (i = 0; i < 10; i = i + 1) begin : dsp_loop
        dsp_macro_0 dsp_instance (
            .CLK(clk),      // input wire CLK
            .A(dout[0][(i+1)*8 - 1: i * 8]),    // input wire [7 : 0] A
            .B(dout[1][(i+1)*8 - 1: i * 8]),    // input wire [7 : 0] B
            .C(dout[2][(i+1)*8 - 1: i * 8]),    // input wire [7 : 0] C
            .P(out[i])      // output wire [16 : 0] P
        );
    end
endgenerate

blk_mem_gen_0 mem_0 (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(address),  // input wire [0 : 0] addra
  .dina(din[0]),    // input wire [79 : 0] dina
  .douta(dout[0])  // output wire [79 : 0] douta
);

blk_mem_gen_1 mem_1 (
    .clka(clk),      // input wire clka
    .ena(ena),       // input wire ena
    .wea(wea),       // input wire [0 : 0] wea
    .addra(address), // input wire [3 : 0] addra
    .dina(din[1]),   // input wire [7 : 0] dina
    .douta(dout[1])  // output wire [7 : 0] douta
);

blk_mem_gen_2 mem_2 (
    .clka(clk),      // input wire clka
    .ena(ena),       // input wire ena
    .wea(wea),       // input wire [0 : 0] wea
    .addra(address), // input wire [3 : 0] addra
    .dina(din[2]),   // input wire [7 : 0] dina
    .douta(dout[2])  // output wire [7 : 0] douta
);

initial begin
    address = 4'b0000;  
    ena = 1;
    wea = 0;
end

endmodule