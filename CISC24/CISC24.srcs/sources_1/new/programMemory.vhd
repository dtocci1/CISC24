----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2020 09:17:39 PM
-- Design Name: 
-- Module Name: programMemory - Behavioral
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

entity programMemory is
    Port ( clk : in std_logic;
           ready : in std_logic;
           addr: in std_logic_vector(4 downto 0);  
           read_Address : in std_logic_vector(4 downto 0);--
           din : in std_logic_vector(23 downto 0);
           dout : out std_logic_vector(23 downto 0) ;
           fullFlag : out std_logic := '0'
            );
end ProgramMemory;

architecture Behavioral of programMemory is

type memory is array (0 to (32-1)) of STD_LOGIC_vector(23 downto 0);
signal RAM  : memory;
---signal read_address : std_logic_vector(addr'range);    
signal full : std_logic:='0';
begin

RamProc: process(clk) is

  begin
    if (clk'event and clk = '1') then
      if (ready='1' and full='0') then
        ram(to_integer(unsigned(addr))) <= din;
      end if;
        if (addr="11111")then
            fullFlag<='1';
            full<='1';
        end if;
        --read_address <= addr;
    end if;
  end process RamProc;

  dout <= ram(to_integer(unsigned(read_address)));
end behavioral;