--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
--Date        : Fri Mar 27 12:40:53 2020
--Host        : DESKTOP-U27BNUF running 64-bit major release  (build 9200)
--Command     : generate_target BRAM_wrapper.bd
--Design      : BRAM_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BRAM_wrapper is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_en : in STD_LOGIC;
    BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 );
    BRAM_PORTB_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTB_0_clk : in STD_LOGIC;
    BRAM_PORTB_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end BRAM_wrapper;

architecture STRUCTURE of BRAM_wrapper is
  component BRAM is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_en : in STD_LOGIC;
    BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 );
    BRAM_PORTB_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTB_0_clk : in STD_LOGIC;
    BRAM_PORTB_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component BRAM;
begin
BRAM_i: component BRAM
     port map (
      BRAM_PORTA_0_addr(8 downto 0) => BRAM_PORTA_0_addr(8 downto 0),
      BRAM_PORTA_0_clk => BRAM_PORTA_0_clk,
      BRAM_PORTA_0_din(23 downto 0) => BRAM_PORTA_0_din(23 downto 0),
      BRAM_PORTA_0_dout(23 downto 0) => BRAM_PORTA_0_dout(23 downto 0),
      BRAM_PORTA_0_en => BRAM_PORTA_0_en,
      BRAM_PORTA_0_we(0) => BRAM_PORTA_0_we(0),
      BRAM_PORTB_0_addr(8 downto 0) => BRAM_PORTB_0_addr(8 downto 0),
      BRAM_PORTB_0_clk => BRAM_PORTB_0_clk,
      BRAM_PORTB_0_din(23 downto 0) => BRAM_PORTB_0_din(23 downto 0),
      BRAM_PORTB_0_dout(23 downto 0) => BRAM_PORTB_0_dout(23 downto 0),
      BRAM_PORTB_0_we(0) => BRAM_PORTB_0_we(0)
    );
end STRUCTURE;
