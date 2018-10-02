library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;             
use ieee.math_real.all;               

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
	component ula is
		port (
			seletor: 				in unsigned (1 downto 0);
			entrada01,entrada02:    in unsigned(15 downto 0);
			saida_ula:      		out unsigned(15 downto 0);
			saida_maior:	  		out unsigned(0 downto 0)
		);
	end component ula;
	signal entrada01, entrada02, saida_ula:	unsigned(15 downto 0);
	signal seletor: 						unsigned(1 downto 0);
 	signal saida_maior: 					unsigned(0 downto 0);
begin
	uut:ula port map (	entrada01 	=> entrada01,
						entrada02 	=> entrada02,
						seletor		=> seletor,
						saida_ula 	=> saida_ula,
						saida_maior => saida_maior
	);
	process
	begin

	-- soma
	entrada01 <= "0000000000000010";
	entrada02 <= "0000000000000010";
	seletor<="00";
	wait for 50 ns;	
	entrada01<="0000000100000000";
	entrada02<="1000000100000000";
	seletor<="00";
	wait for 50 ns;	
	entrada01<="1000000000000010";
	entrada02<="1000000000000010";
	seletor<="00";
	wait for 50 ns;	
	entrada01<="1111111111111110";
	entrada02<="0000000000000100";
	seletor<="00";
	wait for 50 ns;	

	--subtração
	entrada01<="1111111111111100";
	entrada02<="0000000000000100";
	seletor<="01";
	wait for 50 ns;
	entrada01<="1111111111111100";
	entrada02<="1111111111111000";
	seletor<="01";
	wait for 50 ns;
	entrada01<="1111111111111100";
	entrada02<="0000000000000100";
	seletor<="01";
	wait for 50 ns;
	entrada01<="1111111111111100";
	entrada02<="1111111111111100";
	seletor<="01";
	wait for 50 ns;

	--multiplicação
	entrada01<="0000000000011001";
	entrada02<="0000000000011010";
	seletor<="10";
	wait for 50 ns;
	
	--maior
	entrada01<="0000000000000100";
	entrada02<="0000000001000010";
	seletor<="11";
	wait for 50 ns;
	entrada01<="0000000000000100";
	entrada02<="0000000001000010";
	seletor<="11";
	wait for 50 ns;
	entrada01<="0000010000000100";
	entrada02<="0000000001000010";
	seletor<="11";
	wait for 50 ns;
	entrada01<="0000001000000100";
	entrada02<="0000000001000010";
	seletor<="11";
	wait for 50 ns;
	wait;
	end process;
end architecture ;