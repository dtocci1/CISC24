----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2020 11:05:38 AM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
  Port (
    CLK : in std_logic;
    RST : in std_logic;
    ClockCycle : in std_logic;
    jflag : in std_logic; -- flag signifying jump
    jump : in std_logic_vector(7 downto 0); -- can jump within 0-256 range
    PC : out std_logic_vector(7 downto 0) --256 bit PC
   );
end ProgramCounter;

architecture Behavioral of ProgramCounter is

signal count : std_logic_vector(7 downto 0) := "00000000";

begin
process(CLK)
begin
if(CLK='1' and CLK'event) then

    if (ClockCycle = '1') then
        count <=  std_logic_vector(to_unsigned(to_integer(unsigned(count)) + 1, 8)); -- increment counter
    elsif(RST = '1') then
        count <= x"00";
    end if;
    
    if (jflag = '1') then -- check for jump
                          -- count still holds jump location
        PC <= jump;
    else
        PC <= count;
    end if;
end if;

end process;

end Behavioral;
