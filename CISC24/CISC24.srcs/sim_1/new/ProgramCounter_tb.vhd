----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2020 12:18:22 PM
-- Design Name: 
-- Module Name: ProgramCounter_tb - Behavioral
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

entity ProgramCounter_tb is
--  Port ( );
end ProgramCounter_tb;

architecture Behavioral of ProgramCounter_tb is

component ProgramCounter is
  Port (
    CLK : in std_logic;
    RST : in std_logic;
    ClockCycle : in std_logic;
    jflag : in std_logic; -- flag signifying jump
    jump : in std_logic_vector(7 downto 0); -- can jump within 0-256 range
    PC : out std_logic_vector(7 downto 0) --256 bit PC
   );
end component;

signal CLK_test, RST_test, ClockCycle_test, jflag_test : std_logic := '0';
signal jump_test, PC_out : std_logic_vector(7 downto 0);
constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2

begin
UUT: ProgramCounter port map (
    CLK => clk_test,
    rst => rst_test,
    clockcycle => clockcycle_test,
    jflag => jflag_test,
    jump => jump_test,
    PC => pc_out
);

    CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;
    
    tb : process 
    begin
    wait for 90ns;
    -- test counting
    ClockCycle_test<='1';
    wait for 10ns;
    ClockCycle_test<='0';
    wait for 10ns;
    ClockCycle_test<='1';
    wait for 10ns;
    ClockCycle_test<='0';
    
    wait for 100ns;
    -- test jump
    jump_test <= x"0F"; -- jump location
    wait for 10ns;
    jflag_test <= '1'; -- set flag
    wait for 10ns;
    jflag_test<='0';
    wait for 10ns;
    
    wait for 100ns;
    -- test reset
    rst_test<='1';
    wait for 10ns;
    rst_test<='0';
    wait for 100ns;
    
    end process;

end Behavioral;
