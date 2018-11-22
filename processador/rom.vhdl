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
		0 => "0001000000000011", -- ADDI R3, 0
		1 => "0001000000000100", -- ADDI R4, 0
		2 => "0001000111100111", -- ADDI R7, 30
		3 => "0101001100000100", -- ADD R4,R3
		4 => "0001000000010011", -- ADDI R3,1
		5 => "0100001100000101", -- MOV R5,R3
		6 => "0100011100000110", -- MOV R6,R7
		7 => "1000011000000101", -- SUB R5,R6
		8 => "0011001111111010", -- JN INSTRUCAO4
		9 => "0100010000000101", -- MOV R5,R4
		10 => "0000000000000000",
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