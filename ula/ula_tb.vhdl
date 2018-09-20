library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end;

architecture a_ula_tb of ula_tb is
	component ula
		port(
			seletor : in unsigned(1 downto 0);
			entrada01, entrada02 : in signed(15 downto 0);
			saida: out signed(15 downto 0)
			);
	end component;
	signal seletor: unsigned(1 downto 0);
	signal entrada01, entrada02 : signed(15 downto 0);

	begin
		uut: ula port map ( seletor => seletor,
							entrada01 => entrada01,
							entrada02 => entrada02);

	process
		begin
		--Somando 2 Números normais. (Sem overflow). 01 = 64689 02 = 62870
			entrada01 <= "1111110010110001";
			entrada02 <= "1111010110010110";
			seletor <= "00";
		--Resposta: 01 + 02 = 127 559. Overflow em 65536. Somando com o resto, a resposta deverá ser -3512, ou ainda: 0x0DB8 em complemento de 2, seria: 0xF248
			wait for 50 ns;
			entrada01 <= "0111111111111111"; -- 32k
			entrada02 <= "0000000000000001"; -- 1
			seletor <= "00"; --Soma. Resposta prevista:  -32k
			wait for 50 ns;
			entrada01 <= "0111111111111111"; --32k
			entrada02 <= "0000000000000001"; -- 1
			seletor <= "01"; --Subtração. Lembrando que estamos em complemento de 2. Resposta prevista: 32k-1
			wait for 50 ns;
			entrada01 <= "0111111111111111";
			entrada02 <= "0111111111111111";
			seletor <= "01";
			wait for 50 ns;
			entrada01 <= "1111111100000000";
			entrada02 <= "0000000011111111";
			seletor <= "10";
			wait for 50 ns;
			entrada01 <= "0000000000000001";
			entrada02 <= "0000000001111111";
			seletor <= "11";
			wait for 50 ns;
			wait;
		end process;
end architecture;
