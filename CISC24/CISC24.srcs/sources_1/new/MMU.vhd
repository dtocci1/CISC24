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
    imm:in std_logic_vector(18 downto 0)
  );
end MMU;

architecture Behavioral of MMU is
  
component BRAM_wrapper is
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

UUT2: BRAM_WRAPPER PORT MAP(
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
clr<='0';
rw_signal<='0';
case OP_code is
    when "01010" => --MVS
        if(addr_modeA="00")then --reg direct mode (regBank)
            a_addr<=srcA;
            b_addr<=srcB;
            tog<= not tog;
            -- contents of RegA saved in ra_dout
            -- ignore rb_dout
            
        else if (addr_modeA="01")then --reg indirect
            BRAM_aWE<="1";
            BRAM_aADDR<=srcA;
            BRAM_bADDR<=srcB;
        else if(addr_modeA="10")then --direct autoincrement
            a_addr<=srcA;
            b_addr<=srcB;
            tog<= not tog;
            RA_DOUT <= std_logic_vector(to_unsigned(to_integer(unsigned(RA_DOUT )) + 1, 24)); 
            a_addr<=srcA;
            ra_din<=ra_dout;
            rw_signal<='1';
            tog<= not tog; -- add 1 to regA
            rw_signal<='0';
            a_addr<=srcA;
            b_addr<=srcB;
            tog<= not tog;      
        else if(addr_modeA = "11") then --indirect autoincrement
            BRAM_aADDR<=srcA;
            BRAM_bADDR<=srcB;
            aBRAM_DOUT <= std_logic_vector(to_unsigned(to_integer(unsigned(aBRAM_DOUT )) + 1, 24)); 
            BRAM_aADDR<=srcA;
            aBRAM_din<=aBRAM_DOUT;
            BRAM_aWE<="1";
            BRAM_aWE<="0";
            BRAM_aADDR<=srcA;
            BRAM_bADDR<=srcB;
        end if;
        
        
        if(addr_modeB="00")then --reg direct mode
            a_addr<=srcB;
            rw_signal<='1';
            ra_din <= ra_dout;
            tog<= not tog;
            -- Overwrite regB location with contents of regA
        else if (addr_modeB="01")then --reg indirect
            BRAM_aADDR<=srcB;
            BRAM_aWE<="1";
            aBRAM_DIN <= aBRAM_DOUT;
        else if(addr_modeB="10")then --direct autoincrement
            if (addr_modeA/="10") then
            RA_DOUT <= std_logic_vector(to_unsigned(to_integer(unsigned(RA_DOUT )) + 1, 24)); 
            end if;
            a_addr<=srcB;
            rw_signal<='1';
            ra_din <= ra_dout;
            tog<= not tog;
        else if(addr_modeB = "11") then --indirect autoincrement
            if (addr_modeA/="11") then
            aBRAM_DOUT <= std_logic_vector(to_unsigned(to_integer(unsigned(aBRAM_DOUT )) + 1, 24)); 
            end if;
            BRAM_aADDR<=srcB;
            BRAM_aWE<="1";
            aBRAM_DIN <= aBRAM_DOUT;
        end if;
    when "01011"=> --MVMI
    
    when "01100" => --MSM
    
    when "01101" => -- MMS
    
end case;
        
end process;
end Behavioral;
