// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Apr 21 14:58:23 2020
// Host        : DESKTOP-U27BNUF running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/julia/Documents/GitHub/CISC24/CISC24/CISC24.srcs/sources_1/bd/BlockRAM/ip/BlockRAM_blk_mem_gen_0_0/BlockRAM_blk_mem_gen_0_0_stub.v
// Design      : BlockRAM_blk_mem_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2019.2" *)
module BlockRAM_blk_mem_gen_0_0(clka, ena, wea, addra, dina, douta, clkb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[8:0],dina[23:0],douta[23:0],clkb,web[0:0],addrb[8:0],dinb[23:0],doutb[23:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [8:0]addra;
  input [23:0]dina;
  output [23:0]douta;
  input clkb;
  input [0:0]web;
  input [8:0]addrb;
  input [23:0]dinb;
  output [23:0]doutb;
endmodule
