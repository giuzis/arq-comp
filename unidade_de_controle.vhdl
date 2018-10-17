library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               

entity unidade_de_controle is
  port (
		instr 	    : in unsigned(14 downto 0);
  		jump_flag	: out std_logic;
  		erro_flag   : out std_logic
  ) ;
end entity ; 

architecture a_unidade_de_controle of unidade_de_controle is

signal opcode: unsigned(3 downto 0);

begin
 opcode  <= instr(14 downto 11);

 jump_flag <= '1' when opcode = "1111" else
 			'0';

 erro_flag <= '0' when opcode = "1111" else
 			  '0' when instr = "0000000000000000" else 
 			  '1'; 
end architecture ; 
