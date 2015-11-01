library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ack_uart is
port(data: in std_logic_vector(7 downto 0);
     clk: in std_logic;
	  rec_int: in std_logic_vector (1 downto 0);
	  data_present: in std_logic;
	  Reset: in std_logic;
	  R_buf: out std_logic;
	  salida: out std_logic_vector(7 downto 0));
end Ack_uart;

architecture Behavioral of Ack_uart is
type estado is(s0,s1,s2);
signal actual: estado;
signal Load: std_logic; 
signal sal: std_logic_vector(7 downto 0);
begin

process(clk,Reset) --Proceso que determina cambios de estado
begin

if(Reset='1') then actual<=s0;

 elsif(clk'event and clk='1') then
    case actual is
	  when s0 => if(data_present='1') then actual <= s1; end if;
	  
	  when s1 => actual<= s2;
	  
	  when s2 => if(data_present='0') then actual <= s0; end if;
	  
	  end case;
	end if;
end process;

process(actual) --proceso que determina las salidas
begin

case actual is
   when s0 => Load <='0'; R_buf<='0';
	
	when s1 => Load<='1';R_buf<='0';
	
	when s2 => Load<='0';R_buf<='1';
	
	end case;
end process;



process(clk,Reset)
begin

if(Reset = '1') then
	sal <= (others=>'0');
	else
		if (rec_int = "01") then	--boton
			sal <= (others=>'1');
		elsif (Load = '1' and rec_int = "10") then	--uart
			sal <= data;
		else sal <= (others=>'0');
		end if;
end if;
end process;
salida <= sal;

end Behavioral;

