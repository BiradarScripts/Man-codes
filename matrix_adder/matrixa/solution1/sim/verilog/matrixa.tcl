
log_wave -r /
set designtopgroup [add_wave_group "Design Top Signals"]
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set return_group [add_wave_group return(memory) -into $coutputgroup]
add_wave /apatb_matrixa_top/AESL_inst_matrixa/result_d0 -into $return_group -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/result_we0 -into $return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/result_ce0 -into $return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/result_address0 -into $return_group -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set return_group [add_wave_group return(memory) -into $cinputgroup]
add_wave /apatb_matrixa_top/AESL_inst_matrixa/b_q0 -into $return_group -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/b_ce0 -into $return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/b_address0 -into $return_group -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/a_q0 -into $return_group -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/a_ce0 -into $return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/AESL_inst_matrixa/a_address0 -into $return_group -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake" -into $designtopgroup]
add_wave /apatb_matrixa_top/AESL_inst_matrixa/ap_start -into $blocksiggroup
add_wave /apatb_matrixa_top/AESL_inst_matrixa/ap_done -into $blocksiggroup
add_wave /apatb_matrixa_top/AESL_inst_matrixa/ap_idle -into $blocksiggroup
add_wave /apatb_matrixa_top/AESL_inst_matrixa/ap_ready -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_matrixa_top/AESL_inst_matrixa/ap_rst -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_matrixa_top/AESL_inst_matrixa/ap_clk -into $clockgroup
set testbenchgroup [add_wave_group "Test Bench Signals"]
set tbinternalsiggroup [add_wave_group "Internal Signals" -into $testbenchgroup]
set tb_simstatus_group [add_wave_group "Simulation Status" -into $tbinternalsiggroup]
set tb_portdepth_group [add_wave_group "Port Depth" -into $tbinternalsiggroup]
add_wave /apatb_matrixa_top/AUTOTB_TRANSACTION_NUM -into $tb_simstatus_group -radix hex
add_wave /apatb_matrixa_top/ready_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_matrixa_top/done_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_matrixa_top/LENGTH_a -into $tb_portdepth_group -radix hex
add_wave /apatb_matrixa_top/LENGTH_b -into $tb_portdepth_group -radix hex
add_wave /apatb_matrixa_top/LENGTH_result -into $tb_portdepth_group -radix hex
set tbcoutputgroup [add_wave_group "C Outputs" -into $testbenchgroup]
set tb_return_group [add_wave_group return(memory) -into $tbcoutputgroup]
add_wave /apatb_matrixa_top/result_d0 -into $tb_return_group -radix hex
add_wave /apatb_matrixa_top/result_we0 -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/result_ce0 -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/result_address0 -into $tb_return_group -radix hex
set tbcinputgroup [add_wave_group "C Inputs" -into $testbenchgroup]
set tb_return_group [add_wave_group return(memory) -into $tbcinputgroup]
add_wave /apatb_matrixa_top/b_q0 -into $tb_return_group -radix hex
add_wave /apatb_matrixa_top/b_ce0 -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/b_address0 -into $tb_return_group -radix hex
add_wave /apatb_matrixa_top/a_q0 -into $tb_return_group -radix hex
add_wave /apatb_matrixa_top/a_ce0 -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_matrixa_top/a_address0 -into $tb_return_group -radix hex
save_wave_config matrixa.wcfg
run all
quit

