// FPGA4Student.com: FPGA projects, Verilog projects, VHDL projects
// FPGA tutorial: seven-segment LED display controller on Basys 3 FPGA
module Seven_segment_LED_Display_Controller(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_out // cathode patterns of the 7-segment LED display
);
    reg [26:0] one_second_counter; // counter for generating 1 second clock enable
    wire one_second_enable; // one second enable for counting numbers
    reg [15:0] displayed_number; // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
    // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    wire [1:0] LED_activating_counter; 
    // activates LED1, LED2, LED3, LED4 and repeats
    
    reg ena, wea;
    reg [3:0] addra;
    reg [3:0] subaddra;
    wire dina;
    reg [1:0] matchBits;
    reg [3:0] rep; // Corrected declaration of `rep` as a reg
    
    initial begin
        ena = 1;
        wea = 0;
        addra <= 4'b0000; // Corrected to match 14-bit width
        subaddra <= 4'b0000;
        matchBits <= 2'b00;
        rep <= 4'b0000; // Correct initialization of `rep`
    end

    wire bit;
    reg [3:0]finalCount;

    blk_mem_gen_0 main_blk (
        .clka(clock_100Mhz),    // input wire clock
        .ena(ena),              // input wire enable
        .wea(wea),              // input wire write enable
        .addra(addra),          // input wire [13:0] address
        .dina(dina),            // input wire data in
        .douta(bit)             // output wire bit (data out)
    );

    wire temp;


    vio_0 your_instance_name (
  .clk(clock_100Mhz),                // input wire clk
  .probe_in0(addra),    // input wire [3 : 0] probe_in0
  .probe_in1(subaddra),    // input wire [3 : 0] probe_in1
  .probe_in2(rep),    // input wire [3 : 0] probe_in2
  .probe_out0(temp)  // output wire [0 : 0] probe_out0
);

    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset == 1)
            one_second_counter <= 0;
        else begin
            if (one_second_counter >= 99999999)
                one_second_counter <= 0;
            else
                one_second_counter <= one_second_counter + 1;
        end
    end

    assign one_second_enable = (one_second_counter == 99999999) ? 1 : 0;

    always @(posedge clock_100Mhz or posedge reset) begin
    if (reset == 1) begin
        addra <= 0;
        subaddra <= 0;
        rep <= 0; // Initialize `rep` to track the starting address
        displayed_number <= 0;
        finalCount <= 0;
        matchBits <= 0;

    end else if (one_second_enable == 1) begin
        subaddra <= subaddra + 1;

        if (subaddra == 4) begin
            rep <= rep + 1; 
            subaddra <= 0;
        end

        addra <= rep + subaddra;

         case (matchBits)
             0: if (bit == 1) matchBits <= 1; else matchBits <= 0;
             1: if (bit == 0) matchBits <= 2; else matchBits <= 0;
             2: if (bit == 1) matchBits <= 3; else matchBits <= 0;
             3: if (bit == 1) begin
                     finalCount <= finalCount + 1;
                     matchBits <= 0;
                end
             default: matchBits <= 0;
         endcase
//        if(matchBits==0 && bit==1)
//                matchBits<=matchBits+1;
//            else if(matchBits==1 && bit==0)
//                matchBits<=matchBits+1;
//            else if(matchBits==2 && bit==1)
//                matchBits<=matchBits+1;
//            else if(matchBits==3 && bit==1)
//            begin
//                finalCount<=finalCount+1;
//                matchBits<=0;
//            end
//            else
//                matchBits<=0;
//            displayed_number <= finalCount;

//         Update displayed number with final count
         displayed_number <= finalCount;
    end
end


    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset == 1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end

    assign LED_activating_counter = refresh_counter[19:18];

    // Anode activating signals for 4 LEDs
    always @(*) begin
        case (LED_activating_counter)
            2'b00: begin
                Anode_Activate = 4'b0111; // Activate LED1
                LED_BCD = displayed_number / 1000;
            end
            2'b01: begin
                Anode_Activate = 4'b1011; // Activate LED2
                LED_BCD = (displayed_number % 1000) / 100;
            end
            2'b10: begin
                Anode_Activate = 4'b1101; // Activate LED3
                LED_BCD = ((displayed_number % 1000) % 100) / 10;
            end
            2'b11: begin
                Anode_Activate = 4'b1110; // Activate LED4
                LED_BCD = ((displayed_number % 1000) % 100) % 10;
            end
        endcase
    end

    // Cathode patterns of the 7-segment LED display
    always @(*) begin
        case (LED_BCD)
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
            default: LED_out = 7'b0000001; // "0" (default)
        endcase
    end
endmodule
