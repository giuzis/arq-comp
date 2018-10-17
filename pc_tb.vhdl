library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;

architecture a_pc_tb of pc_tb is
	component pc is
		port (
			 clk : in std_logic;
			 rst : in std_logic;
			 wr_en : in std_logic;
			 data_in : in unsigned(14 downto 0);
			 data_out : out unsigned(14 downto 0)
		);
	end component;
	signal clk, rst, wr_en: std_logic;
	signal data_in,data_out: unsigned(14 downto 0);
	begin
	 uut: pc port map(clk=>clk,rst=>rst,wr_en=>wr_en,data_in=>data_in,
	 data_out=>data_out);
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

	 process -- sinais dos casos de teste
		 begin
		 wait for 100 ns;
		 wr_en <= '0';
		 data_in <= "111111111111111";
		 wait for 100 ns;
		 wr_en <= '1';
		 data_in <= "101010110001011";
		 wait;
	end process;

end architecture;
