library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is

	component rom is
		port( 
			clk : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado : out unsigned(14 downto 0)
		);
	end component rom;

	signal clk: std_logic;
	signal endereco: unsigned(6 downto 0);
	signal dado: unsigned(14 downto 0);

begin
	utt: rom port map (
		clk => clk,
		endereco => endereco,
		dado => dado
	);
	process
	begin
		
	
end architecture a_rom_tb;rom_tb 