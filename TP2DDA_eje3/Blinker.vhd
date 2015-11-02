----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:46:24 11/02/2015 
-- Design Name: 
-- Module Name:    Blinker - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Blinker is
	Port (clk : in std_logic;
			reset : in std_logic;
			port_id : in std_logic; 
			Condicion : in std_logic_vector (1 downto 0);
			Switch : in std_logic;
			Led : out std_logic_vector (7 downto 0));
end Blinker;

architecture Behavioral of Blinker is
	signal frec, fincuenta : std_logic;
	signal cuenta : std_logic_vector (31 downto 0);
begin
	
	
--------Frecuencia de 50 hz-----------------------------
	process (clk, reset)
		--variable cuenta : std_logic_vector (31 downto 0);
	begin
		if reset = '1' then cuenta <= (others => '0');
		elsif (clk = '1' and clk'event) then
			if (fincuenta = '0' and frec = '1') then
				frec <= '1';
				cuenta <= cuenta + 1;
			elsif (fincuenta = '1' and frec = '1') then
				cuenta <= (others => '0');
				frec <= '0';
			end if;
			if (fincuenta = '0' and frec = '0') then
				frec <= '0';
				cuenta <= cuenta + 1;
			elsif (fincuenta = '1' and frec = '0') then
				cuenta <= (others => '0');
				frec <= '1';
			end if;
		end if;
	end process;
	
	fincuenta <= '1' when (cuenta=x"1DCD6500") else '0';
--------------------------------------------------------	
	process (clk, reset)
		variable latch1 : std_logic_vector (1 downto 0);
	begin
		if reset = '1' then latch1 := "00";
		elsif clk = '1' and clk'event then
-------------memoria de estado--------------------
			if port_id = '1' then
				latch1 := Condicion;
			end if;
---------------posibles estados-------------------			
			if switch = '1' then
				case latch1 is  
					when "00" => Led <= (others => '0'); -- condicion = 00 implica reposo
					when "01" => if frec = '1' then Led <= (others => '1'); elsif frec = '0' then Led <= (others => '0'); end if;	-- condicion = 01 implica estado de movimientos leves
					when "10" => Led <= (others => '1'); -- condicion = 10 implica traslado
					when others => null;
				end case;
			elsif switch = '0' then
				Led <= (others => '0');
			end if;
---------------------------------------------------
		end if;
	end process;
	
							
end Behavioral;

