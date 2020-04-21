----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2020 01:39:29 PM
-- Design Name: 
-- Module Name: MMU - Behavioral
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
 -- aBRAM_DOUT <= std_logic_vector(to_unsigned(to_integer(unsigned(aBRAM_DOUT )) + 1, 24)); 

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

entity MMU is
  Port ( 
    clk: in std_logic;
    Addr_modeA, addr_modeB: in std_logic_vector(1 downto 0);
    OP_code:in std_logic_vector (4 downto 0);
    srcA,srcB:in std_logic_vector(2 downto 0);
    imm:in std_logic_vector(18 downto 0);
    dFlag: out std_logic
  );
end MMU;

architecture Behavioral of MMU is
  
component BlockRAM_wrapper is
  Port (
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
signal RA_din, RA_dout, RB_dout, aBRAM_DIN, aBRAM_DOUT, bBRAM_DIN, bBRAM_DOUT: std_logic_vector(23 downto 0);
signal rw_signal, clr, tog, BRAM_aEN: std_logic;
signal A_addr, B_addr:std_logic_vector(2 downto 0);
SIGNAL BRAM_aADDR, BRAM_bADDR:STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL BRAM_aWE, BRAM_bWE:STD_LOGIC_VECTOR(0 DOWNTO 0);
signal srcAdata : std_logic_vector(23 downto 0);
begin
uut: regBank port map(
    RA_addr => a_addr,
    RB_addr => b_addr,
    RA_Data_in => ra_din,
    RA_out => ra_dout,
    RB_out => rb_dout,
    CLK => clk,
    RW => rw_signal,
    Clear=> clr,
    toggle => tog
);

UUT2: BlockRAM_WRAPPER PORT MAP(
    BRAM_PORTA_0_addr => BRAM_aADDR,
    BRAM_PORTA_0_clk =>CLK,
    BRAM_PORTA_0_din =>aBRAM_DIN,
    BRAM_PORTA_0_dout=>aBRAM_DOUT,
    BRAM_PORTA_0_en =>BRAM_aEN,
    BRAM_PORTA_0_we =>BRAM_aWE,
    BRAM_PORTB_0_addr =>BRAM_bADDR,
    BRAM_PORTB_0_clk =>CLK,
    BRAM_PORTB_0_din =>bBRAM_DIN,
    BRAM_PORTB_0_dout =>bBRAM_DOUT,
    BRAM_PORTB_0_we =>BRAM_bWE
);

Process(CLK)
begin
dflag<='0';
if (clk='1' and clk'event) then
    
    -- ensure writes are disabled
    rw_signal<='0';
    BRAM_aWE<="0";
    BRAM_aEn<='1'; -- enable block RAM
    
    -- MMU Operations: MVS, MVMI, MMS, MSM
    -- Addressing Modes:
    --  00 --- Register direct - Use contents of register
    --  01 --- Register indirect - Use contents of register as address into RAM
    --  10 --- Register direct auto-increment - Use contents of register. Incrememnt register contents after completion
    --  11 --- Register indirect auto-increment - Use contents of register as address into RAM. Increment memory contents after completion  
case OP_code is

    when "01010" => --MVS ********************************************************************************************
                    -- Moves data between memory or data between memory locations
        
        -- *** REGISTER A ***
        -- REG DIRECT
        if(addr_modeA="00")then
            --get regA contents
            a_addr<=srcA;
            tog<= not tog;
            srcAdata <= ra_dout;
    
       -- REG INDIRECT
        elsif (addr_modeA="01")then
            -- get regA contents
            a_addr<=srcA;
            tog<=not tog;
            -- address into MMU
            BRAM_aWE<="0"; -- disable write
            BRAM_aAddr<= ra_dout(8 downto 0);
            srcAdata<= aBRAM_dout;
            
        -- REG DIRECT AUTO-INCREMENT
        elsif(addr_modeA="10")then
            --get regA contents
            a_addr<=srcA;
            tog<= not tog;
            srcAdata <= ra_dout;
            -- Add one to register
            rw_signal<='1';
            ra_din <= std_logic_vector(to_unsigned(to_integer(unsigned(ra_dout)) + 1, 24));
            tog <= not tog; 
            rw_signal<='0';
            
        -- REG INDIRECT AUTO-INCREMENT
        elsif(addr_modeA = "11") then 
            -- get regA contents
            a_addr<=srcA;
            tog<=not tog;
            -- address into MMU
            BRAM_aWE<="0"; -- disable write
            BRAM_aAddr<= ra_dout(8 downto 0);
            srcAdata<= aBRAM_dout;
            -- increment memory contents after completion
            BRAM_aWE<="1";
            aBRAM_din<= std_logic_vector(to_unsigned(to_integer(unsigned(abram_dout)) + 1, 24));
            BRAM_aWE<="0";
        end if;
        
        
        -- *** REGISTER B ***
        -- REG DIRECT
        if(addr_modeB="00")then
            --overrite regB with srcAdata
            rw_signal<='1';
            a_addr<=srcB;
            ra_din<=srcAdata;
            tog<= not tog;
            rw_signal<='0';
            
        -- REG INDIRECT
        elsif (addr_modeB="01")then
            --overwrite MEM[RegB] with srcAdata
            -- get regB contents
            a_addr<=srcB;
            tog<=not tog;
            -- address into MMU
            BRAM_aWE<="1"; -- enable write
            BRAM_aAddr<= ra_dout(8 downto 0); -- address using RegB contents
            aBRAM_din <= srcAdata;
            BRAM_aWE<="0";

        -- REG DIRECT AUTO-INCREMENT
        elsif(addr_modeB="10")then 
            --overrite regB with srcAdata then add 1
            rw_signal<='1';
            a_addr<=srcB;
            ra_din<=std_logic_vector(to_unsigned(to_integer(unsigned(srcAdata)) + 1, 24));
            tog<= not tog;
            rw_signal<='0';
            
        -- REG INDIRECT AUTO-INCREMENT
        elsif(addr_modeB = "11") then
            --overwrite MEM[RegB] with srcAdata then add 1
            -- get regB contents
            a_addr<=srcB;
            tog<=not tog;
            -- address into MMU
            BRAM_aWE<="1"; -- enable write
            BRAM_aAddr<= ra_dout(8 downto 0); -- address using RegB contents
            aBRAM_din <= std_logic_vector(to_unsigned(to_integer(unsigned(srcAdata)) + 1, 24));
            BRAM_aWE<="0";
        
        end if;
        
        
    when "01011"=> -- MVMI ********************************************************************************************
                   --  Explicity used to move data between two memory locations (zero operand instruction?)
          
         BRAM_aADDR<= imm(8 downto 0);
         BRAM_bADDR<=imm(17 downto 9);
         srcAdata<=bBram_dout;
         BRAM_aWE<="1";
         aBRAM_din<=srcAdata;      
         BRAM_aWE<="0";          
                   
    when "01100" => -- MSM ********************************************************************************************
                    -- Moves data from a register A, to a memory location identified by the immediate data in the instruction. 
                    -- The register is either register direct or can be register indirect.
        -- *** REGISTER A ***
        -- REG DIRECT
        if(addr_modeA="00")then
            -- Get regA contents
            a_addr<=srcA;
            tog<= not tog;
            srcAdata <= ra_dout;
            -- Store into specified location in RAM
            BRAM_aWE <= "1"; -- enable write
            BRAM_aADDR <= imm(8 downto 0);
            aBRAM_din <= srcAdata;
            BRAM_aWE<= "0";
            
        -- REG INDIRECT
        elsif (addr_modeA="01")then
            -- Get regA contents
            a_addr<=srcA;
            tog<= not tog;
            -- Use as address into RAM
            BRAM_aADDR <= ra_dout(8 downto 0);
            srcAdata<= aBRAM_dout; -- data in MEM[RegA]
            -- Store into specified location in RAM
            BRAM_aWE <= "1"; -- enable write
            BRAM_aADDR <= imm(8 downto 0);
            aBRAM_din <= srcAdata;
            BRAM_aWE<= "0";
            
            
        -- REG DIRECT AUTO-INCREMENT
        elsif(addr_modeA="10")then
            -- Get regA contents
            a_addr<=srcA;
            tog<= not tog;
            srcAdata <= ra_dout;
            -- Store into specified location in RAM
            BRAM_aWE <= "1"; -- enable write
            BRAM_aADDR <= imm(8 downto 0);
            aBRAM_din <= srcAdata;
            BRAM_aWE<= "0";
            ra_din <= std_logic_vector(to_unsigned(to_integer(unsigned(srcAdata)) + 1, 24));
            tog<=not tog;
            
        -- REG INDIRECT AUTO-INCREMENT
        elsif(addr_modeA = "11") then 
            -- Get regA contents
            a_addr<=srcA;
            tog<= not tog;
            -- Use as address into RAM
            BRAM_aADDR <= ra_dout(8 downto 0);
            srcAdata<= aBRAM_dout; -- data in MEM[RegA]
            -- Store into specified location in RAM
            BRAM_aWE <= "1"; -- enable write
            BRAM_aADDR <= imm(8 downto 0);
            aBRAM_din <= srcAdata;
            BRAM_aWE<= "0";
            BRAM_aAddr<=ra_dout(8 downto 0);
            BRAM_aWE<="1";
            aBRAM_din <= std_logic_vector(to_unsigned(to_integer(unsigned(srcAdata)) + 1, 24));      
            BRAM_aWE<="0";   
        end if;
        
    
    
    when "01101" => -- MMS ********************************************************************************************
                    -- Move data into Register A (based upon addressing mode) from memory location pointed to by the immediate address.
        -- *** REGISTER A ***
        -- REG DIRECT
        if(addr_modeA="00")then
            BRAM_aADDR<=imm(8 downto 0);
            srcAdata<=aBRAM_dout;
            a_addr<= srcA;
            ra_din<=srcAdata;
            rw_signal<='1';
            tog<= not tog;
            rw_signal<='0';
            
        -- REG INDIRECT
        elsif (addr_modeA="01")then
            BRAM_aAddr<=imm(8 downto 0);
            srcAdata<=aBram_dout;
            a_addr <= srcA;
            BRAM_aWE<="1";
            BRAM_aAddr<=ra_dout(8 downto 0);
            aBRAM_din<=srcAdata;
            BRAM_aWE<="0";
            
        -- REG DIRECT AUTO-INCREMENT
        elsif(addr_modeA="10")then
            BRAM_aADDR<=imm(8 downto 0);
            srcAdata<=aBRAM_dout;
            a_addr<= srcA;
            ra_din<=std_logic_vector(to_unsigned(to_integer(unsigned(srcAdata)) + 1, 24));    
            rw_signal<='1';
            tog<= not tog;
            rw_signal<='0';
            
        -- REG INDIRECT AUTO-INCREMENT
        elsif(addr_modeA = "11") then 
            BRAM_aAddr<=imm(8 downto 0);
            srcAdata<=aBram_dout;
            a_addr <= srcA;
            BRAM_aWE<="1";
            BRAM_aAddr<=ra_dout(8 downto 0);
            aBRAM_din<=std_logic_vector(to_unsigned(to_integer(unsigned(srcAdata)) + 1, 24));
            BRAM_aWE<="0";
        end if;
        
   when others=>
        
end case;
dflag<='1';
end if;
end process;
end Behavioral;
