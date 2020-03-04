----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 09:33:22 AM
-- Design Name: 
-- Module Name: reg_24bit - Behavioral
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

entity reg_24bit is
  Port ( 
    CLK : in std_logic;
    CLR : in std_logic;
    D_IN : in std_logic_vector(23 downto 0);
    Q_OUT : out std_logic_vector(23 downto 0);
    enable : in std_logic
  );
end reg_24bit;

architecture Behavioral of reg_24bit is
begin
    process(clk,clr)
    begin
        if clr = '1' then
            Q_OUT <= "000000000000000000000000";
        elsif (rising_edge(CLK) and enable = '1') then
            Q_OUT <= D_IN;
        end if;
    end process;
end Behavioral;
