library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_tb is
end entity;

architecture a_fsm_tb of fsm_tb is
	component fsm is
		port (
			 clk : in std_logic;
			 rst : in std_logic;
			 estado : out std_logic
		);
	end component;
	signal clk, rst, estado: std_logic;
	--signal estado: unsigned(15 downto 0);
	begin
	 uut: fsm port map(clk => clk, rst => rst, estado => estado);
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

end architecture;
