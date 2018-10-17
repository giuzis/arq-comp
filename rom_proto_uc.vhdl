library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_proto_uc is
	port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			dado : out unsigned(14 downto 0)
		);
end entity;

architecture a_rom_proto_uc of rom_proto_uc is
	component proto_uc is
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_out : out unsigned(6 downto 0)
	 	);
	end component proto_uc;

	component rom is
		port( 
			clk : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado : out unsigned(14 downto 0)
		);
	end component rom;
	
	signal data_out_s : unsigned(6 downto 0);

begin

	proto_uc_s:	proto_uc port map (
						data_out => data_out_s,
						clk 	 => clk,
			 			rst 	 => rst,
						wr_en	 => wr_en
						);

	rom_s:		rom port map (
						clk 	 => clk,
			 			endereco => data_out_s,
						dado	 => dado
						);

	
end architecture a_rom_proto_uc;