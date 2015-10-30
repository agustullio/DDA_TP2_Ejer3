----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:51:47 10/16/2015 
-- Design Name: 
-- Module Name:    Regis - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Regis is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hab : in  STD_LOGIC;
           ent : in  STD_LOGIC_VECTOR (7 downto 0);
           sal : out  STD_LOGIC_VECTOR (7 downto 0));
end Regis;

architecture Behavioral of Regis is

begin
	Process(clk, reset)
	variable latch : std_logic_vector (7 downto 0);
	begin
		if reset = '1' then latch := (others => '0');
		elsif clk = '1' and clk'event then
			if hab = '1' then
				latch := ent;
			end if;
			sal <= latch;
		end if;
	end process;

end Behavioral;

