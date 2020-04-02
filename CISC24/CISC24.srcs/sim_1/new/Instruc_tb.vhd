----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2020 03:00:20 PM
-- Design Name: 
-- Module Name: Instruc_tb - Behavioral
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

entity Instruc_tb is
--  Port ( );
end Instruc_tb;

architecture Behavioral of Instruc_tb is
COMPONENT Instruct_Decoder is
 Port ( 
    instruct: in std_logic_vector(23 downto 0);
    clk: in std_logic;
    Addr_modeA, addr_modeB: out std_logic_vector(1 downto 0);
    OP_code:out std_logic_vector (4 downto 0);
    srcA,srcB:out std_logic_vector(2 downto 0);
    imm:out std_logic_vector(18 downto 0)
 );
end COMPONENT;
constant period : time := 10 ns;
SIGNAL instruct_TEST:  std_logic_vector(23 downto 0);
SIGNAL clk_TEST:  std_logic;
SIGNAL Addr_modeA_TEST, addr_modeB_TEST: std_logic_vector(1 downto 0);
SIGNAL OP_code_TEST:std_logic_vector (4 downto 0);
SIGNAL srcA_TEST,srcB_TEST: std_logic_vector(2 downto 0);
SIGNAL imm_TEST: std_logic_vector(18 downto 0);
begin
 UUT: Instruct_Decoder port map (
    instruct => instruct_TEST,
    clk => clk_TEST,
    addr_modea => addr_modea_TEST,
    addr_modeb => addr_modeb_TEST,
    op_code => op_code_TEST,
    srca => srca_TEST,
    srcb => srcb_TEST,
    imm => imm_TEST
 );
    CLK_process : process
    begin
        CLK_TEST <= '0'; wait for period;
        CLK_TEST <= '1'; wait for period;
    end process CLK_Process;
    
    
 tb : process
    begin
    
    wait for 100ns;
    INSTRUCT_TEST<="000000000000000000000000";--HALT
    WAIT FOR 100NS;
    INSTRUCT_TEST<="001010011100000000000011";--INC, REG DIRECT
    WAIT FOR 100NS;
    INSTRUCT_TEST<="101100000100010000000011";--xor, REG DIRECT
    WAIT FOR 100NS;
END PROCESS;
end Behavioral;
