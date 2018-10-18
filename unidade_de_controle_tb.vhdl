library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle_tb is
end entity;

architecture a_unidade_de_controle_tb of unidade_de_controle_tb is
	component unidade_de_controle is
		port (
		opcode 	    		: in unsigned(3 downto 0);
  		jump_flag			: out std_logic;
  		erro_flag   		: out std_logic;
  		reg_wr_en			: out std_logic;
  		update_pc			: out std_logic;
  		mux_reg				: out std_logic;
  		mux_immediate		: out std_logic;
  		maquina_de_estados	: in unsigned(1 downto 0);
  		operation_ula		: out unsigned(1 downto 0)
  ) ;
	end component unidade_de_controle;

	signal opcode: unsigned(3 downto 0);
	signal maquina_de_estados: unsigned(1 downto 0); 

	begin

	 uut: unidade_de_controle port map(opcode => opcode, maquina_de_estados => maquina_de_estados);

	 process -- sinal de clock
	 begin
	 	-- testa o mov
		 opcode <= "0100";
		 maquina_de_estados <= "00";
		 wait for 100 ns;
		 maquina_de_estados <= "01";
		 wait for 100 ns;
		 maquina_de_estados <= "10";
		 wait for 100 ns;

		 -- testa o jmp
		 opcode <= "0011";
		 maquina_de_estados <= "00";
		 wait for 100 ns;
		 maquina_de_estados <= "01";
		 wait for 100 ns;
		 maquina_de_estados <= "10";
		 wait for 100 ns;

		 -- testa o add
		 opcode <= "0101";
		 maquina_de_estados <= "00";
		 wait for 100 ns;
		 maquina_de_estados <= "01";
		 wait for 100 ns;
		 maquina_de_estados <= "10";
		 wait for 100 ns;

		 -- testa o sub
		 opcode <= "1000";
		 maquina_de_estados <= "00";
		 wait for 100 ns;
		 maquina_de_estados <= "01";
		 wait for 100 ns;
		 maquina_de_estados <= "10";
		 wait for 100 ns;

		 -- testa o cmp
		 opcode <= "1001";
		 maquina_de_estados <= "00";
		 wait for 100 ns;
		 maquina_de_estados <= "01";
		 wait for 100 ns;
		 maquina_de_estados <= "10";
		 wait for 100 ns;

		 -- testa o addi
		 opcode <= "0001";
		 maquina_de_estados <= "00";
		 wait for 100 ns;
		 maquina_de_estados <= "01";
		 wait for 100 ns;
		 maquina_de_estados <= "10";
		 wait for 100 ns;

		
		 wait;
	end process;

end architecture a_unidade_de_controle_tb;