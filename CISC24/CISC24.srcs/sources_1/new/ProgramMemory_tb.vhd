----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 11:43:36 AM
-- Design Name: 
-- Module Name: ProgramMemory_tb - Behavioral
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

entity ProgramMemory_tb is
--  Port ( );
end ProgramMemory_tb;

architecture Behavioral of ProgramMemory_tb is

component programMemory is
    Port ( clk : in std_logic;
           ready : in std_logic;
           addr: in std_logic_vector(4 downto 0);  --
           din : in std_logic_vector(23 downto 0);
           read_Address : in std_logic_vector(4 downto 0);
           dout : out std_logic_vector(23 downto 0) ;
           fullFlag : out std_logic
            );
end component;

constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2
signal clk_test, ready_test, fullFlag_test : std_logic := '0';
signal addr_test, read_Address_test : std_logic_vector(4 downto 0) := "00000";
signal din_test, dout_test : std_logic_vector(23 downto 0) := x"000000";

begin 
UUT: programMemory port map (
clk=> clk_test,
ready=>ready_test,
addr => addr_test,
din => din_test,
read_Address => read_address_test,
dout => dout_test,
fullFlag => fullFlag_test
);

CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;

    
 tb : process
    begin
        
    wait for 100ns;
    --test write at PC= 0
    din_test <= x"000001"; --test: 1
    addr_test <= "00000"; -- PC=0
    ready_test<='1'; -- states instruction ready to be read in from input
    wait for 100ns;
    --test write at PC= 31 (last line in memory)
    din_test <= x"000003"; --test: 1
    addr_test <= "11111"; -- PC=31
    ready_test<='1'; -- states instruction ready to be read in from input
    wait for 100ns;
    -- Attempt to write after progMem is "full"
    din_test <= x"000003"; --test: 1
    addr_test <= "00000"; -- PC= 1
    ready_test<='1'; -- states instruction ready to be read in from input
    wait for 100ns;
    -- * nothing should be written here *
    
    -- test read at PC=0 (should output 1)
    read_address_test<= "00000";
    wait for 100ns;
    -- test read at PC=31 (should be 3)
    read_address_test<="11111";
    wait for 200ns;
    
    end process;
end Behavioral;
