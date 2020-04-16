----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2020 01:04:13 PM
-- Design Name: 
-- Module Name: InstructPhaseControl - Behavioral
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

entity InstructPhaseControl is
  Port ( 
  CLK : in std_logic;
  RST : in std_logic;
  opcode : in std_logic_vector(4 downto 0);
  output : out std_logic_vector (3 downto 0)
  );
end InstructPhaseControl;

architecture Behavioral of InstructPhaseControl is

    TYPE STATE_TYPE IS (S0, S1, S2, S3, S4, S5, S6, S7, S8);
    SIGNAL CURRENT_STATE, NEXT_STATE: STATE_TYPE;

    BEGIN
        -- Process to hold combinational logic.
        COMBIN: PROCESS(CURRENT_STATE, opcode)
        BEGIN
            CASE CURRENT_STATE IS
                WHEN S0 => --FETCH
                    output<="0000";
                    NEXT_STATE<= S1;
                WHEN S1 => --DECODE
                   output<="0001";
                   NEXT_STATE<=S2;
                WHEN S2 =>
                    IF ((opcode >"01001") AND (OPCODE < "01110")) THEN --meM
                        OUTPUT <="0010";
                        NEXT_STATE <= S6;
                    ELSE
                        OUTPUT<="0011";
                        NEXT_STATE <= S3;
                    END IF;
               WHEn S3=> --oprnd
                    OUTPUT<="0100";
                    NEXT_STATE <= S4;
               WHEN S4 => --exec alu
                    OUTPUT<="0101";
                    NEXT_STATE<= S5;
               WHEN S5=> --write reg
                    OUTPUT<="0110";
                    NEXT_STATE<= S0;
               WHEN S6=> --exec offset
                    OUTPUT<="0111";
                    NEXT_STATE<= S7;
               WHEN S7=> --mem READ
                    OUTPUT<="1000";
                    NEXT_STATE<= S8;
               WHEN S8=> --wRITE REG
                    OUTPUT<="1001";
                    NEXT_STATE<= S0;  
            END CASE;
        END PROCESS COMBIN;

        -- Process to hold synchronous elements (flip-flops)
        SYNCH: PROCESS(CLK,RST)
        BEGIN
            IF (RST='1') THEN
                    CURRENT_STATE <= S0;
            ELSIF (CLK'EVENT AND CLK = '1') THEN
                    CURRENT_STATE <= NEXT_STATE;
            END IF;
        END PROCESS SYNCH;

END Behavioral;
