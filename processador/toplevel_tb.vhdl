library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end entity;

architecture a_toplevel_tb of toplevel_tb is
	component toplevel is
		port(
			clk : in std_logic;
			rst : in std_logic;
			instr : out unsigned(15 downto 0);
			saida_ula : out unsigned(15 downto 0)
		);
	end component toplevel;

	signal clk, rst: std_logic;
	signal instr, saida_ula: unsigned(15 downto 0);

	begin

	 uut: toplevel port map(clk => clk, 
	 						rst => rst,
	 						saida_ula => saida_ula,
	 						instr => instr);

	 process -- sinal de clock
	 begin
		 clk <= '0';
		 wait for 50 ns;
		 clk <= '1';
		 wait for 50 ns;
	 end process;

	 process -- sinal de reset
		 begin
		 rst <= '1';
		 wait for 100 ns;
		 rst <= '0';
		 wait;
	 end process;

end architecture a_toplevel_tb;