library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sistema is
Port(    clk: in  STD_LOGIC;
		   Reset : in  STD_LOGIC;
		   Switch : in std_logic;
			Boton: in  std_logic;
         Ent_Serie: in std_logic; 
			LCD_IO: inout std_logic_vector(3 downto 0); --ver
			LCD_O : out std_logic_vector(2 downto 0);
			LCD_strata: out std_logic_vector(2 downto 0);
			Leds: out std_logic_vector(7 downto 0));

end Sistema;

architecture Behavioral of Sistema is
 
component Antirebote
Port ( Boton : in  STD_LOGIC;
       Reset : in  STD_LOGIC;
     BLimpio : out  STD_LOGIC;
         clk : in  STD_LOGIC);
end component; 

----------------------------------------------------------
component cotrol_interrupciones
Port (     clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Boton : in  STD_LOGIC;
           data_present : in  STD_LOGIC;
			  ack: in std_logic;
			  interrupcion : out  STD_LOGIC;
           Reconoc_int : out  STD_LOGIC_VECTOR (1 downto 0));
end component;
---------------------------------------------------------
component uart_rx
Port (       serial_in : in std_logic;
				  data_out : out std_logic_vector(7 downto 0);
			  read_buffer : in std_logic;
			 reset_buffer : in std_logic;
			 en_16_x_baud : in std_logic;
	buffer_data_present : out std_logic;
			  buffer_full : out std_logic;
		buffer_half_full : out std_logic;
						 clk : in std_logic);
end component;

component divisor_de_frec
port(clk,Reset: in std_logic;
      clk_4800: out std_logic);
end component;	  

--------------------------------------------------------
component kcpsm3
Port (      address : out std_logic_vector(9 downto 0);
            instruction : in std_logic_vector(17 downto 0);
                port_id : out std_logic_vector(7 downto 0);
           write_strobe : out std_logic;
               out_port : out std_logic_vector(7 downto 0);
            read_strobe : out std_logic;
                in_port : in std_logic_vector(7 downto 0);
              interrupt : in std_logic;
          interrupt_ack : out std_logic;
                  reset : in std_logic;
                    clk : in std_logic);
end component;
----------------------------------------------------------
component memoria
port (      clk : in std_logic;
			 reset : out std_logic;
		  address : in std_logic_vector(9 downto 0 );
	 instruction : out std_logic_vector(17 downto 0 )) ;
end component;
-----------------------------------------------------------
component Ack_uart
port(data: in std_logic_vector(7 downto 0);
     clk: in std_logic;
	  rec_int: in std_logic_vector (1 downto 0);
	  data_present: in std_logic;
	  Reset: in std_logic;
	  R_buf: out std_logic;
	  salida: out std_logic_vector(7 downto 0));

end component;
-------------------------------------------------------
--component FF_entrada
--
--Port (  D : in  STD_LOGIC_VECTOR (1 downto 0);
--        clk : in  STD_LOGIC;
--		  Reset : in  STD_LOGIC;
--        reseteo : in  STD_LOGIC;  --aqui conectar el read strobe
--        Enable : in  STD_LOGIC;
--        Salida_ff : out  STD_LOGIC_VECTOR (1 downto 0));
--
--end component;

-------------------------------------------------------
--component FF_salida
--Port (     D : in  STD_LOGIC_VECTOR (7 downto 0);
--	        clk: in std_logic;
--	        Reset: in std_logic;
--           Enable : in  STD_LOGIC;
--           Write_s : in  STD_LOGIC;
--           PortID : in  STD_LOGIC_VECTOR (7 downto 0);
--           Salida : out  STD_LOGIC_VECTOR (1 downto 0));
--end component;

