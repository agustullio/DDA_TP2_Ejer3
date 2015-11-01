library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divisor_de_frec is

port(clk,Reset: in std_logic;
     clk_4800: out std_logic);

end divisor_de_frec;

architecture Behavioral of divisor_de_frec is
signal  cuenta: std_logic_vector(10 downto 0);

begin

process (clk, reset)
--variable cuenta: integer range 0 to 700;

begin
if (Reset='1') then 
     cuenta<=(others=>'0');
 elsif (clk= '1' and clk'event) then 
        cuenta<= cuenta +1;
    if (cuenta < x"028B") then   --x"028B"
		       clk_4800 <= '0';				 
      elsif (cuenta >= x"028B") then
        clk_4800 <= '1';	  
	     cuenta<=(others=>'0');
	  end if; 
	 end if;
end process;

end Behavioral;

