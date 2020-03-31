----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2020 11:18:59 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- CODE FROM:
--    https://www.fpga4student.com/2017/06/vhdl-code-for-arithmetic-logic-unit-alu.html
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
  Port ( 
    RA, RB : in std_logic_vector(23 downto 0);
    OP : in std_logic_vector(4 downto 0);
    CFLAG : out std_logic;
    ALU_OUT : out std_logic_vector(23 downto 0)
  );
end ALU;

architecture Behavioral of ALU is

signal carryTemp : std_logic_vector(24 downto 0);

begin
process(OP) -- run when OP code is input
begin

case OP is 
when "10000" => -- add
    ALU_OUT <= RA + RB;
when "10001" => -- subtract
    if (RB > RA) then
    ALU_OUT <= "000000000000000000000000";
    else
    ALU_OUT <= RA - RB;
    end if;
when "10010" => -- multiply
    ALU_OUT <= std_logic_vector(to_unsigned((to_integer(unsigned(RA)) * to_integer(unsigned(RB))),24)) ;
when "10011" => -- divide
    ALU_OUT <= std_logic_vector(to_unsigned(to_integer(unsigned(RA)) / to_integer(unsigned(RB)),24)) ;
when "01000" => -- LSL
    ALU_OUT <= std_logic_vector(unsigned(RA) sll to_integer(unsigned(RB(13 downto 9))));
when "01001" => -- LSR
    ALU_OUT <= std_logic_vector(unsigned(RA) srl to_integer(unsigned(RB(13 downto 9))));
when "10111" => -- ADDI
    ALU_OUT <= RA + RB(13 downto 0);
when "11000" => -- SUBI
    ALU_OUT <= RA - RB(13 downto 0);
when "10100" => -- AND
    ALU_OUT <= RA and RB;
when "10101" => -- OR
    ALU_OUT <= RA or RB;
when "10110" => -- XOR
    ALU_OUT <= RA xor RB;
when "00111" => -- NOT
    ALU_OUT <= NOT(RA);
when "00101" => -- INC 
    ALU_OUT <= RA + "000000000000000000000001";
when "00110" => -- DEC
    ALU_OUT <= RA - "000000000000000000000001";
when "01010" => --MVS
    --ALU_OUT <= ;
when "01011" => --MVMI

when "01100" => --MSM

when "01101" => --MMS

when others => -- invalid op code
    ALU_OUT <= "000000000000000000000000"; -- undefined
end case;
end process;
 carryTemp <= ('0' & RA) + ('0' & RB); -- take into account carry
 CFLAG <= carryTemp(24);
end Behavioral;
