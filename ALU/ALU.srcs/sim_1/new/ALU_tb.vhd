----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2020 05:03:30 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

component ALU is
  Port ( 
    RA, RB : in std_logic_vector(23 downto 0);
    OP : in std_logic_vector(4 downto 0);
    CFLAG : out std_logic;
    ALU_OUT : out std_logic_vector(23 downto 0)
  );

end component;
  
signal clk_test : std_logic;
signal ra_test, rb_test, ALU_output : std_logic_vector(23 downto 0);
signal OP_test : std_logic_vector(4 downto 0);
signal LDST_output : std_logic_vector(7 downto 0);
signal cflag_out : std_logic;
constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2

begin

UUT: ALU port map (
    ra => ra_test,
    rb => rb_test,
    alu_out => alu_output,
    op => op_test,
    cflag => cflag_out
    );
    
    
CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;

    tb : process
    begin
        ra_test <= "000000000000000000000001"; -- 1
        rb_test <= "000000000000000000000011"; -- 3
        wait for 100ns;
        op_test <= "10000"; --add
        wait for 50ns;
        op_test <= "10001"; -- sub
        wait for 50ns;
        op_test <= "10010"; -- mult
        wait for 50ns;
        op_test <= "10011"; -- div
        wait for 50ns;
        op_test <= "10100"; -- and        
        wait for 50ns;
        op_test <= "10101"; -- or
        wait for 50ns;
        op_test <= "10110"; --xor
        wait for 50ns;
        op_test <= "00101"; --inc
        wait for 50ns;
        op_test <= "00110"; --dec
        wait for 50ns;
        op_test <= "00111"; --neg
        wait for 50ns;   
    end process;
end Behavioral;
