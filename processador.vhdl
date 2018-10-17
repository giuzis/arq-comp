library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port (
			proc_clk: in std_logic;
			proc_rst: in std_logic;
			instrucao_atual: in unsigned(14 downto 0)
		);
end entity;

architecture a_processador of processador is
begin
	component rom is
		port (
			rom_clk: in std_logic;
			rom_end: in unsigned(6 downto 0);
			rom_dado: out unsigned(14 downto 0)
		);
	end component;
signal registrador_1, registrador_2: unsigned (3 downto 0); --Dois registradores de 4 bits.
	-- lIGAÇÃO DOS COMPONENTES DADAS CONDIÇÕES ENCONTRADAS NAS INSTRUÇÕES
	-- LEMBRAR QUE A INSTRUÇÃO SEGUEU O PADRÃO
	-- OPCODE (4 OU 3 BITS) - REGISTRADOR 1 (4 BITS) - MODO ENDEREÇAMENTO REGISTRADOR 1 (1 BIT) - B/W (1 BIT) - MODO ENDEREÇAMENTO REGISTRADOR 2 (2 BITS) - REGISTRADOR 2 (4 BITS).

	-- Redireciona os registradores.
	registrador_1 <= instrucao(11 downto 8) WHEN alguma_coisa

	registrador_2 <= instrucao(3 downto 0) WHEN alguma_coisa

	banco_registradores <= registrador_1 WHEN alguma_coisa ELSE
							registrador_2 WHEN alguma_coisa ELSE
							"0000";

end architecture;


---- Instruções
-- ADD (soma)
-- src, dst (equivalente á >>) src + dst -> dst
--Mapeamento da Instrução:
-- 0101 REG1 A B CC REG2

-- MOV (copia)
-- src, dst (equivalente á >>) src -> dst
-- Mapeamento da Instrução:
-- 0100 REG1 A B CC REG2

-- SUB (subtração)
-- src, dst (equivalente á >>) dst + not_src + 1 -> dst
--Mapeamento da Instrução:
-- 1000 REG1 A B CC REG2

-- JMP (Jump Incondicional)
-- label (end de pulo)
-- Mapeamento da Instrução:
-- 111 C 10-bit PC Offset
--OBS: JMP é tipo J, tem opcode menor (só 3 bits).