component Salida_LCD
Port (     Ent : in  STD_LOGIC_VECTOR (7 downto 0);
	        clk: in std_logic;
	        Reset: in std_logic;
           wstrobe : in  STD_LOGIC;
           PortID6 : in  STD_LOGIC;
           Sal : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Buffer_LCD
Port ( EntBuff : in  STD_LOGIC_VECTOR (7 downto 0);
           Out_Pico1: in  STD_LOGIC;
			  Out_Pico3: in  STD_LOGIC;
           LCD_IO : inout  STD_LOGIC_VECTOR (3 downto 0));
end component;			

component Salida_LCD_O
Port ( Out_PicoR : in  STD_LOGIC_VECTOR (3 downto 0);
           LCD_O : out  STD_LOGIC_VECTOR (2 downto 0));
end component;			  

---------------------------------------------------------------------
signal Blimp: std_logic;
signal int_ack: std_logic;
signal interrup: std_logic;
signal rec_int: std_logic_vector(1 downto 0);
signal clk_16: std_logic;

signal d_out: std_logic_vector(7 downto 0);
signal b_dpresent: std_logic;
signal dato: std_logic_vector (7 downto 0);
signal instruccion: std_logic_vector(17 downto 0);
signal add: std_logic_vector(9 downto 0);

signal wstrobe: std_logic;
signal rstrobe: std_logic;
signal salida_pb: std_logic_vector(7 downto 0);
signal rec_inte: std_logic_vector(1 downto 0);
signal read_buf: std_logic;
signal portID: std_logic_vector(7 downto 0);
signal Out_PicoR: std_logic_vector (7 downto 0);
begin

-------------------------------------------------
Anti_Rebote:Antirebote
port map( clk => clk,
	     Reset => Reset,
        Boton => Boton,
      BLimpio => Blimp);

------------------------------------------------------------
Div_frec:divisor_de_frec
port map(clk => clk,
       Reset => Reset,
	 clk_4800 => clk_16);

------------------------------------------------------------
recepcion_uart: uart_rx
port map(       clk => clk,
		 reset_buffer => Reset,
		 en_16_x_baud => clk_16,
			 serial_in => Ent_Serie,
		  read_buffer => read_buf,
			  data_out => d_out,
buffer_data_present => b_dpresent);
------------------------------------------------------------
reconocimiento_uart:Ack_uart
port map(Reset=>Reset,
         clk=>clk,
			data => d_out,
 data_present => b_dpresent,
         rec_int => rec_int,
		salida => dato,
			R_buf=>read_buf);
			
------------------------------------------------------------
control_int:cotrol_interrupciones
port map( clk => clk,
        Reset => Reset,
        Boton => Blimp,
 data_present => b_dpresent,  --cambiar esto
          ack => int_ack,
 interrupcion => interrup,
  Reconoc_int => rec_int);

--------------------------------------------------------------
picoblaze:kcpsm3
port map(        clk => clk,
               Reset => Reset,
           interrupt => interrup,
         instruction => instruccion,
		 interrupt_ack => int_ack,
             address => add,
		  write_strobe => wstrobe,
	      read_strobe => rstrobe,
		   	port_id  =>  portID,
             in_port => dato,
            out_port => salida_pb);
--out_port(7 downto 0) => open);

 --agregar LCD

--------------------------------------------------------------
mem: memoria
port map(clk => clk,
 instruction => instruccion,
     address => add); 
------------------------------------------------------------
--flipflop_entrada: FF_entrada		 
--port map( clk=>clk,
--          Reset => Reset,
--          reseteo=> rstrobe,
--			 Enable => interrup,
--			 D => rec_int,
--			 Salida_ff => rec_inte);
			 
--------------------------------------------------------------			 
--flipflop_salida: FF_salida
--port map( clk => clk,
--          Reset => Reset,
--			 Enable=> '0',
--			 Write_s => wstrobe,
--			 PortID => portID,
--			 D => salida_pb,
--			 Salida => Motor );
--------------------------------------------------------------			 
sal_LCD: Salida_LCD
port map( clk=>clk,
          Reset=>Reset,
			 Ent => salida_pb,
			 wstrobe => wstrobe,
          PortID6 => portID(6),
           Sal => Out_PicoR);
--------------------------------------------------------------			  
sal_LCD_O: Salida_LCD_O
port map( Out_PicoR => Out_PicoR(3 downto 0),
           LCD_O   =>  LCD_O);      
          
---------------------------------------------------------------
Buff_LCD: Buffer_LCD
port map( EntBuff => Out_PicoR,
          Out_Pico1 => Out_PicoR(1),
			 Out_Pico3 => Out_PicoR(3),
          LCD_IO => LCD_IO(3 downto 0));

       
LCD_strata(0) <= '1';
LCD_strata(1) <= '1';
LCD_strata(2) <= '1';

end Behavioral;

