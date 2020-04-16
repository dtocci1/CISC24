----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2020 01:56:40 PM
-- Design Name: 
-- Module Name: ControlModule - Behavioral
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

entity ControlModule is
  Port ( 
    clk,rst : in std_logic
    
  );
end ControlModule;

architecture Behavioral of ControlModule is

component InstructPhaseControl is
  Port ( 
  CLK : in std_logic;
  RST : in std_logic;
  opcode : in std_logic_vector(4 downto 0);
  output : out std_logic_vector (3 downto 0)
  );
end component;
component Instruct_Decoder is
 Port ( 
    instruct: in std_logic_vector(23 downto 0);
    clk: in std_logic;
    Addr_modeA, addr_modeB: out std_logic_vector(1 downto 0);
    OP_code:out std_logic_vector (4 downto 0);
    srcA,srcB:out std_logic_vector(2 downto 0);
    imm:out std_logic_vector(18 downto 0)
 );
end component;
component ALU is
  Port ( 
    RA, RB : in std_logic_vector(23 downto 0);
    OP : in std_logic_vector(4 downto 0);
    CFLAG : out std_logic;
    ALU_OUT : out std_logic_vector(23 downto 0)
  );
end component;
component regBank is
 Port (
    RA_addr, RB_addr : in std_logic_vector(2 downto 0);
    RA_Data_in : in std_logic_vector(23 downto 0);
    RA_out, RB_out : out std_logic_vector(23 downto 0);
    CLK : in std_logic;
    RW : in std_logic;
    Clear: in std_logic;
    toggle : in std_logic
  );
end component;
component ALU_Data_Register is
  Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
  );
end component;
component ASrc_reg_Register is
 Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
 );
end component;
component BSrc_reg_Register is
 Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
 );
end component;

component DST_ADDR_REGISTER is
 Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
 );
end component;

component InstructionRegister is
 Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
 );
end component;

component InputReader is
  Port ( 
  clk : in std_logic;
  rst : in std_logic
  -- Keyboard inputs and shit
  
  );
end component;
component ProgramCounter is
  Port (
    CLK : in std_logic;
    RST : in std_logic;
    ClockCycle : in std_logic;
    jflag : in std_logic; -- flag signifying jump
    jump : in std_logic_vector(7 downto 0); -- can jump within 0-256 range
    PC : out std_logic_vector(7 downto 0) --256 bit PC
   );
end component;

-- Main component signals
signal clear, toggle, carryFlag, clockCycleFlag, jumpFlag : std_logic;
signal AddressModeA, AddressModeB : std_logic_vector(1 downto 0);
signal sourceA,sourceB, RegisterA_addr, registerB_addr : std_logic_vector(2 downto 0);
signal FSMout : std_logic_vector(3 downto 0);
signal OP : std_logic_vector (4 downto 0);
signal programCount, jumpAddress : std_logic_vector(7 downto 0);
signal immediate : std_logic_vector (18 downto 0);
signal instruction, registerA,registerB,ALU_output,RegisterA_output,registerB_output, RegisterA_Input : std_logic_vector(23 downto 0);

-- Register signals
signal ALU_Reg_out, ASRC_Reg_out, BSRC_Reg_out, DST_Reg_out, Instruction_Reg_out: std_logic_vector(23 downto 0);
signal ALU_Reg_enable, ASRC_Reg_Enable, BSRC_Reg_Enable, DST_Reg_Enable, Instruction_Reg_Enable : std_logic;


begin


end Behavioral;
