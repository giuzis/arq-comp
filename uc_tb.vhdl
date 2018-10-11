library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is
end entity;

architecture a_uc_tb of uc_tb is
	component uc is
		port (
			clk: in std_logic;
			wr_en: in std_logic;
			data_in: in unsigned(14 downto 0);
			data_out: out unsigned(14 downto 0)
		);
	end component;
	signal wr_en_s, clk_s: std_logic;
	signal data_in_s, data_out_s: unsigned(14 downto 0);
	begin
		uut: uc port map (
			wr_en=>wr_en_s,
			clk=>clk_s,
			data_in=>data_in_s,
			data_out=>data_out_s
		);
	process --CLOCK
		 begin
		 clk_s <= '0';
		 wait for 50 ns;
		 clk_s <= '1';
		 wait for 50 ns;
	 end process;
	process
	begin
		wr_en_s <= '0';
		data_in_s <= "000000000000000";
		wait for 50 ns;
		wr_en_s <= '1';
		wait for 150 ns;
		wait;
	end process;
end architecture;