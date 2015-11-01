library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Salida_LCD is
    Port ( Ent : in  STD_LOGIC_VECTOR (7 downto 0);
	        clk: in std_logic;
	        Reset: in std_logic;
           wstrobe : in  STD_LOGIC;
           PortID6 : in  STD_LOGIC;
           Sal : out  STD_LOGIC_VECTOR (7 downto 0));
end Salida_LCD;

architecture Behavioral of Salida_LCD is

begin

process(clk,Reset)
begin
if(Reset='1') then
 Sal<="00000000";
 
 elsif(clk'event and clk='1') then
      if(wstrobe='1' and PortID6='1') then
		 
		 Sal<=Ent;
		 
		 end if;
	end if;
end process;
	
		 

end Behavioral;

