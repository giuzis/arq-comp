library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port (
			wr_en: in std_logic;
			data_in: in unsigned(14 downto 0);
			data_out: out unsigned(14 downto 0)
		);
end entity;

architecture a_uc of uc is
begin
	data_out <= data_in + "000000000000001" WHEN wr_en='1';-- ELSE "000000000000000";
end architecture;