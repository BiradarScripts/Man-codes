module adder (
    input wire clk,
    input wire rst,
    input wire[1:0] a,
    input wire[1:0] b,
    output reg[2:0] sum
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
       sum<=2'b00;    
    end else begin
       sum<=a+b;        
    end
end


endmodule
                                                                                                                