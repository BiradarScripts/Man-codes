module  blink(
    input clk,
    input rst,
    output reg led1,
    output reg led2,
    output reg led3

    );

reg [31:0]count;
reg[1:0] led_number=0;

 initial begin
//       updated
       count =0;
       led1=0;
       led2=0;
       led3=0;  
        
       
    end

always @(posedge clk or posedge rst) begin
 
 if(rst)
 begin
 count=0;
 led_number=0;
 led1=0;
 led2=0;
 led3=0;
 end
if(count == 99999999) begin //blink
    count <= 0;             //Reset count register
    if(led_number==0) 
    begin
        led1 <= ~led1;      //Toggle led1
        led_number <= 1;
        end
      if(led_number==1) 
    begin
        led2 <= ~led2;      //Toggle led1
        led_number <= 2;
        end
      if(led_number==2) 
    begin
        led3 <= ~led3;      //Toggle led1
        led_number <= 0;
        end

end else begin
    count <= count + 1;      
    end

end

endmodule

