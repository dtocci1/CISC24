----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2020 04:54:59 PM
-- Design Name: 
-- Module Name: ControlModule_tb - Behavioral
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

entity ControlModule_tb is
--  Port ( );
end ControlModule_tb;

architecture Behavioral of ControlModule_tb is
component ControlModule is
  Port ( 
    clk,rst : in std_logic;
    sw : in std_logic_vector(15 downto 0);
    led : out std_logic_vector(4 downto 0):="00000"
  );
end component;
constant period : time := 10 ns;
signal clk_test, rst_test: std_logic;
signal sw_test: std_logic_vector(15 downto 0);
signal led_test: std_logic_vector( 4 downto 0);
begin
uut: ControlModule port map ( 
    clk=>clk_test,
    rst =>rst_test,
    sw =>sw_test,
    led => led_test
  );
CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;

    
 tb : process
    begin
    SW_TEST<="1101110000000000";    --ADDI1
    wait for 40ns;
    sw_TEST<="0000000000000010";    --ADDI 2
    wait for 40ns;
    SW_TEST<="1101110000100000";    --addi 1
    wait for 40 ns;
    sw_TEST<="0000000000000001";    --addi 2
    wait for 40ns;
    SW_TEST<="1011000000100000";    --MSM1
    wait for 40ns;
    sw_TEST<="0000000000001111";    --MSM2
    wait for 40ns;
    SW_TEST<="1011010010100000";    --MMS 1
    wait for 40 ns;
    sw_TEST<="0000000000001111";    --MMS 2
      wait for 40ns;
    SW_TEST<="1010000000000000";    --ADD1
    wait for 40ns;
    sw_TEST<="0000000000000000";    --ADD2
    wait for 40ns;
    SW_TEST<="1100010010000101";    --SUB 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --SUB 2
     wait for 40ns;
    SW_TEST<="1101000000000001";    --AND 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --AND 2
         wait for 40ns;
    SW_TEST<="1101010000000001";    --OR 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --OR 2
    wait for 40ns;
    SW_TEST<="1100000000000001";    --ADD 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --ADD 2
        wait for 40ns;
    SW_TEST<="1100100010100000";    --MUL 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --MUL 2
    wait for 40ns;
    SW_TEST<="1010100001100101";    --MVS 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --MVS 2
    wait for 40ns;
    SW_TEST<="1001000000000000";    --CLR 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --CLR 2
    wait for 40ns;
    SW_TEST<="1001010000100000";    --INC 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --INC 2
    wait for 40ns;
    SW_TEST<="1001100100100000";    --DEC 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --DEC 2
    wait for 40ns;
    SW_TEST<="1001110001100000";    --NEG 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --NEG 2
    wait for 40ns;
    SW_TEST<="1010000100101000";    --SLL 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --SLL 2
    wait for 40ns;
    SW_TEST<="1010010000100001";    --SLR 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --SLR 2
    wait for 40ns;
    SW_TEST<="1010110000001111";    --MVMI 1
    wait for 40 ns;
    sw_TEST<="0000000111111111";    --MVMI 2
    wait for 40ns;
    SW_TEST<="1100110000000001";    --DIV1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --DIV 2
    wait for 40ns;
    SW_TEST<="1001100000001100";    --XOR 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --XOR 2
    wait for 40ns;
    SW_TEST<="1110001000000000";    --SUBI 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --SUBI 2
    wait for 40ns;
    SW_TEST<="1000000000000000";    --HALT 1
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --HALT 2
    wait for 40 ns;
    sw_TEST<="0000000000000000";    --HALT 2
    end process;
end Behavioral;
