library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle_tb is
end entity;

architecture a_unidade_de_controle_tb of unidade_de_controle_tb is
	component unidade_de_controle is
		port (
				instr 	    : in unsigned(14 downto 0);
  				jump_flag	: out std_logic;
  				erro_flag   : out std_logic
  			);
	end component unidade_de_controle;

	signal jump_flag, erro_flag: std_logic;
	signal instr: unsigned(14 downto 0);

	begin

	 uut: unidade_de_controle port map( 
	 									instr => instr,
	 									jump_flag => jump_flag,
	 									erro_flag => erro_flag
	 								);

	 process -- sinal de clock
	 begin
		 instr <= "000000000000000";
		 wait for 100 ns;
		 instr <= "111100000000000";
		 wait for 100 ns;
		 instr <= "100000000000000";
		 wait for 100 ns;
		 wait;
	end process;

end architecture a_unidade_de_controle_tb;