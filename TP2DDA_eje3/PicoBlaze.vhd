----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:19:57 10/23/2015 
-- Design Name: 
-- Module Name:    PicoBlaze - Behavioral 
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

entity PicoBlaze is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Port_in : in  STD_LOGIC_VECTOR (7 downto 0);
           Port_out : out  STD_LOGIC_VECTOR (7 downto 0);
           Interrupt : in  STD_LOGIC;
           Interrupt_ack : out  STD_LOGIC;
           Read_S : out  STD_LOGIC;
           Write_S : out  STD_LOGIC;
           Port_ID : out  STD_LOGIC_VECTOR (7 downto 0));
end PicoBlaze;

architecture Behavioral of PicoBlaze is

	component kcpsm3
		Port (  address : out std_logic_vector(9 downto 0);
           instruction : in std_logic_vector(17 downto 0);
           port_id : out std_logic_vector(7 downto 0);
           write_strobe : out std_logic;
           out_port : out std_logic_vector(7 downto 0);
           read_strobe : out std_logic;
           in_port : in std_logic_vector(7 downto 0);
           interrupt : in std_logic;
           interrupt_ack : out std_logic;
           reset : in std_logic;
           clk : in std_logic);
	end component;
	
begin


end Behavioral;

