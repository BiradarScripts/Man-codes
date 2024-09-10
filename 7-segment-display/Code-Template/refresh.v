reg [19:0] refresh_counter; 
// the first 18-bit for creating 2.6ms digit period
// the other 2-bit for creating 4 LED-activating signals
wire [1:0] LED_activating_counter; 
// count        0    ->  1  ->  2  ->  3
// activates    LED1    LED2   LED3   LED4
// and repeat
always @(posedge clock_100Mhz or posedge reset)
begin 
 if(reset==1)
  refresh_counter <= 0;
 else
  refresh_counter <= refresh_counter + 1;
end 
assign LED_activating_counter = refresh_counter[19:18];
