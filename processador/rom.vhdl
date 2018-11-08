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
		1 => "0000000000000000", 
		2 => "0001000000000100", -- ADDI R4, 0
		3 => "0000000000000000", 
		4 => "0001000111100111", -- ADDI R7, 30
		5 => "0000000000000000",
		6 => "0101001100000100", -- ADD R4,R03
		7 => "0000000000000000", 
		8 => "0001000000010011", -- ADDI R3,1
		9 => "0000000000000000", 
		10 => "0100001100000101", -- MOV R5,R3
		11 => "0000000000000000", 
		12 => "0100011100000110", -- MOV R6,R7
		13 => "0000000000000000", 
		14 => "1000011000000101", -- SUB R5,R6
		15 => "0000000000000000",  
		16 => "0011001111111010", -- JN INSTRUCAO4
		17 => "0000000000000000", 
		18 => "0100010000000101", -- MOV R5,R4
		19 => "0000000000000000",
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