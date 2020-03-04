--TOp Module Template Connected to XDC
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KeyboardTopModule is
    Port ( CLK : in STD_LOGIC;
           PS2_C : in STD_LOGIC;
           PS2_D : in STD_LOGIC;
           LED_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC);
end KeyboardTopModule;

architecture Behavioral of KeyboardTopModule is
component ps2Controller is
    Port ( reset    : in    STD_LOGIC;
           ps2_clk  : in    STD_LOGIC;
           ps2_data : in    STD_LOGIC;
           keycode  : out   STD_LOGIC_VECTOR (7 downto 0);
           valid    : out   STD_LOGIC);
end component;

component ScanToAscii is
    Port ( scancode : in  STD_LOGIC_VECTOR (7 downto 0);
           valid : in  STD_LOGIC;
           ascii : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal validOut : std_logic;
signal output : std_logic_vector(7 downto 0);
signal asciiOut : std_logic_vector(7 downto 0);
signal clkdiv : std_logic_vector(31 downto 0);
begin
    u1: ps2Controller port map (
        reset => RST,
        ps2_clk => PS2_C,
        ps2_data => PS2_D,
        keycode => output,
        valid => validOut
    );

    u2: ScanToAscii port map(
        scancode => output,
        valid => '1',
        ascii => asciiOut
    );

Process(CLK)
begin
if(CLK'EVENT AND CLK='1') then
    if(clkdiv(26)='1')then
    LED_OUT <= asciiOut;
    else
       clkdiv <= std_logic_vector(to_unsigned(to_integer(unsigned(clkdiv )) + 1, 32)); 
    end if;
end if;

end Process;
end Behavioral;
