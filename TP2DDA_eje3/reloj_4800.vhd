----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:10 10/09/2011 
-- Design Name: 
-- Module Name:    reloj_4800 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reloj_4800 is
    Port ( clk, rst : in  STD_LOGIC;
                      clk_4800 : out  STD_LOGIC);
end reloj_4800;

architecture Behavioral of reloj_4800 is
signal cuenta : integer range 0 to 700;
begin
process (clk)
begin
if rst ='1' then cuenta <= 0; clk_4800 <= '0';
elsif clk='1' and clk'event then
if cuenta < 651 then cuenta <= cuenta +1; clk_4800 <= '0'; else --volver a 651 o a 4
cuenta <= 0; clk_4800 <= '1'; end if; end if; end process;

end Behavioral;

