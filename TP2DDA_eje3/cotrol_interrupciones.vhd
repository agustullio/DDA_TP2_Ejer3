library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity cotrol_interrupciones is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Boton : in  STD_LOGIC;
           data_present : in  STD_LOGIC;
			  ack: in std_logic;			  
           interrupcion : out  STD_LOGIC;
           Reconoc_int : out  STD_LOGIC_VECTOR (1 downto 0));
end cotrol_interrupciones;

architecture Behavioral of cotrol_interrupciones is

type estado is(e1,e2,e3,e4,e5,e6,e7);
signal actual:estado;

begin

process(clk,Reset) --Proceso que determina cambios de estado
begin

	if (Reset='1') then actual<= e1;
	elsif (clk'event and clk='1') then
		case actual is
			when e1 => if (Boton = '1') then actual<=e2; elsif (data_present='1') then actual<=e3; end if;
			when e2 => if(ack='1') then actual<=e4; end if;
			when e3 => if(ack='1') then actual<=e6; end if;
			when e4 => actual<=e5;
			when e5 => if(Boton='0') then actual<=e1; end if;
			when e6 => actual<=e7;
			when e7 => if(data_present='0') then actual<=e1; end if;
		
			when others => null;
		
	   end case;
	end if;
end process;
 
process(actual) --Proceso que determina las salidas
begin
	case(actual) is
  
		when e1 => interrupcion<='0'; Reconoc_int<="00";
		when e2 => interrupcion<='1'; Reconoc_int<="01"; --por boton
		when e3 => interrupcion<='1'; Reconoc_int<="10"; --data present
		when e4 => interrupcion<='0'; Reconoc_int<="00"; 
		when e5 => interrupcion<='0'; Reconoc_int<="00";
		when e6 => interrupcion<='0'; Reconoc_int<="00";
		when e7 => interrupcion<='0'; Reconoc_int<="00"; 
  
	end case;
end process;


end Behavioral;

