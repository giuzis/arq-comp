library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barramento is
	port (
			instr: in unsigned(15 downto 0);
			opcode: out unsigned(3 downto 0);
			src: out unsigned(3 downto 0);
			dest: out unsigned(3 downto 0);
			end_jump: out unsigned(5 downto 0);
			immediate: out unsigned(7 downto 0);
			opcode_jump: out unsigned(5 downto 0)
		);
end entity barramento;

architecture a_barramento of barramento is

begin

	opcode <= instr(15 downto 12);
	src <= instr(11 downto 8);
	dest <= instr(3 downto 0);
	end_jump <= instr(5 downto 0);
	immediate <= instr(11 downto 4);
	opcode_jump <= instr(15 downto 10);

	
end architecture a_barramento;