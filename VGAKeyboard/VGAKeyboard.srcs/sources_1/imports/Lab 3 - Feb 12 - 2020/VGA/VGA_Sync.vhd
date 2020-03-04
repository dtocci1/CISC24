---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: 368 TA
-- 
-- Module Name:    VGA Sync Generator
-- Project Name:   VGA
-- Description: Driver a VGA display
--   Display out an resolution of 800x600@60Hz
-- Notes:
--   Always read the data sheets	
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all; --needed for to_integer

entity vga_controller is
    Port ( RST       : in std_logic;
           PIXEL_CLK : in std_logic;
           HS        : out std_logic;
           VS        : out std_logic;
           HCOUNT    : out std_logic_vector(10 downto 0);
           VCOUNT    : out std_logic_vector(10 downto 0);
           BLANK     : out std_logic);
end vga_controller;

architecture Behavioral of vga_controller is
-- Constants for testing
--constant TdispV : integer range 0 to 521 := 20;
--constant TpwV	: integer range 0 to 521 :=  3;
--constant TfpV	: integer range 0 to 521 :=  2;
--constant TbpV	: integer range 0 to 521 :=  4;
--constant TsV	: integer range 0 to 521 := TdispV+TpwV+TfpV+TbpV;

--constant TdispH : integer range 0 to 800 := 30;
--constant TpwH	: integer range 0 to 800 :=  5;
--constant TfpH	: integer range 0 to 800 :=  4;
--constant TbpH	: integer range 0 to 800 :=  6;
--constant TsH	: integer range 0 to 800 := TdispH+TpwH+TfpH+TbpH;

-- constants for real life
-- todo you must fill these in for this to work
constant TsV	: integer range 0 to 525 := 525;
constant TdispV : integer range 0 to 525 := 480;
constant TpwV	: integer range 0 to 525 :=  2;
constant TfpV	: integer range 0 to 525 :=  10;
constant TbpV	: integer range 0 to 525 :=  33;

constant TsH	: integer range 0 to 800 := 800;
constant TdispH : integer range 0 to 800 := 640;
constant TpwH	: integer range 0 to 800 :=  96;
constant TfpH	: integer range 0 to 800 :=  16;
constant TbpH	: integer range 0 to 800 :=  48;

             
--0       HLINES HFP  HSP  HMAX
--|           |   |   |    |
--________________    _____
--            XXXX|___|XXXX


constant HLINES : integer range 0 to 800 := TdispH;
constant HFP	: integer range 0 to 800 := TdispH + TfpH;
constant HSP	: integer range 0 to 800 := TdispH + TfpH + TpwH;
constant HMAX   : integer range 0 to 800 := TsH;

constant VLINES : integer range 0 to 525 := TdispV;
constant VFP	: integer range 0 to 525 := TdispV + TfpV;
constant VSP	: integer range 0 to 525 := TdispV + TfpV + TpwV;
constant VMAX   : integer range 0 to 525 := TsV;

-- polarity of the horizontal and vertical synch pulse
-- todo figure out if the pulse is high or low
--if high put a '1'
--if low put a '0'
constant SPP   : std_logic := '0'; 

signal hcounter : integer range 0 to 800;
signal vcounter : integer range 0 to 525;
signal video_enable: std_logic;

begin

    hcount <= std_logic_vector(to_unsigned(hcounter,11));
    vcount <= std_logic_vector(to_unsigned(vcounter,11));
    blank <= not video_enable;
    video_enable <= '1' when (hcounter <= HLINES and vcounter <= VLINES) else '0';

    -- horizontal counter
    h_count: process(PIXEL_CLK)
    begin
        if(rising_edge(PIXEL_CLK)) then
            if(rst = '1') then
                hcounter <= 0;
            elsif(hcounter = HMAX) then
                hcounter <= 0;
            else
                hcounter <= hcounter + 1;
            end if;
        end if;
    end process h_count;

    -- vertical counter
    -- todo you must write this here
    v_count: process
    begin
        if(rising_edge(PIXEL_CLK)) then
            if(rst = '1') then
                vcounter <= 0;
            elsif(Vcounter = VMAX) then
                vcounter <= 0;
            elsif (hcounter = HMAX) then
                vcounter <= vcounter + 1;
            end if;
        end if;
    end process v_count;

    -- horizontal synch pulse
    -- todo you must fill in this process
    do_hs: process
    begin
           if(hcounter > HFP and hcounter <= HSP) then 
                HS <= SPP;
            else
                HS <= not SPP;
            end if;
    end process do_hs;

    -- generate vertical synch pulse
    do_vs: process(vcounter)
    begin
            if(vcounter > VFP and vcounter <= VSP) then 
                VS <= SPP;
            else
                VS <= not SPP;
            end if;
    end process do_vs;

end Behavioral;