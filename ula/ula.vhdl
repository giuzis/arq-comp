library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
			seletor : in unsigned(1 downto 0);
			entrada01, entrada02 : in signed(15 downto 0);
			saida: out signed(15 downto 0)
			--OBS: Signed = Complemento de 2. Coloquei por causa dos números negativos.
		);
end entity ula;

architecture a_ula of ula is
	signal soma, subt, mult, comp: signed(15 downto 0);
begin
	soma <= entrada01 + entrada02;
	subt <= entrada01 - entrada02;
	mult <= entrada01(7 downto 0) * entrada02(7 downto 0);
	--Macaquisse do século! Existe maneira de evitar o problema de bits?
	--Lembrando: 16bits * 16bits obtem-se 32bits (máx) de sáida. Tanto para unsigned quanto para signed. Pegando só os 8 primeiros também
	comp <= "0000000000000000" WHEN entrada01 <= entrada02 else
			"0000000000000001";
	saida <= soma WHEN seletor="00" else
			 subt WHEN seletor="01" else
			 mult WHEN seletor="10" else
			 comp WHEN seletor="11" else
			 "0000000000000000";
end architecture;