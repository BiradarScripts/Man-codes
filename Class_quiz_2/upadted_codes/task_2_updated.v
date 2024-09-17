// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// FPGA tutorial: seven-segment LED display controller on Basys  3 FPGA
module Seven_segment_LED_Display_Controller(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
  
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_out// cathode patterns of the 7-segment LED display
    );
    reg [26:0] one_second_counter; // counter for generating 1 second clock enable
    wire one_second_enable;// one second enable for counting numbers
    reg [15:0] displayed_number; // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    wire [1:0] LED_activating_counter; 
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
 
reg ena;
reg [3:0] addra; 
wire[1:0] select;
wire[0:0] dummy;

initial
begin
ena=1;
addra = 4'b0000;

end

wire [17:0] a;
wire [17:0] b;
wire [17:0] d;
wire [47:0] c;
wire carryin;
wire[47:0] P ; 


blk_mem_gen_0 blck1 (
  .clka(clock_100Mhz),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(a)  // output wire [17 : 0] douta
);
blk_mem_gen_0 blck2 (
  .clka(clock_100Mhz),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(b)  // output wire [17 : 0] douta
);
blk_mem_gen_0 blck3 (
  .clka(clock_100Mhz),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(d)  // output wire [17 : 0] douta
);
blk_mem_gen_1 blck4 (
  .clka(clock_100Mhz),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addra),  // input wire [2 : 0] addra
  .douta(c)  // output wire [47 : 0] douta
); 


vio_0 your_instance_name (
  .clk(clock_100Mhz),                // input wire clk
  .probe_in0(dummy),    // input wire [0 : 0] probe_in0
  .probe_out0(select)  // output wire [1 : 0] probe_out0
);

alu alu_inst(a,b,d, c, select, carryin, clock_100Mhz, P );
 
    
//    -----------------------------------------------------------------------------
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1)
            one_second_counter <= 0;
        else begin
            if(one_second_counter>=99999999) 
                 one_second_counter <= 0;
            else
                one_second_counter <= one_second_counter + 1;
        end
    end 
    assign one_second_enable = (one_second_counter==99999999)?1:0;
    always @(posedge clock_100Mhz or posedge reset)
begin
//    if (reset == 1) begin
//        addra <= 0;
//        displayed_number <= P; // Reset the displayed_number to 0
//    end
//    else if (one_second_enable == 1) begin
//        addra <= addra + 1;
//        displayed_number <= douta; // Assign the value of douta to displayed_number
//    end
    if (reset == 1) begin
        addra <= 0;
        displayed_number <= 0; // Reset the displayed_number to 0
    end
    else if (one_second_enable == 1) begin
        addra <= addra + 1;
        displayed_number <= P; // Assign the value of douta to displayed_number
    end
end

    always @(posedge clock_100Mhz or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number/1000;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number % 1000)/100;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = ((displayed_number % 1000)%100)/10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number % 1000)%100)%10;
            // the fourth digit of the 16-bit number    
               end
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
 endmodule
