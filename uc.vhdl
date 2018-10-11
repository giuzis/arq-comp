library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port (
			clk: in std_logic;
			wr_en: in std_logic;
			data_in: in unsigned(14 downto 0);
			data_out: out unsigned(14 downto 0)
		);
end entity;

architecture a_uc of uc is
	signal data_out_s: unsigned(14 downto 0);
begin
	process(wr_en,clk)
		begin
			if wr_en='1' then
			elsif rising_edge(clk) then
			data_out_s <= data_in + "000000000000001";
		end if;
		end process;
		data_out <= data_out_s;
end architecture;