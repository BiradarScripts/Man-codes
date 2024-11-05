############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project matrixa
set_top matrixa
add_files matrixa.cpp
add_files -tb matrixa_test.cpp -cflags "-DHW_COSIM -Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution2" -flow_target vivado
set_part {xc7a35t-cpg236-1}
create_clock -period 10 -name default
source "./matrixa/solution2/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level all
export_design -format ip_catalog
