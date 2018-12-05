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
		1 => "0001000000010001", -- addi r1, 1
		2 => "0001000000010010", -- addi r2, 1
		3 => "0001001000000101", -- addi r5, 0x0020
		4 => "0001000111110110", -- addi r6, 0x001F
		5 => "0001000000010001", -- addi r1, 1 LOOP01 
		6 => "0001000000010010", -- addi r2, 1
		7 => "0100001010000001", -- sw (r2), r1
		8 => "0100011100000001", -- mov r7, r1
		9 => "0001011000000111", -- addi r7, -32
		10 => "0010000000000101", -- jne loop1
		11 => "0001000000010011", -- addi r3,1
		12 => "0001000000010011", -- addi r3,1 LOOPEX
		13 => "0100010000000011", -- mov r4,r3
		14 => "0101010000000011", -- add r4,r3 LOOPIN
		15 => "0100010010000011", -- sw (r4),r3
		16 => "0100011100000110", -- mov r7,r6
		17 => "1000011100000100", -- sub r7,r4
		18 => "0011000000001110", -- jn loopin
		19 => "0100011100000101", -- mov r7,r5
		20 => "1000011100000011", -- sub r7, r3
		21 => "0010000000001100", -- jne loopex
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