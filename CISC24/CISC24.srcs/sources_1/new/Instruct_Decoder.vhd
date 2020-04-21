----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2020 05:33:52 PM
-- Design Name: 
-- Module Name: Instruct_Decoder - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruct_Decoder is
 Port ( 
    instruct: in std_logic_vector(23 downto 0);
    clk: in std_logic;
    Addr_modeA, addr_modeB: out std_logic_vector(1 downto 0);
    OP_code:out std_logic_vector (4 downto 0);
    srcA,srcB:out std_logic_vector(2 downto 0);
    imm:out std_logic_vector(18 downto 0)
 );
end Instruct_Decoder;

architecture Behavioral of Instruct_Decoder is
SIGNAL OPC: STD_LOGIC_VECTOR(4 DOWNTO 0);
begin
Process(clk)
begin
    if(CLK' event and clk='1')then
        op_code<=instruct(23 downto 19);
        OPC<=INSTRUCT(23 DOWNTO 19);
        -- ZERO OPERAND
        IF (OPC="00000") THEN
            --HALT
            ADDR_MODEA<="ZZ";
            ADDR_MODEB<="ZZ";
            SRCA<="ZZZ";
            SRCB<="ZZZ";
            IMM<="ZZZZZZZZZZZZZZZZZZZ";
        -- ONE OPERAND
        ELSIF((OPC<"01010" or OPC > "10110")AND OPC /= "01011")THEN
        -- CLR,INC,DEC,NEG
            ADDR_MODEA<=INSTRUCT(18 DOWNTO 17);
            ADDR_MODEB<="ZZ";
            SRCA<=INSTRUCT(16 DOWNTO 14);
            SRCB<="ZZZ";
            IMM<="00000"&INSTRUCT(13 DOWNTO 0);
        ELSIF(OPC="01011") THEN     --MVMI
            ADDR_MODEA<="ZZ";
            ADDR_MODEB<="ZZ";
            SRCA<="ZZZ";
            SRCB<="ZZZ";
            IMM<=INSTRUCT(18 downto 0);
        -- TWO OPERAND
        ELSE
        --THE REST
            ADDR_MODEA<=INSTRUCT(18 DOWNTO 17);
            ADDR_MODEB<=INSTRUCT(13 DOWNTO 12);
            SRCA<=INSTRUCT(16 DOWNTO 14);
            SRCB<=INSTRUCT(11 DOWNTO 9);
            IMM<="0000000000"&INSTRUCT(8 DOWNTO 0);
        END IF;
    end if;
end process;
end Behavioral;
