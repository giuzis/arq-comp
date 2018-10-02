library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_ula_tb is
end entity ;

architecture a_banco_reg_ula_tb of banco_reg_ula_tb is
	component banco_reg_ula is
		port (
				immediate:	 					in unsigned(15 downto 0); 	--Dado para write.
				saida_ula:				 		out unsigned(15 downto 0); 
				saida_maior:					out unsigned(0 downto 0);
				clk: 							in std_logic; --Clock universal
				rst: 							in std_logic; --Reset universal
				read_reg_1: 					in unsigned(2 downto 0); -- Read register 1
				read_reg_2: 					in unsigned(2 downto 0); -- Read register 2
				write_reg:						in unsigned(2 downto 0); -- Write register
				en_write:						in std_logic;  -- Enable write
				en_mux:							in std_logic;
				sel_mux:						in std_logic; -- 0 para read_data_2, 1 para immediate
				sel_ula:						in unsigned(1 downto 0) 
		);
	end component banco_reg_ula;

	signal clk, rst, en_write, en_mux, sel_mux: std_logic;
	signal sel_ula: unsigned(1 downto 0);
	signal saida_maior: unsigned(0 downto 0);
	signal write_reg,read_reg_1,read_reg_2: unsigned(2 downto 0);
	signal immediate, saida_ula: unsigned(15 downto 0);

begin
	uut: banco_reg_ula port map (
		immediate => immediate,
		clk => clk,
		rst => rst,
		read_reg_1 => read_reg_1,
		read_reg_2 => read_reg_2,
		write_reg => write_reg,
		en_write => en_write,
		en_mux => en_mux,
		sel_ula => sel_ula,
		sel_mux => sel_mux,
		saida_ula => saida_ula,
		saida_maior =>saida_maior
	);
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process ; --
	
	process
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;
	
	process
	begin
		wait for 100 ns;
		read_reg_2 <= "000";
		read_reg_1 <= "000"; -- a saída do registrador 0 vai para a entrada da ula
		en_write <= '1';	 -- habilita a escrita no banco
		en_mux <= '1';
		sel_mux <= '1';		 -- seleciona o imediato para ir na segunda entrada da ula
		sel_ula <= "00";	 -- seleciona a operação de soma da ula
		immediate <= "0000000000001111"; -- dado do imediato
		write_reg <= "001";	 -- manda escrever no registrador 1
		wait for 100 ns;
		immediate <= "0000000011110000"; -- dado do imediato
		write_reg <= "010";	 -- manda escrever no registrador 2;
		wait for 100 ns;
		immediate <= "0000111100000000"; -- dado do imediato
		write_reg <= "011";	 -- manda escrever no registrador 3;
		wait for 100 ns;
		immediate <= "1111000000000000"; -- dado do imediato
		write_reg <= "100";	 -- manda escrever no registrador 4;
		wait for 100 ns;
		sel_mux <= '0';		 -- seleciona o registrador para ir na segunda entrada da ula
		read_reg_1 <= "001";
		read_reg_2 <= "010";
		write_reg <= "010";
		wait for 100 ns;
		read_reg_1 <= "010";
		read_reg_2 <= "011";
		write_reg <= "011";
		wait for 100 ns;
		read_reg_1 <= "011";
		read_reg_2 <= "100";
		write_reg <= "100";
		wait for 100 ns;
		en_write <= '0';
		write_reg <= "101";
		read_reg_1 <= "100"; -- verifica o resultado final no registrador 4
		read_reg_2 <= "000";
		wait for 100 ns;
		read_reg_1<="000";
		read_reg_2<="101";
		wait;

	end process;
end architecture;
