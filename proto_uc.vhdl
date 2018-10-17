library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_uc is
	port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_out : out unsigned(6 downto 0)
		);
end entity;

architecture a_proto_uc of proto_uc is
	component pc is
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_in : in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
	 	);
	end component pc;
	
	signal data_in, data_out_s : unsigned(6 downto 0);

begin

	pc_s:	pc port map (
						data_out => data_out_s,
						data_in  => data_in,
						clk 	 => clk,
			 			rst 	 => rst,
						wr_en	 => wr_en
						);

	data_in <= data_out_s + "0000001";
	data_out <= data_out_s;

	
end architecture a_proto_uc;