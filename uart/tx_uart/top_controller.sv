`timescale 1ns / 1ps

module top_controller #(N_DATA_BITS = 8)(
    input   i_clk_100M,
            i_data_valid,
            [N_DATA_BITS-1:0] i_uart_tx_data,
    output   o_uart_tx,
             uart_tx_ready
);

    localparam OVERSAMPLE = 13;
                
    localparam integer UART_CLOCK_DIVIDER = 64;
    localparam integer MAJORITY_START_IDX = 4;
    localparam integer MAJORITY_END_IDX = 8;
    localparam integer UART_CLOCK_DIVIDER_WIDTH = $clog2(UART_CLOCK_DIVIDER);
    
    wire reset;
    
    reg uart_clk_rx;
    reg uart_en_rx;
    reg [UART_CLOCK_DIVIDER_WIDTH:0] uart_divider_counter_rx;

    reg uart_clk_tx;
    reg uart_en_tx;
    reg [UART_CLOCK_DIVIDER_WIDTH:0] uart_divider_counter_tx;
    
    
    
    // Variables for the seven segment display

    vio_0 reset_source (
      .clk(i_clk_100M),
      .probe_out0(reset)  // output wire [0 : 0] probe_out0
    );
   
    
    ila_0 ila_signal (
	   .clk(uart_clk_rx), // input wire clk


	   .probe0(i_data_valid), // input wire [0:0]  probe0  
	   .probe1(i_uart_tx_data), // input wire [7:0]  probe1 
	   .probe2(uart_tx_ready), // input wire [0:0]  probe2 
	   .probe3(o_uart_tx), // input wire [0:0]  probe3
	   .probe4(uart_en_tx) // input wire [0:0]  probe4
    );
    
    
        
    clk_wiz_0 instance_name(
    // Clock out ports
    .clk_out1(uart_clk_rx),     // output clk_out1
    .clk_out2(uart_clk_tx),     // output clk_out2
   // Clock in ports
    .clk_in1(i_clk_100M)); 

    uart_tx #(.N_DATA_BITS(N_DATA_BITS)) uart_transmistter (.i_uart_clk(uart_clk_tx),.i_uart_en(uart_en_tx),.i_uart_reset(reset),.i_uart_data_valid(i_data_valid),.i_uart_data(i_uart_tx_data),.o_uart_ready(uart_tx_ready),.o_uart_tx(o_uart_tx));
    
    
    always @(posedge uart_clk_rx) begin
        if(uart_divider_counter_rx < (UART_CLOCK_DIVIDER-1))
            uart_divider_counter_rx <= uart_divider_counter_rx + 1;
       else
            uart_divider_counter_rx <= 'd0;
    end
    
    always @(posedge uart_clk_rx) begin
        uart_en_rx <= (uart_divider_counter_rx == 'd10); 
    end
    
    always @(posedge uart_clk_tx) begin
        if(uart_divider_counter_tx < (UART_CLOCK_DIVIDER-1))
            uart_divider_counter_tx <= uart_divider_counter_tx + 1;
       else
            uart_divider_counter_tx <= 'd0;
    end
    
    always @(posedge uart_clk_tx) begin
        uart_en_tx <= (uart_divider_counter_tx == 'd10); 
    end
    
    
endmodule
