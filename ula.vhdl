library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
			seletor: 				in unsigned(1 downto 0);
			entrada01, entrada02: 	in unsigned(15 downto 0);
			saida_ula: 				out unsigned(15 downto 0);
			saida_maior: 			out unsigned(0 downto 0)
		);
end entity ula;

architecture a_ula of ula is
begin
	saida_ula <= 	entrada01 + entrada02 							WHEN seletor="00" else
					entrada01 - entrada02 							WHEN seletor="01" else
					entrada01(7 downto 0) * entrada02(7 downto 0) 	WHEN seletor="10" else
					entrada01 										WHEN seletor="11" and entrada01 > entrada02 else
					entrada02 										WHEN seletor="11" and (entrada01 < entrada02 or entrada01 = entrada02) else
					"0000000000000000";
	saida_maior <= 	"1" 											WHEN entrada01 > entrada02 and seletor = "11" else 
					"0";
end architecture;