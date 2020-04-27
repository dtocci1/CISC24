----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2020 09:21:45 PM
-- Design Name: 
-- Module Name: ReadInput - Behavioral
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

entity ReadInput is
 Port (
    clk, rst : std_logic;
    enter : in std_logic;
    sw : in std_logic_vector(14 downto 0);
    ready : out std_logic :='0'; --if instruction is full and ready to be moved
    LED: out std_logic_vector (4 downto 0) := "00000";
    instruct_out : out std_logic_vector(23 downto 0);
    addr_out : out std_logic_vector(4 downto 0)
  );
end ReadInput;

architecture Behavioral of ReadInput is

    signal inputFlag : std_logic:='0';
    signal instruction : std_logic_vector(23 downto 0) := "000000000000000000000000";
    signal count : std_logic_vector (4 downto 0):="00001";
    signal previous : std_logic;
begin


process(clk)
begin 
if(clk'event and clk='1') then
    if(enter /= previous) then
            previous<=enter;
            if (inputFlag ='1') then
                LED <= count;
                instruction(8 downto 0) <= sw(8 downto 0);
                instruct_out<=instruction;
                ready<='1';
                count<=std_logic_vector(to_unsigned(to_integer(unsigned(count)) + 1, 5));
                addr_out<=std_logic_vector(to_unsigned(to_integer(unsigned(count)) - 1, 5));
                inputFlag<='0';
            else
                instruction(23 downto 9) <= sw(14 downto 0);
                inputFlag<='1';
            end if;
            ready<='0';
    end if;
end if;
end process;
end Behavioral;
