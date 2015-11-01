library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Buffer_LCD is
    Port ( EntBuff : in  STD_LOGIC_VECTOR (7 downto 0);
           Out_Pico1: in  STD_LOGIC;
			  Out_Pico3: in  STD_LOGIC;
           LCD_IO : inout  STD_LOGIC_VECTOR (3 downto 0));
end Buffer_LCD;

architecture Behavioral of Buffer_LCD is

begin

LCD_IO <= EntBuff(7 downto 4) when ( Out_Pico3='1' and Out_Pico1='0') else (others => 'Z');

end Behavioral;

