library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(
		clk : in std_logic;
		endereco : in unsigned(6 downto 0);
		instr : out unsigned(15 downto 0)
	);
end entity rom;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem := (
		-- caso endereco => conteudo
		0 => "0001000001010011", -- ADDI R3, 5
		1 => "0001000010000100", -- ADDI R4, +8
		2 => "0100001111110101", -- MOV R3,R5
		3 => "0101010000000101", -- ADD R4,R5
		4 => "0001111111110101", -- ADDi R5, -1
		5 => "0011010100010100", -- jump para o endereço 20
		6 => "0000000000000000", -- nop
		7 => "0000000000000000", -- nop
		8 => "0000000000000000", -- nop
		9 => "0000000000000000", -- nop
		10 => "0000000000000000",-- nop
		11 => "0000000000000000", -- nop
		12 => "0000000000000000", -- nop
		13 => "0000000000000000", -- nop
		14 => "0000000000000000", -- nop
		15 => "0000000000000000", -- nop
		16 => "0000000000000000", -- nop
		17 => "0000000000000000", -- nop
		18 => "0000000000000000", -- nop
		19 => "0000000000000000", -- nop
		20 => "0100010110100011", -- MOV R5,R3
		21 => "0011100100000011" -- jump para o endereco 3
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