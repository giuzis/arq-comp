library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(
		clk : in std_logic;
		endereco : in unsigned(5 downto 0);
		instr : out unsigned(14 downto 0)
	);
end entity rom;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(14 downto 0);
	constant conteudo_rom : mem := (
		-- caso endereco => conteudo
		0 => "000000000000000", -- ADDI R3, 0
		1 => "000000000000000", -- ADDI R4, 0
		2 => "000000000000000", -- ADDI R7, 30
		3 => "000000000000000", -- ADD R4,R3
		4 => "000000000000000", -- ADDI R3,1
		5 => "000000000000000", -- MOV R5,R3
		6 => "000000000000000", -- MOV R6,R7
		7 => "000000000000000", -- SUB R5,R6
		8 => "000000000000000", -- JN INSTRUCAO4
		9 => "000000000000000", -- MOV R5,R4
		10 => "000000000000000",
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