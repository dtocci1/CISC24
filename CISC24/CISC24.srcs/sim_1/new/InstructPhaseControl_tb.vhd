----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2020 01:33:26 PM
-- Design Name: 
-- Module Name: InstructPhaseControl_tb - Behavioral
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

entity InstructPhaseControl_tb is
--  Port ( );
end InstructPhaseControl_tb;

architecture Behavioral of InstructPhaseControl_tb is
component InstructPhaseControl is
  Port ( 
  CLK : in std_logic;
  RST : in std_logic;
  opcode : in std_logic_vector(4 downto 0);
  output : out std_logic_vector (3 downto 0)
  );
end component;
constant period : time := 10 ns;
signal clk_test, rst_test: std_logic;
signal opcode_test: std_logic_vector(4 downto 0);
signal output_test: std_logic_vector( 3 downto 0);
begin
UUT: InstructPhaseControl port map (
clk=> clk_test,
rst=>rst_test,
opcode=>opcode_test,
output=>output_test
);
CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;

    
 tb : process
    begin

    
    end process;
end Behavioral;
