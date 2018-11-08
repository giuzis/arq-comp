library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle is
  port (
		opcode 	    		: in unsigned(3 downto 0);
		opcode_jump			: in unsigned(5 downto 0);
  		jump_flag			: out std_logic;
  		reg_wr_en			: out std_logic;
  		update_pc			: out std_logic;
  		mux_reg_flag		: out std_logic;
  		mux_immediate_flag	: out std_logic;
  		maquina_de_estados	: in unsigned(1 downto 0);
  		z_bit, c_bit, n_bit	: in std_logic;
  		operation_ula		: out unsigned(1 downto 0);
  		update_ula_out		: out std_logic;
  		reg_flags_wr_en		: out std_logic
  ) ;
end entity ;

architecture a_unidade_de_controle of unidade_de_controle is

begin

	update_pc 	<= 	'1' when maquina_de_estados = "10" else -- fetch/qualquer instrucao => atualiza PC
					'0';
	
	mux_reg_flag	<= 	'1' when opcode = "0100" else -- decode/mov => mux_reg quando é 1 manda ler o reg0 ao invés de dest, assim, a ula soma o source com 0
						'0';

	mux_immediate_flag	<= '1' when opcode = "0001" and maquina_de_estados = "00" else -- decode/addi => mux_immediate quando é 1 manda o imediato ao invés do dado do src
					   '0';

	reg_wr_en	<=	'1' when maquina_de_estados = "00" 
					and	(opcode = "0100"  -- execute/mov => manda escrever o resultado da ula (src) no registrador dst
					or opcode = "0101" -- execute/add => manda escrever o resultado da ula (soma) no registrador dst
					or opcode = "1000" -- execute/sub => manda escrever o resultado da ula (subtracao) no registrador dst
					or opcode = "0001") -- execute/addi => manda escrever o resultado da ula (soma_immediate) no registrador dst
					else '0';

	reg_flags_wr_en <= '1' when maquina_de_estados = "10" else
					  '0';

	
	jump_flag 	<=	'1' when ((opcode_jump = "001001" and z_bit = '1')	-- jeq: jump if zero bit is set
					or (opcode_jump = "001000" and z_bit = '0')	  		-- jne: jump if zero bit is reset
					or (opcode_jump = "001011" and c_bit = '1')	 		-- jc:	jump if carry bit is set
					or (opcode_jump = "001010" and c_bit = '0')			-- jnc: jump if carry bit is reset
					or (opcode_jump = "001100" and n_bit = '1')			-- jn:	jump if negative bit is set
					or (opcode_jump = "001111"))
					and maquina_de_estados = "10" else -- fetch/jmp => ativa jump_flag
	 			  	'0';
	
	operation_ula <= "00" WHEN opcode = "0101" or opcode = "0001" else -- qualquer estado/add/addi => manda a ula somar
					 "01" WHEN opcode = "1000" else -- qualquer estado/sub => manda a ula subtrair
					 "11" when opcode = "1001" else -- qualquer estado/cmp => manda a ula comparar
					 "00";


end architecture ;