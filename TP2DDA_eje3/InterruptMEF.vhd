----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:50 10/30/2015 
-- Design Name: 
-- Module Name:    InterruptMEF - Behavioral 
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

entity InterruptMEF is
end InterruptMEF;

architecture Behavioral of InterruptMEF is
type estado is (s1, s2, s3, s4, s5, s6, s7); 
signal actual : estado;
signal 
begin

	process (clk, reset)
	
	begin
		
		if reset = '1' then actual <= s1;
		elsif clk = '1' and clk'event then
			case actual is
				when s1 => if data_p = '1' and boton = '0' then actual <= s2; end if; if boton = '1' then actual <= s5; end if;
				when s2 => actual <= s3;
				when s3 => if ack = '1' then actual <= s4; end if;				
				when s4 => if confirm = '1' then  actual <= s1; end if;
				when s5 => actual <= s6;
				when s6 => if ack = '1' then actual <= s7; end if;
				when s7 => if confirm = '1' then actual <= s1; end if;
			end case;
		end if;
	end process;
	
	process (actual)
	begin
		case actual is
			when s1 => int <= '0';
			when s2 => int <= '1';
			when s3 => int <= '1';
			when 
				


end Behavioral;

