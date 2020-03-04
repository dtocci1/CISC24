----------------------------------------------------------------------------------
-- Company: UMass Dartmouth
-- Engineer: 368 TA
-- Design Name: 
-- Module Name:    D_Flipflop
-- Transfers data from D to Q on falling edge
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_Flipflop is
    Port ( 
		CLK : in  STD_LOGIC;
		D_IN : in  STD_LOGIC;
		Q_OUT : out  STD_LOGIC);
end D_Flipflop;

architecture Behavioral of D_Flipflop is
begin

  process(CLK, D_IN)
  begin
    if(CLK'event and CLK = '0') then
      Q_OUT <= D_IN;
    end if;
  end process;
  
end Behavioral;