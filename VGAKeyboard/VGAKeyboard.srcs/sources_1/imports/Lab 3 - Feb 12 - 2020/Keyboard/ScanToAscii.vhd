----------------------------------------------------------------------------------
-- Company: University of Massachusetts Dartmouth
-- Department: Electrical and Computer Engineering
-- Engineer: ECE-368 TA
--
-- Module Name:    KeyToAscii - Behavioral 
-- Project Name:   PS2 Keyboard
-- Description:    Combinational module that outputs an ascii character 
--                  upon receiving a valid scancode
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity ScanToAscii is
    Port ( scancode : in  STD_LOGIC_VECTOR (7 downto 0);
           valid : in  STD_LOGIC;
           ascii : out  STD_LOGIC_VECTOR (7 downto 0));
end ScanToAscii;

architecture Dataflow of ScanToAscii is
    signal convert : STD_LOGIC_VECTOR(7 downto 0);
begin
    WITH scancode SELECT
        convert <= x"61" WHEN x"1C",   --a
                x"62" WHEN x"32",   --b
                x"63" WHEN x"21",   --c
                x"64" WHEN x"23",   --d
                x"65" WHEN x"24",   --e
                x"66" WHEN x"2B",   --f
                x"67" WHEN x"34",   --g
                x"68" WHEN x"33",   --h
                x"69" WHEN x"43",   --i
                x"6A" WHEN x"3B",   --j
                x"6B" WHEN x"42",   --k
                x"6C" WHEN x"4B",   --l
                x"6D" WHEN x"3A",   --m
                x"6E" WHEN x"31",   --n
                x"6F" WHEN x"44",   --o
                x"70" WHEN x"4D",   --p
                x"71" WHEN x"15",   --q
                x"72" WHEN x"2D",   --r
                x"73" WHEN x"1B",   --s
                x"74" WHEN x"2C",   --t
                x"75" WHEN x"3C",   --u
                x"76" WHEN x"2A",   --v
                x"77" WHEN x"1D",   --w
                x"78" WHEN x"22",   --x
                x"79" WHEN x"35",   --y
                x"7A" WHEN x"12",   --z
                x"FF" WHEN OTHERS;
                
    ascii <= convert when valid = '1' else x"00";
end Dataflow;

