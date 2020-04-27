----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 12:29:26 PM
-- Design Name: 
-- Module Name: reg_24bit_tb - Behavioral
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

entity reg_24bit_tb is
--  Port ( );
end reg_24bit_tb;

architecture Behavioral of reg_24bit_tb is

component reg_24bit is
  Port ( 
    CLK : in std_logic;
    CLR : in std_logic;
    D_IN : in std_logic_vector(23 downto 0);
    Q_OUT : out std_logic_vector(23 downto 0) := "000000000000000000000000";
    enable : in std_logic
  );
end component;

constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2
signal clk_test, clear_test, enable_test : std_logic;
signal d_in_test, q_out_test : std_logic_vector(23 downto 0);

begin
UUT : reg_24bit port map (
    CLK => CLK_test,
    CLR => clear_test,
    D_IN => D_in_test,
    enable => enable_test,
    Q_OUT => q_out_test
);

    CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;
    
    tb : process 
    begin
    wait for 100ns;
    enable_test<='1'; -- enable register
    d_in_test<=x"000001";
    wait for 100 ns;
    d_in_test<=x"000031";
    wait for 100ns;
    clear_test<='1';
    wait for 400 ns;
    end process;


end Behavioral;
