############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project sequence
set_top sequence
add_files sequence.cpp
add_files -tb sequence_test.cpp -cflags "-DHW_COSIM"
open_solution "solution1" -flow_target vivado
set_part {xc7a35tcpg236-1}
create_clock -period 10 -name default
#source "./sequence/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
