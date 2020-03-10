----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:05 02/11/2017 
-- Design Name: 
-- Module Name:    vgaTest1_Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_RGB_Top is
  Port (CLK     : in std_logic;
        sw      : in std_logic_vector(7 downto 0);
        PS2_C : in std_logic;
        PS2_D : in std_logic;
        vgaRed   : out std_logic_vector(3 downto 0);
        vgaGreen : out std_logic_vector(3 downto 0);
        vgaBlue  : out std_logic_vector(3 downto 0);
        Hsync    : out std_logic;
        Vsync    : out std_logic;
        copy_Hsync    : out std_logic;
        copy_Vsync    : out std_logic;
        LED_OUT : out std_logic_vector(7 downto 0));
end VGA_RGB_Top;

architecture Behavioral of VGA_RGB_Top is
	COMPONENT vga_controller
	PORT(
		RST : IN std_logic;
		PIXEL_CLK : IN std_logic;          
		HS : OUT std_logic;
		VS : OUT std_logic;
		HCOUNT : OUT std_logic_vector(10 downto 0);
		VCOUNT : OUT std_logic_vector(10 downto 0);
		BLANK : OUT std_logic
		);
	END COMPONENT;
  
  COMPONENT ps2Controller is
  PORT (
    reset : in std_logic;
    ps2_clk : in std_logic;
    ps2_data : in std_logic;
    keycode : out std_logic_vector(7 downto 0);
    valid : out std_logic  
  );
  END COMPONENT;
  
  COMPONENT ScanToAscii is
  Port (
    scancode : in std_logic_vector(7 downto 0);
    valid : in std_logic;
    ascii : out std_logic_vector(7 downto 0)
  );
  END COMPONENT;
  
  COMPONENT FONT_ROM 
  PORT (
     CLK : in std_logic;
     ADDR : in std_logic_vector(10 downto 0);
     DATA : out std_logic_vector(7 downto 0)
   );
   END COMPONENT;
   
  signal validOut : std_logic;
  signal output : std_logic_vector(7 downto 0);
  signal codekey : std_logic_vector(7 downto 0);
  signal ascii_out : std_logic_vector(7 downto 0);
  signal clkdiv : std_logic_vector(31 downto 0);  
  signal HC : std_logic_vector(10 downto 0);
  signal VC : std_logic_vector(10 downto 0);
  signal HSTemp: std_logic;
  signal VSTemp: std_logic;
  signal Blank : std_logic;
  signal Clk_50M : std_logic;
  signal Clk_25M :std_logic;
  signal letterByte : std_logic_vector(7 downto 0);
  signal letterBit : std_logic;
  signal dataByte : std_logic_vector(10 downto 0);
  signal pxbit : std_logic;
  
begin

  process (clk)
  begin 
   if(rising_edge(clk)) then
    Clk_50M <=not Clk_50M;
   end if;
  end process;
  
  process(clk, Clk_50M)
  begin
    if(Clk_50M'event and Clk_50M = '1') then
        Clk_25M <= not Clk_25M;
     end if;
  end process;
  
	Inst_vga_controller: vga_controller PORT MAP(
		RST => '0',
		PIXEL_CLK => Clk_25M,
		HS => HSTemp,
		VS => VSTemp,
		HCOUNT => HC,
		VCOUNT => VC,
		BLANK => Blank
	);
u1 : ps2Controller port map(
    reset=>'0',
    ps2_clk=>PS2_C,
    ps2_data=>ps2_d,
    keycode=>codekey,
    valid=>validOut
);
u2:ScanToAscii port map(
    scancode=>codekey,
    valid=>'1',
    ascii=>ascii_Out
);
u3:font_rom port map(
clk=>clk_25m,
data=>letterByte,
addr=>dataByte
);

dataByte<=(ascii_out(6 downto 0)&VC(3 downto 0));

with HC(2 downto 0) select pxbit<=
    letterByte(7) when "000",
     letterByte(6) when "001",
      letterByte(5) when "010",
       letterByte(4) when "011",
        letterByte(3) when "100",
         letterByte(2) when "101",
          letterByte(1) when "110",
           letterByte(0) when "111";
           
           LED_OUT<=codekey;
           
           
  vgaRed(3 downto 0)   <="0000";-- HC(8 downto 5) when (Blank='0' and sw(0)='1') else (others=>'0');
  vgaGreen(3 downto 0) <="1111" when(blank='0');-- and pxbit='1'); --VC(7 downto 4) when (Blank='0' and sw(1)='1') else (others=>'0');
  vgaBlue(3 downto 0)  <="0000";-- HC(5 downto 2) when (Blank='0' and sw(2)='1') else (others=>'0');
   
  copy_HSYNC <= HSTemp;
  copy_VSYNC <= VSTemp;

  HSYNC <= HSTemp;
  VSYNC <= VSTemp;


end Behavioral;