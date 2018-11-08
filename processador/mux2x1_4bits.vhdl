library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;       

entity mux2x1_4bits is
  port (
			entrada01, entrada02: 	in unsigned(3 downto 0);
			enable:					in std_logic;
			seletor:				in std_logic;
			saida:					out unsigned(3 downto 0)
  		);
end entity mux2x1_4bits;

architecture a_mux2x1_4bits of mux2x1_4bits is

begin
	saida <= entrada01 when enable='1' and seletor='0' else
			 entrada02 when enable='1' and seletor='1' else
			"0000";			 
end architecture a_mux2x1_4bits;