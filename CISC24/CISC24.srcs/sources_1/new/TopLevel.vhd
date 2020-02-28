----------------------------------------------------------------------------------
-- Create Date: 02/28/2020 09:52:04 AM
-- Module Name: TopLevel - Behavioral
-- Project Name: CISC24
-- Target Devices: Nexys-4
-- Description:  
--  This file will synthesize all the units of the CISC24 architecture together
-- Dependencies: STD_LOGIC_1164, NUMERIC_STD
-- Revision: 0.01
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TopLevel is
  Port ( 
    CLK : in std_logic;
    RST : in std_logic;
    result : out std_logic_vector(7 downto 0) -- unknown output size, temp 8-bits
  );
end TopLevel;


architecture Behavioral of TopLevel is

begin


end Behavioral;
