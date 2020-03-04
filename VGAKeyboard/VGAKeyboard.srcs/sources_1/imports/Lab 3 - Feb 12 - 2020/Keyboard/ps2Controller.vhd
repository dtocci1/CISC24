----------------------------------------------------------------------------------
-- Company: University of Massachusetts Dartmouth
-- Department: Electrical and Computer Engineering
-- Engineer: ECE-368 TA
--
-- Module Name:    ps2Controller
-- Project Name: 	 PS2 Keyboard
-- Description: FSM that reads in PS/2 data 
--		from keyboard and exports keycode byte.
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ps2Controller is
    Port ( reset    : in    STD_LOGIC;
           ps2_clk  : in    STD_LOGIC;
           ps2_data : in    STD_LOGIC;
           keycode  : out   STD_LOGIC_VECTOR (7 downto 0);
           valid    : out   STD_LOGIC);
end ps2Controller;

architecture Behavioral of PS2controller is

  type state_type is (s_start, s_d0, s_d1, s_d2, s_d3, s_d4, s_d5, s_d6, s_d7, s_parity, s_stop);  
  signal state : state_type;
  signal internal : std_logic_vector(7 downto 0);
begin
	FSM: process (ps2_clk, reset)
	begin
		if (reset = '1') then
			state <= s_start;
		-- this FSM is driven by the keyboard clock signal
		elsif (ps2_clk'EVENT and ps2_clk = '1') then
			case state is
        when s_start =>
          state <= s_d0;
        when s_d0 =>
          state <= s_d1;
        when s_d1 =>
          state <= s_d2;
        when s_d2 =>
          state <= s_d3;
        when s_d3 =>
          state <= s_d4;
        when s_d4 =>
          state <= s_d5;
        when s_d5 =>
          state <= s_d6;
        when s_d6 =>
          state <= s_d7;
        when s_d7 =>
          state <= s_parity;
        when s_parity =>
          state <=s_stop;
        when s_stop =>
          state <=s_start;
        when others =>
			end case;
		end if;
	end process;

	output_logic: process (state, ps2_data, reset)
	begin
    if (reset = '1') then
      keycode <= (others => '0');
    else
      case state is
        when s_d0 =>
          keycode(0) <= PS2_Data; -- read in bit 0 from keyboard      
         -- internal(0) <= PS2_Data; -- read in bit 1 from keyboard to signal
        when s_d1 =>
          keycode(1) <= PS2_Data; -- read in bit 1 from keyboard
         -- internal(1) <= PS2_Data; -- read in bit 1 from keyboard to signal
        when s_d2 =>
          keycode(2) <= PS2_Data; -- read in bit 2 from keyboard
         -- internal(2) <= PS2_Data; -- read in bit 2 from keyboard to signal
        when s_d3 =>
          keycode(3) <= PS2_Data; -- read in bit 3 from keyboard
          --internal(3) <= PS2_Data; -- read in bit 3 from keyboard to signal
        when s_d4 =>
          keycode(4) <= PS2_Data; -- read in bit 4 from keyboard
         -- internal(4) <= PS2_Data; -- read in bit 4 from keyboard to signal
        when s_d5 =>
          keycode(5) <= PS2_Data; -- read in bit 5 from keyboard
         -- internal(5) <= PS2_Data; -- read in bit 5 from keyboard to signal
        when s_d6 =>
          keycode(6) <= PS2_Data; -- read in bit 6 from keyboard
         -- internal(6) <= PS2_Data; -- read in bit 6 from keyboard to signal
        when s_d7 =>
          keycode(7) <= PS2_Data; -- read in bit 7 from keyboard
         -- internal(7) <= PS2_Data; -- read in bit 7 from keyboard to signal
        when others =>
      end case;
    end if;
        --if ( state=s_parity) then
        	--keycode<=internal;
       -- end if;
	end process;
	
	valid <= '1' when state = s_stop else '0';
  
end Behavioral;