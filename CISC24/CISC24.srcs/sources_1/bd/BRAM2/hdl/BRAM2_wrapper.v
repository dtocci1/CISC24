//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
//Date        : Tue Mar 31 16:36:14 2020
//Host        : DESKTOP-U27BNUF running 64-bit major release  (build 9200)
//Command     : generate_target BRAM2_wrapper.bd
//Design      : BRAM2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module BRAM2_wrapper
   (BRAM_PORTA_0_addr,
    BRAM_PORTA_0_clk,
    BRAM_PORTA_0_din,
    BRAM_PORTA_0_dout,
    BRAM_PORTA_0_en,
    BRAM_PORTA_0_we,
    BRAM_PORTB_0_addr,
    BRAM_PORTB_0_clk,
    BRAM_PORTB_0_din,
    BRAM_PORTB_0_dout,
    BRAM_PORTB_0_we);
  input [8:0]BRAM_PORTA_0_addr;
  input BRAM_PORTA_0_clk;
  input [23:0]BRAM_PORTA_0_din;
  output [23:0]BRAM_PORTA_0_dout;
  input BRAM_PORTA_0_en;
  input [0:0]BRAM_PORTA_0_we;
  input [8:0]BRAM_PORTB_0_addr;
  input BRAM_PORTB_0_clk;
  input [23:0]BRAM_PORTB_0_din;
  output [23:0]BRAM_PORTB_0_dout;
  input [0:0]BRAM_PORTB_0_we;

  wire [8:0]BRAM_PORTA_0_addr;
  wire BRAM_PORTA_0_clk;
  wire [23:0]BRAM_PORTA_0_din;
  wire [23:0]BRAM_PORTA_0_dout;
  wire BRAM_PORTA_0_en;
  wire [0:0]BRAM_PORTA_0_we;
  wire [8:0]BRAM_PORTB_0_addr;
  wire BRAM_PORTB_0_clk;
  wire [23:0]BRAM_PORTB_0_din;
  wire [23:0]BRAM_PORTB_0_dout;
  wire [0:0]BRAM_PORTB_0_we;

  BRAM2 BRAM2_i
       (.BRAM_PORTA_0_addr(BRAM_PORTA_0_addr),
        .BRAM_PORTA_0_clk(BRAM_PORTA_0_clk),
        .BRAM_PORTA_0_din(BRAM_PORTA_0_din),
        .BRAM_PORTA_0_dout(BRAM_PORTA_0_dout),
        .BRAM_PORTA_0_en(BRAM_PORTA_0_en),
        .BRAM_PORTA_0_we(BRAM_PORTA_0_we),
        .BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
        .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
        .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
        .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
        .BRAM_PORTB_0_we(BRAM_PORTB_0_we));
endmodule
