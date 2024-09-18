commands list

```python
create_project project_10 E:/project_10 -part xc7a35tcpg236-1
```

```python
import_files -norecurse E:/FPGA-24/Assignment-1/updated_codes/q1/mac_dsp.v
update_compile_order -fileset sources_1
import_files -force -norecurse E:/FPGA-24/Assignment-1/updated_codes/q1/mac_dsp.v
import_files -norecurse E:/FPGA-24/Assignment-1/updated_codes/q2/mac_luts.v
update_compile_order -fileset sources_1
add_files -fileset constrs_1 -norecurse E:/FPGA-24/7-segment-display/Code-Template/constraints.xdc
import_files -fileset constrs_1 E:/FPGA-24/7-segment-display/Code-Template/constraints.xdc
update_compile_order -fileset sources_1
set_property top Seven_segment_LED_Display_Controller [current_fileset]
update_compile_order -fileset sources_1
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_0
set_property -dict [list \
  CONFIG.Coe_File {E:/FPGA-24/class_quiz_3/8bit.coe} \
  CONFIG.Load_Init_File {true} \
  CONFIG.Write_Depth_A {8} \
  CONFIG.Write_Width_A {18} \
] [get_ips blk_mem_gen_0]
```



