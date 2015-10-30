--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
--entity Antirebote is
--    Port ( Bin : in  STD_LOGIC;
--           Reset : in  STD_LOGIC;
--           Bout : out  STD_LOGIC;
--           Clk : in  STD_LOGIC);
--end Antirebote;
--
--architecture Behavioral of Antirebote is
--	type estado is (s0,s1,s2,s3,s4);
--	signal actual : estado;
--	signal Confirm1, Confirm0 : std_logic;
--	signal Vector : std_logic_vector (11 downto 0);
--	--signal cuenta: std_logic_vector(19 downto 0);
--	--signal Fin_Cuenta, E_Cuenta: std_logic;
--begin
--
--process(clk,Reset)
--begin
--
--if (Reset='1') then actual<= s0;
--   elsif (clk'event and clk='1') then
--		case actual is
--		
--			when s0 => if (bin = '1') then actual<=s1; end if;
--			
--			when s1 => if (confirm1 = '1') then actual <= s2; end if;
--			
--			when s2 => actual <= s3;
--			
--			when s3 => if (confirm0 = '1') then actual <= s4; end if; --if(Fin_Cuenta='1') then actual<=s3; end if;
--			
--			when s4 => actual<=s0;
--			
--	   end case;
--	end if;
--end process;
-- 
--process(actual)
--begin
--  case(actual) is
--  
--  when s0=> Bout<='0'; --E_Cuenta<='0';
--
--  when s1=> Bout<='0'; --E_Cuenta<='1';
--
--  when s2=> Bout<='1'; --Confirm1<= '0';--E_Cuenta<='1';
--  
--  when s3=> Bout<='0'; --E_Cuenta<='0';
--  
--  when s4=> Bout<='0'; --Confirm0<= '0';--E_Cuenta<='1';
--  
--  end case;
--end process;
--  
--  
--process(clk,Reset)
--	variable reg : std_logic_vector (11 downto 0) := "100000000000";
--begin
--
--	if(Reset = '1') then reg := "100000000000"; confirm1 <= '0'; confirm0 <= '0'; --:= (others => '0');  --cuenta<=(others=>'0');
--	elsif(clk'event and clk='1')then
--		
--		reg := reg (10 downto 0) & Bin; --REGISTR DE DESPLAZAMIENTO
--		vector <= reg;
--		
--		if (reg = "111111111111" and confirm1 = '0') then 
--			confirm1 <= '1';
----		elsif (reg = "111111111111" and confirm1 = '1') then 
----			confirm1 <= '0';
--		else
--			confirm1 <= '0';
--		end if;
--				
--		if (reg = "000000000000" and confirm0 = '0') then 
--			confirm0 <= '1';
----		elsif (reg = (others => '0')  and confirm0 = '1') then 
----			confirm0 <= '0';
--		else
--			confirm0 <= '0';
--		end if;
--		--if(E_Cuenta='1') then
--			--cuenta<=cuenta + 1;
--			--if(cuenta=x"30D40")then   --C350  --Ojo cambiar esto luego!!
--			  --cuenta<=(others=>'0');
--			--end if;		  
--		--end if;
--	end if;
--
--end process; 
--
----Fin_Cuenta<= '1' when cuenta=x"30D40" else '0'; --C350  --Ojo cambiar esto luego!!
--
--end Behavioral;
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Antirebote is
    Port ( Bin : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Bout : out  STD_LOGIC;
           Clk : in  STD_LOGIC);
end Antirebote;

architecture Behavioral of Antirebote is
type estado is(s0,s1,s2,s3,s4);
signal actual:estado;
signal cuenta: std_logic_vector(19 downto 0);
signal Fin_Cuenta, E_Cuenta: std_logic;
begin

process(clk,Reset)
begin

if (Reset='1') then actual<= s0;
   elsif (clk'event and clk='1') then
     case actual is
		when s0 => if (Bin='1') then actual<=s1; end if;
		
		when s1=> actual<=s2;
		
		when s2=> if(Fin_Cuenta='1') then actual<=s3; end if;
		
		when s3=> if(Bin='0') then actual<=s4; end if;
		
		when s4=> if(Fin_Cuenta='1') then actual<=s0; end if;
		
		when others => null;
		
	   end case;
	end if;
end process;
 
process(actual)
begin
  case(actual) is
  
  when s0=> Bout<='0'; E_Cuenta<='0';

  when s1=> Bout<='1'; E_Cuenta<='1';

  when s2=> Bout<='0'; E_Cuenta<='1';
  
  when s3=> Bout<='0'; E_Cuenta<='0';
  
  when s4=> Bout<='0'; E_Cuenta<='1';
  
  end case;
end process;
  
  
process(clk,Reset)
begin

if(Reset='1') then
   cuenta<=(others=>'0');
	
  elsif(clk'event and clk='1')then
    if(E_Cuenta='1') then
	   cuenta<=cuenta + 1;
	 if(cuenta=x"FFFFE")then   --C350  --Ojo cambiar esto luego!!
        cuenta<=(others=>'0');
      end if;		  
	 end if;
 end if;

end process; 

Fin_Cuenta<= '1' when cuenta=x"FFFFE" else '0'; --C350  --Ojo cambiar esto luego!!

end Behavioral;