----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:12:08 10/23/2015 
-- Design Name: 
-- Module Name:    TopModule - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;		

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Switch : in  STD_LOGIC;
           Boton : in  STD_LOGIC;
           Ent_Serie : in  STD_LOGIC;
           LCD : out  STD_LOGIC_VECTOR (7 downto 0);
           Leds : out  STD_LOGIC_VECTOR (7 downto 0));
end TopModule;

architecture Behavioral of TopModule is

	component reloj_4800
		Port ( clk, rst : in  STD_LOGIC;
             clk_4800 : out  STD_LOGIC);
	end component;
	
	component uart_rx
		 Port ( serial_in : in std_logic;
             data_out : out std_logic_vector(7 downto 0);
             read_buffer : in std_logic;
             reset_buffer : in std_logic;
             en_16_x_baud : in std_logic;
             buffer_data_present : out std_logic;
             buffer_full : out std_logic;
             buffer_half_full : out std_logic;
             clk : in std_logic);
	end component;
	
	component PicoBlaze
		Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Port_in : in  STD_LOGIC_VECTOR (7 downto 0);
           Port_out : out  STD_LOGIC_VECTOR (7 downto 0);
           Interrupt : in  STD_LOGIC;
           Interrupt_ack : out  STD_LOGIC;
           Read_S : out  STD_LOGIC;
           Write_S : out  STD_LOGIC;
           Port_ID : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component Regis
		Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hab : in  STD_LOGIC;
           ent : in  STD_LOGIC_VECTOR (7 downto 0);
           sal : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component BuffT
		Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           T : in  STD_LOGIC;
           O : inout  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component Antirebote
		Port ( Bin : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Bout : out  STD_LOGIC;
           Clk : in  STD_LOGIC);
	end component;
	
	signal Btn, inter, c4800 : std_logic;
	signal DatRs : std_logic_vector (7 downto 0);
				
begin
	
	anti : Antirebote
		port map ( clk => clk,
					reset => reset,
					bin => boton,
					bout => Btn);
					
	uart : uart_rx
		port map ( clk => clk,
					reset => reset,
					data_out => DatRs,
					buefer_data_present => inter,
					en_16_x_baud => c4800);
					
	divisor : reloj_4800
		port map ( clk => clk,
					rst => reset,
					clk_4800 => c4800);
					
					

end Behavioral;

