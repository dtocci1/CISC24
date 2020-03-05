----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 09:27:28 AM
-- Design Name: 
-- Module Name: regBank - Behavioral
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

entity regBank is
 Port (
    RA_addr, RB_addr : in std_logic_vector(2 downto 0);
    RA_Data_in : in std_logic_vector(23 downto 0);
    RA_out, RB_out : out std_logic_vector(23 downto 0);
    CLK : in std_logic;
    RW : in std_logic;
    CLR: in std_logic;
    toggle : in std_logic
  );
end regBank;
architecture Behavioral of regBank is
component reg_24bit is
  Port ( 
    CLK : in std_logic;
    CLR : in std_logic;
    enable : std_logic;
    D_IN : in std_logic_vector(23 downto 0);
    Q_OUT : out std_logic_vector(23 downto 0)
  );
end component;
signal regOutput0, regOutput1, regOutput2, regOutput3, regOutput4, regOutput5, regOutput6, regOutput7 : std_logic_vector(23 downto 0);
signal regEnable : std_logic := '0';
begin
reg0 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput0
);
reg1 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput1
);
reg2 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput2
);
reg3 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput3
);
reg4 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput4
);
reg5 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput5
);
reg6 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput6
);
reg7 : reg_24bit port map(
    CLK => CLK,
    CLR => CLR,
    D_IN => RA_DATA_IN,
    enable => regEnable,
    Q_OUT => regOutput7
);

process(toggle, CLR)
begin
    if CLR = '0' then
    regEnable<='0'; 
        case RB_ADDR is
            when "000" =>
                RB_out<=regOutput0;
            when "001" =>
                RB_out<=regOutput1;
            when "010" =>
                RB_out<=regOutput2;
            when "011" =>
                RB_out<=regOutput3;
            when "100" =>
                RB_out<=regOutput4;
            when "101" =>
                RB_out<=regOutput5;
            when "110" =>
                RB_out<=regOutput6;
            when "111" =>
                RB_out<=regOutput7;
            when others =>
                RB_OUT <="000000000000000000000000";
        end case;
    regEnable<='0';
    
    if(rw='0') then -- READ from regBank
    regEnable<='0';
         case RA_ADDR is
            when "000" =>
                RA_out<=regOutput0;
            when "001" =>
                RA_out<=regOutput1;
            when "010" =>
                RA_out<=regOutput2;
            when "011" =>
                RA_out<=regOutput3;
            when "100" =>
                RA_out<=regOutput4;
            when "101" =>
                RA_out<=regOutput5;
            when "110" =>
                RA_out<=regOutput6;
            when "111" =>
                RA_out<=regOutput7;
            when others =>
                RA_OUT <="000000000000000000000000";
        end case;
     else 
     regEnable<='1'; -- write to register
         case RA_ADDR is
            when "000" =>
                RA_out<="000000000000000000000000";
            when "001" =>
                RA_out<="000000000000000000000000";
            when "010" =>
                RA_out<="000000000000000000000000";
            when "011" =>
                RA_out<="000000000000000000000000";
            when "100" =>
                RA_out<="000000000000000000000000";
            when "101" =>
                RA_out<="000000000000000000000000";
            when "110" =>
                RA_out<="000000000000000000000000";
            when "111" =>
                RA_out<="000000000000000000000000";
            when others =>
                RA_OUT <="000000000000000000000000";
        end case;
        end if;
    end if;
end process;
end Behavioral;
