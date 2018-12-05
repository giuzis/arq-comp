library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(
		clk : in std_logic;
		endereco : in unsigned(5 downto 0);
		instr : out unsigned(15 downto 0)
	);
end entity rom;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem := (
		-- caso endereco => conteudo
		0 => "0000000000000000", 
		1 => "0001000000010010", -- addi r2, 1
		2 => "0001000000100011", -- addi r3, 2
		3 => "0001000011110100", -- addi r4, 0x000F
		4 => "0001000011000101", -- addi r5, 0x000C
		5 => "0100001010000100", -- sw r4, r2 
		6 => "0100001110000101", -- sw r5, r3
		7 => "0100010001000110", -- lw r6, r4
		8 => "0100010101000111", -- lw r7, r5
		9 => "0000000000000000",
		10 => "0000000000000000",
		11 => "0000000000000000",
		-- abaixo: casos omissos => (zero em todos os bits)
		others => (others=>'0')
	);
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
		instr <= conteudo_rom(to_integer(endereco));
	end if;
	end process;
end architecture;