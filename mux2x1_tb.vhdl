library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity mux2x1_tb is
end entity;
architecture a_mux2x1_tb of mux2x1_tb is
	component mux2x1 is
		port (
			in_a, in_b: in unsigned(15 downto 0);
			enable: in std_logic;
			sel:in unsigned (1 downto 0);
			saida:out unsigned(15 downto 0)
		);
	end component mux2x1;

	signal in_a, in_b, saida :unsigned(15 downto 0);
	signal sel:  unsigned (1 downto 0);
	signal enable: std_logic;

begin
	uut: mux2x1 port map (
		in_a=>in_a,
		in_b=>in_b,
		enable=>enable,
		sel=>sel, 
		saida=>saida
	);
    process
	begin

		enable <= '1';
		sel <= "00";
		in_a <= "0000000000000001";
		in_b <= "0000000000000010";
		wait for 50 ns;
		sel<="01";
		wait for 50 ns;
		sel<="10";
		wait for 50 ns;
		sel<="11";
		wait;
	end process ; -- 

end architecture ; -- a_mux2x1_tb