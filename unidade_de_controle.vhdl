library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle is
  port (
		instr 	    : in unsigned(14 downto 0);
  		jump_flag	: out std_logic;
  		erro_flag   : out std_logic;
  		operation_ula: out unsigned(1 downto 0)
  ) ;
end entity ;

architecture a_unidade_de_controle of unidade_de_controle is

signal opcode: unsigned(3 downto 0);

begin
 opcode  <= instr(14 downto 11);

--INSTRUÇÃO DO TIPO J.
 jump_flag <= '1' when opcode = "1111" else
 			'0';

 erro_flag <= '0' when opcode = "1111" else
 			  '0' when instr = "0000000000000000" else
 			  '1';
--INSTRUÇÃO DO TIPO R

operation_ula <= "00" WHEN opcode="0101" ELSE--soma
				 "01" WHEN opcode="1000" ELSE --subtração

end architecture ;

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
--OBS: JMP é tipo J, tem opcode menor (só 3 bits). SOLUÇÃO DA GIU: DEIXA 4 DERR, sou um idiota.