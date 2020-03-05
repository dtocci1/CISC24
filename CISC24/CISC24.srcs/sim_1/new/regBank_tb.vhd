----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 02:22:12 PM
-- Design Name: 
-- Module Name: regBank_tb - Behavioral
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

entity regBank_tb is
--  Port ( );
end regBank_tb;

architecture Behavioral of regBank_tb is

component regBank is
 Port (
    RA_addr, RB_addr : in std_logic_vector(2 downto 0);
    RA_Data_in : in std_logic_vector(23 downto 0);
    RA_out, RB_out : out std_logic_vector(23 downto 0);
    CLK : in std_logic;
    RW : in std_logic;
    CLR: in std_logic;
    toggle : in std_logic
  );
end component;

constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2
signal CLK_TEST: std_logic :='0';
signal RST_TEST: std_logic := '0';
signal addrA_TEST , addrB_TEST: std_logic_vector(2 downto 0);
signal data_TEST : std_logic_vector(23 downto 0) := "000000000000000000000000"; -- default 0 value
signal A_OUT_TEST : std_logic_vector(23 downto 0);
signal B_OUT_TEST : std_logic_vector(23 downto 0);
signal clear_TEST, RW_TEST : std_logic := '0';
signal toggle_test : std_logic := '0';

begin
    UUT: regBank port map (
    RA_addr => addrA_TEST, 
    RB_addr => addrB_TEST,
    RA_Data_in => data_TEST,
    RA_out => A_OUT_TEST,
    RB_out => B_OUT_TEST,
    CLK => CLK_TEST,
    RW => RW_TEST,
    CLR => CLEAR_TEST,
    toggle => toggle_test
    );
    CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;

    tb : process
    begin
    
    wait for 100ns;
    
--    -- write 0x01 to two different locations
--    data_TEST(7 downto 0) <= x"01";
--    --write to location 001 and 010
--    rw_test <= '1';
--    addrA_TEST <= "001";
--    addrB_TEST <= "010";
    
--    wait for 100 ns;
--    Clear_test <= '1';
--    wait for 10ns;
--    clear_test <= '0';
--    rw_test <= '0';
--    data_test(7 downto 0) <= x"02";
--    addrA_Test <= "001";
--    addrB_Test <= "111";
--    wait for 100 ns;
--    clear_test <= '1';
--    wait for 100 ns;
    data_TEST <= "000000000000000000000001";
    addrA_TEST <= "001"; -- SHOULD OUTPUT 0X00
    addrB_TEST <= "010"; -- SHOULD OUTPUT 0X00
    rw_test<='1';
    toggle_test <= not toggle_test; -- trigger regBank
    wait for 100 ns;
    addrA_TEST <= "001"; -- SHOULD OUTPUT 0X01
    addrB_TEST <= "001"; -- SHOULD OUTPUT 0X01
    rw_test<='0';
    toggle_test <= not toggle_test; -- trigger regBank
    wait for 100 ns;
    data_Test <= "000000000000000000000011";
    addrA_TEST <= "001"; -- SHOULD OUTPUT 0X00
    addrB_TEST <= "001"; -- SHOULD OUTPUT 0X01  ??
    rw_test<='1';
    toggle_test <= not toggle_test; -- trigger regBank
    wait for 100 ns;
    addrA_TEST <= "001"; -- SHOULD OUTPUT 0X04
    addrB_TEST <= "001"; -- SHOULD OUTPUT 0X04
    rw_test<='0';
    toggle_test <= not toggle_test; -- trigger regBank
    
    end process;
end Behavioral;
