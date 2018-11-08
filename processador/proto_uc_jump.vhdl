library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_uc_jump is
	port(
			clk : in std_logic;
			pc_rst : in std_logic;
			pc_wr_en : in std_logic;
			jump_flag : in std_logic;
			pc_data_in : in unsigned(5 downto 0);
			pc_data_out : out unsigned(5 downto 0)
		);
end entity;

architecture a_proto_uc_jump of proto_uc_jump is
	component pc is
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_in : in unsigned(5 downto 0);
			data_out : out unsigned(5 downto 0)
	 	);
	end component pc;
	
	signal data_in_s, data_out_s, soma, soma_mult: unsigned(5 downto 0);
	signal mult: unsigned(6 downto 0);

begin

	pc_s:	pc port map (
						data_out => data_out_s,
						data_in  => data_in_s,
						clk 	 => clk,
			 			rst 	 => pc_rst,
						wr_en	 => pc_wr_en
						);

	mult <= pc_data_in & '0';

	soma <= data_out_s + 2;

	soma_mult <= soma + mult(5 downto 0);

	data_in_s <= soma when jump_flag = '0' else
				 soma_mult;

	pc_data_out <= data_out_s;

	
end architecture a_proto_uc_jump;