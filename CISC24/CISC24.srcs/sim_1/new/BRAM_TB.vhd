----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2020 04:41:31 PM
-- Design Name: 
-- Module Name: BRAM_TB - Behavioral
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

entity BRAM_TB is
--  Port ( );
end BRAM_TB;

architecture Behavioral of BRAM_TB is
 component BlockRAM is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_en : in STD_LOGIC;
    BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 );
    BRAM_PORTB_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTB_0_clk : in STD_LOGIC;
    BRAM_PORTB_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component BlockRAM;
  
  constant period : time := 10 ns;
  signal portA_addr, portB_addr: std_logic_vector(8 downto 0):="000000000";
  signal portA_in,portB_in,portA_out,portB_out:std_logic_vector(23 downto 0):="000000000000000000000000";
  signal clk:std_logic:='0';
  signal enable:std_logic:='1';
  signal write_enable:std_logic_vector(0 downto 0);
 
begin
UUT: BlockRAM port map (
    BRAM_PORTA_0_addr => portA_addr,
    BRAM_PORTA_0_clk => clk,
    BRAM_PORTA_0_din=>portA_in,
    BRAM_PORTA_0_dout=>portA_out,
    BRAM_PORTA_0_en=>enable,
    BRAM_PORTA_0_we=>write_enable,
    BRAM_PORTB_0_addr=>portB_addr,
    BRAM_PORTB_0_clk=>clk,
    BRAM_PORTB_0_din=>portB_in,
    BRAM_PORTB_0_dout=>portB_out,
    BRAM_PORTB_0_we=>write_enable
); 
    CLK_process : process
    begin
        CLK<= '0'; wait for period;
        CLK <= '1'; wait for period;
    end process CLK_Process;

    tb : process
    begin
   -- if(CLK'event and clk='1') then 
        write_enable<="1"; -- enable write
        portA_addr<="000000001";
        portA_in<=x"000010"; -- store 2 in memory loocation 1
        wait for 100ns;
        write_enable <="0"; -- enable read
        portB_addr<="000000001";
        wait for 100ns;
        write_enable<="1";
         portA_in<=x"000100";
         wait for 100ns;
    --end if;
    end process tb;
end Behavioral;
