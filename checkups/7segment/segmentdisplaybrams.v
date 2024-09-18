module Seven_segment_LED_Display_Controller(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_out// cathode patterns of the 7-segment LED display
    );

    reg [30:0] ten_second_counter; // counter for generating 10 second clock enable
    wire ten_second_enable; // 10 second enable for counting numbers
    reg [37:0] displayed_number; // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
    wire [1:0] LED_activating_counter;
    wire [17:0] A;
    wire [17:0] B;
    wire [17:0] C;
    reg ena, wea;
    reg [2:0] addra;
    wire [17:0] dina;

    initial begin
        ena = 1;
        wea = 0;
        addra = 3'b000;
    end

    blk_mem_gen_0 mema (
        .clka(clock_100Mhz),    // input wire clka
        .ena(ena),              // input wire ena
        .wea(wea),              // input wire [0 : 0] wea
        .addra(addra),          // input wire [2 : 0] addra
        .dina(dina),            // input wire [17 : 0] dina
        .douta(A)               // output wire [17 : 0] douta
    );

    blk_mem_gen_1 memb (
        .clka(clock_100Mhz),    // input wire clka
        .ena(ena),              // input wire ena
        .wea(wea),              // input wire [0 : 0] wea
        .addra(addra),          // input wire [2 : 0] addra
        .dina(dina),            // input wire [17 : 0] dina
        .douta(B)               // output wire [17 : 0] douta
    );

    blk_mem_gen_2 memc (
        .clka(clock_100Mhz),    // input wire clka
        .ena(ena),              // input wire ena
        .wea(wea),              // input wire [0 : 0] wea
        .addra(addra),          // input wire [2 : 0] addra
        .dina(dina),            // input wire [17 : 0] dina
        .douta(C)               // output wire [17 : 0] douta
    );

    wire [36:0] P;

    dsp_macro_0 your_dsp (
        .CLK(clock_100Mhz),     // input wire CLK
        .A(A),                  // input wire [17 : 0] A
        .B(B),                  // input wire [17 : 0] B
        .C(C),                  // input wire [17 : 0] C
        .P(P)                   // output wire [36 : 0] P
    );

    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset == 1)
            ten_second_counter <= 0;
        else begin
            if (ten_second_counter >= 999999999) // 10-second delay
                ten_second_counter <= 0;
            else
                ten_second_counter <= ten_second_counter + 1;
        end
    end

    assign ten_second_enable = (ten_second_counter == 999999999) ? 1 : 0;

    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset == 1) begin
            addra <= 3'b000;
            displayed_number <= 0;
        end
        else if (ten_second_enable == 1) begin
            addra <= addra + 1;
            displayed_number <= P;
        end
    end

    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset == 1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end

    assign LED_activating_counter = refresh_counter[19:18];

    always @(*) begin
        case (LED_activating_counter)
            2'b00: begin
                Anode_Activate = 4'b0111;
                LED_BCD = displayed_number / 1000;
            end
            2'b01: begin
                Anode_Activate = 4'b1011;
                LED_BCD = (displayed_number % 1000) / 100;
            end
            2'b10: begin
                Anode_Activate = 4'b1101;
                LED_BCD = ((displayed_number % 1000) % 100) / 10;
            end
            2'b11: begin
                Anode_Activate = 4'b1110;
                LED_BCD = ((displayed_number % 1000) % 100) % 10;
            end
        endcase
    end

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
            default: LED_out = 7'b0000001; // "0"
        endcase
    end

endmodule
