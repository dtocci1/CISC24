----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2020 11:54:55 AM
-- Design Name: 
-- Module Name: blockRAM - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY blockRAM IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (23 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 511;
      read_address:   IN   integer RANGE 0 to 511;
      we:    IN   std_logic;
      q:     OUT  std_logic_vector (23 DOWNTO 0)
   );
END blockRAM;
ARCHITECTURE rtl OF blockRAM IS
   TYPE mem IS ARRAY(0 TO 511) OF std_logic_vector(23 DOWNTO 0); -- 512x24bit array
   SIGNAL ram_block : mem;
BEGIN

   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            ram_block(write_address) <= data;
         END IF;
         q <= ram_block(read_address);
      END IF;
   END PROCESS;
END rtl;
