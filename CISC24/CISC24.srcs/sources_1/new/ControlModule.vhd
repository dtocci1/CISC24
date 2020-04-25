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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlModule is
  Port ( 
    clk,rst : in std_logic;
    led0 : out std_logic
  );
end ControlModule;

architecture Behavioral of ControlModule is

component InstructPhaseControl is
  Port ( 
  CLK : in std_logic;
  RST : in std_logic;
  nextFlag : in std_logic;
  opcode : in std_logic_vector(4 downto 0);
  output : out std_logic_vector (2 downto 0)
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

--component DST_ADDR_REGISTER is
-- Port ( 
--    CLK : in std_logic;
--   Clear : in std_logic;
--    Data_in : in std_logic_vector(23 downto 0);
--    enable : in std_logic;
--    Data_out : out std_Logic_vector(23 downto 0)
-- );
--end component;

component InstructionRegister is
 Port ( 
    CLK : in std_logic;
    Clear : in std_logic;
    Data_in : in std_logic_vector(23 downto 0);
    enable : in std_logic;
    Data_out : out std_Logic_vector(23 downto 0)
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

component MMU is
  Port ( 
    clk: in std_logic;
    Addr_modeA, addr_modeB: in std_logic_vector(1 downto 0);
    OP_code:in std_logic_vector (4 downto 0);
    srcA,srcB:in std_logic_vector(2 downto 0);
    imm:in std_logic_vector(18 downto 0);
    dFlag: out std_logic
  );
  end component;
  
component key2instruction is
  Port (
    clk,rst : in std_logic;
    instruction_out : out std_logic_vector(23 downto 0)
   );
end component;

component BlockRAM is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTA_0_en : in STD_LOGIC;
    BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 );
    BRAM_PORTB_0_addr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    BRAM_PORTB_0_clk : in STD_LOGIC;
    BRAM_PORTB_0_din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    BRAM_PORTB_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component;
  

-- Main component signals
signal clear, toggle, carryFlag, clockCycleFlag, jumpFlag, nextFlag : std_logic :='0';
signal AddressModeA, AddressModeB : std_logic_vector(1 downto 0) := "00";
signal sourceA,sourceB, RegisterA_addr, registerB_addr : std_logic_vector(2 downto 0) := "000";
signal FSMout : std_logic_vector(2 downto 0) := "000";
signal OP : std_logic_vector (4 downto 0) := "00000";
signal programCount, jumpAddress : std_logic_vector(7 downto 0):= "00000000";
signal immediate : std_logic_vector (18 downto 0):= "0000000000000000000";
signal instruction,ALU_output,RegisterA_output,registerB_output, RegisterA_Input : std_logic_vector(23 downto 0) := "000000000000000000000000";
signal A_source, B_source : std_logic_vector(23 downto 0) := "000000000000000000000000";

-- Register signals
signal ALU_Reg_out, ASRC_Reg_out, BSRC_Reg_out, Instruction_Reg_out: std_logic_vector(23 downto 0) := "000000000000000000000000";
signal ALU_RW, ALU_Reg_enable, ASRC_Reg_Enable, BSRC_Reg_Enable, Instruction_Reg_Enable : std_logic := '0';

-- BlockRAM signals
signal RamA_Din, RamA_dout, RamB_din, RamB_dout : std_logic_vector(23 downto 0) := "000000000000000000000000";
signal RamA_addr, RamB_addr : std_logic_vector(8 downto 0) := "000000000";
signal RamA_we, RamA_en, RamB_en : std_logic := '1';
signal doneFlag : std_logic;


begin

pCount : programCounter PORT MAP(
    CLK =>clk,
    RST =>rst,
    ClockCycle => clockCycleFlag,
    jflag=> jumpFlag,
    jump => jumpAddress,
    PC=>programCount
);

memManage: MMU PORT MAP(
    clk=> clk,
    Addr_modeA=> AddressModeA,
    addr_modeB=> AddressModeB,
    OP_code=> OP,
    srcA=> sourceA,
    srcB=> sourceB,
    imm=> immediate,
    dFlag=>doneFlag
);

decoder : Instruct_decoder port map  (
    instruct => instruction_reg_out,
    clk => clk,
    Addr_modeA => AddressModeA, 
    addr_modeB => AddressModeB,
    OP_code => OP,
    srcA => sourceA,
    srcB => sourceB,
    imm => immediate
);

phaseController : InstructPhaseControl port map (
    clk => clk,
    rst => rst,
    nextFlag => nextFlag,
    opcode => op,
    output => FSMout
);

ALU_comp : ALU PORT MAP (
    RA => ASRC_Reg_out,
    RB  => BSRC_Reg_out,
    OP => op,
    CFLAG  => carryFlag,
    ALU_OUT => ALU_output
  );
  
regBank_comp : regBank PORT MAP (
    RA_addr => RegisterA_addr, 
    RB_addr => RegisterB_addr,
    RA_Data_in => registerA_Input,
    RA_out => RegisterA_output, 
    RB_out => RegisterB_output,
    CLK => clk,
    RW => ALU_RW,
    Clear => clear,
    toggle => toggle
);

-- Registers
alu_data : alu_data_register port map (
    CLK => clk,
    Clear => clear,
    Data_in => ALU_OUTPUT,
    enable => ALU_reg_enable,
    Data_out => ALU_REG_out
);

ASrc_reg : Asrc_reg_register port map (
    CLK => clk,
    Clear => clear,
    Data_in => A_source,
    enable => ASRC_Reg_enable,
    Data_out => ASRC_Reg_out
);

Bsrc_reg : bsrc_reg_register port map (
    CLK => clk,
    Clear => clear,
    Data_in => B_source,
    enable => BSRC_Reg_enable,
    Data_out => BSRC_Reg_out
);

--dst_addr : dst_addr_register port map (
--    CLK => clk,
--    Clear => clear,
--    Data_in => DST_source,
--    enable =>DST_REG_ENABLE,
--    Data_out => DST_REG_OUT
--);

inst_register : InstructionRegister port map (
    CLK => CLK,
    Clear => CLEAR,
    Data_in => instruction,
    enable  => Instruction_reg_enable,
    Data_out =>instruction_reg_out
);

assemblerz: key2instruction port map (
    clk => clk,
    rst => rst,
    instruction_out => instruction
    );

BlockRAM_i: component BlockRAM
     port map (
      BRAM_PORTA_0_addr(8 downto 0) => RamA_addr ,
      BRAM_PORTA_0_clk => CLK,
      BRAM_PORTA_0_din(23 downto 0) => RamA_din,
      BRAM_PORTA_0_dout(23 downto 0) => RamA_dout,
      BRAM_PORTA_0_en => RamA_en,
      BRAM_PORTA_0_we(0) => RamA_we,
      BRAM_PORTB_0_addr(8 downto 0) => RamB_addr ,
      BRAM_PORTB_0_clk => CLK,
      BRAM_PORTB_0_din(23 downto 0) => RamB_din,
      BRAM_PORTB_0_dout(23 downto 0) => RamB_dout,
      BRAM_PORTB_0_we(0) => '0' -- read only
    );



process (clk, rst)
begin
if(clk'event and clk='1') then
    case FSMOUT is
        
        when "000" => -- FETCH
            clockCycleFlag<='0';
            instruction_reg_enable <= '1';
            --port maped to decoder
            nextFlag <= not nextFlag;
            
        when "001" => -- DECODE
            --port maped
            nextFlag <= not nextFlag;
            
        when "010" => -- EXECUTE OFFSET (MEMORY)
            -- unsure what this means - skip
            nextFlag <= not nextFlag;
            
        when "011" => -- OPERAND (ALU)
            -- Get register values
            RamA_en<='1';
            Asrc_reg_enable <= '1';
            Bsrc_reg_enable <= '1';
            
            if (AddressModeA = "00") then
                RegisterA_addr<=sourceA;
                toggle<= not toggle;
                A_source <= RegisterA_output; -- gets saved in register
            elsif (AddressModeA = "01") then
                RegisterA_addr<=sourceA;
                toggle<= not toggle;
                RamA_addr<= RegisterA_output(8 downto 0);
                A_source<=RamA_dout;
            end if;
            
            if (AddressModeB = "00") then
                RegisterA_addr<=sourceB;
                toggle<= not toggle;
                B_source <= RegisterA_output; -- gets saved in register
            elsif (AddressModeB = "01") then
                RegisterB_addr<=sourceB;
                toggle<= not toggle;
                RamB_addr<= RegisterB_output(8 downto 0);
                B_source<=RamB_dout;
            end if;
            nextFlag <= not nextFlag;
            
        when "100" => -- EXEC (ALU)
            ALU_reg_enable<='1';
            nextFlag <= not nextFlag;
            
        when "101" => -- WRITE REGISTER (ALU)
            RamA_en<='1';
            if (AddressModeA = "00") then
                RegisterA_addr<=sourceA;
                RegisterA_Input <= ALU_reg_out;
                ALU_RW <= '1';
                toggle<= not toggle;
                ALU_RW <= '0';
            elsif (AddressModeA = "01") then
                RegisterA_addr<=sourceA;
                toggle<= not toggle;
                RamA_we <= '1';
                RamA_addr<= RegisterA_output(8 downto 0);
                RamA_din <= ALU_reg_out;
                RamA_we<='0';
            end if;
            nextFlag <= not nextFlag;
            clockCycleFlag<='1';
        when "110" => -- MEMORY READ
            --done in MMU
            nextFlag <= not nextFlag;
            
        when "111" => -- WRITE REGISTER (MEMORY)
            --done in MMU
            nextFlag <= not nextFlag;
            clockCycleFlag<='1';
    END CASE;

end if;
end process;
end Behavioral;
