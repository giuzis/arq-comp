library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port( 
		clk : in std_logic;
		endereco : in unsigned(6 downto 0);
		dado : out unsigned(14 downto 0)
	);
end entity rom;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(14 downto 0);
	constant conteudo_rom : mem := (
		-- caso endereco => conteudo
		0 => "100000000000000", -- erro
		1 => "111100000000010", -- jump para o endereco 2 (inicio loop)
		2 => "111100000000100", -- jump para o endereco 4
		3 => "000000000000000", -- nop
		4 => "111100000001000", -- jump para o endereco 8
		5 => "111100000001010", -- jump para o endereço 10
		6 => "000000000000000", -- nop
		7 => "111100000000001", -- jump para o endereco 1 (retoma loop)
		8 => "111100000000101", -- jump para o endereço 5
		9 => "000000000000000", -- nop
		10 => "111100000000110", -- jump para o endereco 6
		-- abaixo: casos omissos => (zero em todos os bits)
		others => (others=>'0')
	);
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
		dado <= conteudo_rom(to_integer(endereco));
	end if;
	end process;
end architecture;