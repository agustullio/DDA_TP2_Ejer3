library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Salida_LCD_O is
    Port ( Out_PicoR : in  STD_LOGIC_VECTOR (3 downto 0);
           LCD_O : out  STD_LOGIC_VECTOR (2 downto 0));
end Salida_LCD_O;

architecture Behavioral of Salida_LCD_O is

begin

LCD_O <= Out_PicoR(2) & ( Out_PicoR(1) and Out_PicoR(3)) & Out_PicoR(0);

end Behavioral;

