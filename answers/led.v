module Seven_segment_LED_Display_Controller(
    input clock_100Mhz, // 100 MHz clock source on Basys 3 FPGA
    input reset,        // Reset signal
    output reg [3:0] Anode_Activate, // Anode signals of the 7-segment LED display
    output reg [6:0] LED_out         // Cathode patterns of the 7-segment LED display
);

    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter;      // Counter for refresh rate of 7-segment display
    wire [1:0] LED_activating_counter; 
    wire [31:0] internal_count;      // Wire to connect internal count from blink module

    // Instantiate the blink module
    blink blink_inst (
        .reset(reset),
        .clk(clock_100Mhz),
        .led1(),   // These outputs are unused in this case, but they remain functional
        .led2(),
        .led3(),
        .internal_count(internal_count) // Connecting internal count to be displayed
    );

    always @(posedge clock_100Mhz or posedge reset) begin
        if(reset == 1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end

    assign LED_activating_counter = refresh_counter[19:18];

    // Anode activating signals for 4 LEDs, digit period of 2.6ms
    always @(*) begin
        case(LED_activating_counter)
            2'b00: begin
                Anode_Activate = 4'b0111; 
                // Activate LED1 and Deactivate LED2, LED3, LED4
                LED_BCD = internal_count / 1000;  // The first digit of the 32-bit number
            end
            2'b01: begin
                Anode_Activate = 4'b1011; 
                // Activate LED2 and Deactivate LED1, LED3, LED4
                LED_BCD = (internal_count % 1000) / 100;  // The second digit of the 32-bit number
            end
            2'b10: begin
                Anode_Activate = 4'b1101; 
                // Activate LED3 and Deactivate LED1, LED2, LED4
                LED_BCD = ((internal_count % 1000) % 100) / 10;  // The third digit of the 32-bit number
            end
            2'b11: begin
                Anode_Activate = 4'b1110; 
                // Activate LED4 and Deactivate LED1, LED2, LED3
                LED_BCD = ((internal_count % 1000) % 100) % 10;  // The fourth digit of the 32-bit number
            end
        endcase
    end

    // Cathode patterns of the 7-segment LED display
    always @(*) begin
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
