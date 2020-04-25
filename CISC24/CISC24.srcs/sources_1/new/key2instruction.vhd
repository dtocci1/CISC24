----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2020 05:24:48 PM
-- Design Name: 
-- Module Name: Key2Instruction - Behavioral
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

entity Key2Instruction is
  Port (
    clk,rst : in std_logic;
    instruction_out : out std_logic_vector(23 downto 0)
   );
end Key2Instruction; 

architecture Behavioral of Key2Instruction is

begin
process(clk,rst)
begin
    if (clk='1' and clk'event) then
        instruction_out<="000000000000000000000000";
    end if;
end process;
end Behavioral;
