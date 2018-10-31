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
		0 => "0000000000000000", -- nop
		1 => "0001000001010011", -- ADDI R3, 5
		2 => "0001000010000100", -- ADDI R4, +8
		3 => "0100001111110101", -- MOV R3,R5
		4 => "0101010000000101", -- ADD R4,R5
		5 => "0001111111110101", -- ADDi R5, -1
		6 => "0011000000010100", -- jump para o endereço 20		6 => "0001000001010011", -- ADDI R3, 5
		7 => "0001000010000100", -- ADDI R4, +8
		8 => "0100001111110101", -- MOV R3,R5
		9 => "0101010000000101", -- ADD R4,R5
		10 => "0001111111110101", -- ADDi R5, -1
		11 => "0011000000010100", -- jump para o endereço 20
		12 => "0000000000000000", -- nop
		13 => "0000000000000000", -- nop
		14 => "0000000000000000", -- nop
		15 => "0000000000000000", -- nop
		16 => "0000000000000000",-- nop
		17 => "0000000000000000", -- nop
		18 => "0000000000000000", -- nop
		19 => "0000000000000000", -- nop
		20 => "0100010110100011", -- MOV R5,R3
		21 => "0011100100000011", -- jump para o endereco 3
		22 => "0000000000000000", -- nop
		23 => "0000000000000000", -- nop
		24 => "0000000000000000", -- nop
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