// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Sat Jun 27 18:11:05 2020
// Host        : arch running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/uros/sandbox/vivado/buffer/buffer.srcs/sources_1/ip/kernel_wrapper/kernel_wrapper_stub.v
// Design      : kernel_wrapper
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "rtl_kernel_wizard_v1_0_0_dummy,Vivado 2019.2" *)
module kernel_wrapper(ap_clk)
/* synthesis syn_black_box black_box_pad_pin="ap_clk" */;
  input ap_clk;
endmodule
