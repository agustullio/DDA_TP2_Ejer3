----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:17:51 10/16/2015 
-- Design Name: 
-- Module Name:    BUFT - Behavioral 
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

entity BuffT is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           T : in  STD_LOGIC;
           O : inout  STD_LOGIC_VECTOR (3 downto 0));
end BuffT;

architecture Behavioral of BuffT is
	
begin
	
	O <= I when (T = '1') else (others => 'Z');

end Behavioral;

