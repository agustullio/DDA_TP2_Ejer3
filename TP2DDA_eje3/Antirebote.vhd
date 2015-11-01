library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Antirebote is
    Port ( Boton : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           BLimpio : out  STD_LOGIC;
           clk : in  STD_LOGIC);
end Antirebote;

architecture Behavioral of Antirebote is
type estado is(s0,s1,s2,s3,s4);
signal actual:estado;
signal cuenta: std_logic_vector(15 downto 0);
signal Fin_Cuenta, E_Cuenta: std_logic;
begin

process(clk,Reset) --Proceso que determina cambios de estado
begin

if (Reset='1') then actual<= s0;
   elsif (clk'event and clk='1') then
     case actual is
		when s0 => if (Boton='1') then actual<=s1; end if;
		
		when s1=> actual<=s2;
		
		when s2=> if(Fin_Cuenta='1') then actual<=s3; end if;
		
		when s3=> if(Boton='0') then actual<=s4; end if;
		
		when s4=> if(Fin_Cuenta='1') then actual<=s0; end if;
		
		when others => null;
		
	   end case;
	end if;
end process;
 
process(actual) --Proceso que determina las salidas
begin
  case(actual) is
  
  when s0=> BLimpio<='0'; E_Cuenta<='0';

  when s1=> BLimpio<='1'; E_Cuenta<='1';

  when s2=> BLimpio<='0'; E_Cuenta<='1';
  
  when s3=> BLimpio<='0'; E_Cuenta<='0';
  
  when s4=> BLimpio<='0'; E_Cuenta<='1';
  
  end case;
end process;
  
  
process(clk,Reset)
begin

if(Reset='1') then
   cuenta<=(others=>'0');
	
  elsif(clk'event and clk='1')then
    if(E_Cuenta='1') then
	   cuenta<=cuenta + 1;
	 if(cuenta=x"C350")then
        cuenta<=(others=>'0');
      end if;		  
	 end if;
 end if;

end process; 

Fin_Cuenta<= '1' when cuenta=x"C350" else '0'; --C350  --Ojo cambiar esto luego!!

end Behavioral;

