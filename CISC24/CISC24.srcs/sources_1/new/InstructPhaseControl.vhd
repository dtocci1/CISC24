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
  nextFlag : in std_logic;
  opcode : in std_logic_vector(4 downto 0);
  output : out std_logic_vector (2 downto 0)
  );
end InstructPhaseControl;

architecture Behavioral of InstructPhaseControl is

    TYPE STATE_TYPE IS (S0, S1, S2, S3, S4, S5, S6);
    SIGNAL CURRENT_STATE, NEXT_STATE: STATE_TYPE;

    BEGIN
        -- Process to hold combinational logic.
        COMBIN: PROCESS(CURRENT_STATE, opcode)
        BEGIN
            CASE CURRENT_STATE IS
                WHEN S0 => --FETCH
                    output<="000";
                    NEXT_STATE<= S1;
                WHEN S1 => --DECODE
                   output<="001";
                   NEXT_STATE<=S2;
                WHEN S2 =>
                    IF ((opcode >"01001") AND (OPCODE < "01110")) THEN --meM
                        OUTPUT <="010"; -- EXEC OFFSET
                        NEXT_STATE <= S5;
                    ELSE
                        OUTPUT<="011"; -- OPERAND
                        NEXT_STATE <= S3;
                    END IF;
               WHEn S3=> -- EXEC ALU
                    OUTPUT<="100";
                    NEXT_STATE <= S4;
               WHEN S4 => --WRITE REG
                    OUTPUT<="101";
                    NEXT_STATE<= S0;
               WHEN S5=> -- MEM READ
                    OUTPUT<="110";
                    NEXT_STATE<= S0;
               WHEN S6=> -- WRITE REG
                    OUTPUT<="111";
                    NEXT_STATE<= S0;

            END CASE;
        END PROCESS COMBIN;

        -- Process to hold synchronous elements (flip-flops)
        SYNCH: PROCESS(nextFlag,RST)
        BEGIN
        CURRENT_STATE <= NEXT_STATE;
            IF (RST='1') THEN
                    CURRENT_STATE <= S0;
            END IF;
        END PROCESS SYNCH;

END Behavioral;
