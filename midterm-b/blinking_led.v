module  blink(
    input clk,
    output reg led
    );

reg [31:0]count;

 initial begin
//       updated
       count =0;
       led=0;
        
       
    end

always @(posedge clk) begin

if(count == 99999999) begin //blink
    count <= 0;             //Reset count register
    led <= ~led;            //Toggle led (in each second)
end else begin
    count <= count + 1;      
    end

end

endmodule

