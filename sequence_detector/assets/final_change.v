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
    wire [1:0] LED_activating_counter; 

    // Custom regs and wires
    reg ena;
    reg [3:0] addra;
    wire douta;
    wire [7:0] pattern_count;
    wire [7:0] count;

    // Add a maximum depth
    reg [3:0] max_depth = 4'b1111; // Set max depth here (you can adjust this value)

    initial
    begin 
        addra = 4'b0000;
        ena = 1'b1;
    end

    assign count = pattern_count;

    blk_mem_gen_0 your_instance_name (
        .clka(clock_100Mhz),    // input wire clka
        .ena(ena),              // input wire ena
        .addra(addra),          // input wire [3 : 0] addra
        .douta(douta)           // output wire [0 : 0] douta
    ); 

    PatternDetector aryaman_pattern(      
        .clock_100Mhz(clock_100Mhz),
        .reset(reset),
        .bit(douta),
        .one_second_enable(one_second_enable),
        .pattern_count(pattern_count) // Use wire instead of reg
    );

    vio_0 vio (
        .clk(clock_100Mhz),              // input wire clk
        .probe_in0(addra),               // input wire [3 : 0] probe_in0
        .probe_in1(douta),               // input wire [0 : 0] probe_in1
        .probe_in2(pattern_count),       // input wire [7 : 0] probe_in2
        .probe_in3(count)                // input wire [7 : 0] probe_in3
    );

    // Counter to create 1-second enable signal
    always @(posedge clock_100Mhz or posedge reset)
    begin
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

    // Main logic to increment `addra` and display the count
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if (reset == 1)
        begin
            displayed_number <= 0;
            addra <= 0;
        end
        else if (one_second_enable == 1)
        begin
            if (addra < max_depth)  // Add condition to stop after max depth
            begin
                addra <= addra + 1;
            end
            displayed_number <= count;
        end
    end

    // Refresh logic for the display
    always @(posedge clock_100Mhz or posedge reset)
    begin 
        if (reset == 1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 

    assign LED_activating_counter = refresh_counter[19:18];

    // Anode activating signals for 4 LEDs
    always @(*)
    begin
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

    // Cathode patterns of the 7-segment LED display
    always @(*)
    begin
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
