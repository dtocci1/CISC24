----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2020 06:34:45 PM
-- Design Name: 
-- Module Name: InputReader - Behavioral
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

-- 
-- "Instructions may be input through the keyboard (generated and stored during synthesis)and must be displayed on the 
-- VGA (7 segemnts or some other means"

-- Need to be able to type in instructions and store them all
-- Effectively code and store the commands so they are ready to run during synthesis
-- Need to show results
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity InputReader is
  Port ( 
  clk : in std_logic;
  rst : in std_logic
  -- Keyboard inputs and shit
  
  );
end InputReader;

architecture Behavioral of InputReader is

begin

process(CLK)
begin
    if(CLK'event and CLK='1') then
       -- read input from keyboard
       
       --display in HEX on LCD display
       
       -- if SemiColon? key is pressed, save input and make start newline
       
       -- if esc key is pressed, finish reading, begin run code


    end if;
end process;

end Behavioral;
