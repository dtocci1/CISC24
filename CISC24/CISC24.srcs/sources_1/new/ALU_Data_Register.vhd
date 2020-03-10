----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2020 02:13:23 PM
-- Design Name: 
-- Module Name: ALU_Data_Register - Behavioral
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

entity ALU_Data_Register is
  Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
  );
end ALU_Data_Register;

architecture Behavioral of ALU_Data_Register is

component reg_24bit is
  Port ( 
    CLK : in std_logic;
    CLR : in std_logic;
    D_IN : in std_logic_vector(23 downto 0);
    Q_OUT : out std_logic_vector(23 downto 0) := "000000000000000000000000";
    enable : in std_logic
  );
end component;

begin
ALU_Data_Reg : reg_24bit port map (
    CLK => CLK,
    CLR => clear,
    D_IN => Data_in,
    enable => enable,
    Q_OUT => Data_out
);

end Behavioral;
