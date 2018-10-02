library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_ula is
	port(
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
			sel_mux:						in std_logic;
			sel_ula:						in unsigned(1 downto 0)
		);
end entity;

architecture a_banco_reg_ula of banco_reg_ula is
	component banco_reg is
		port (
			 	data: 						in unsigned(15 downto 0); 	--Dado para write.
				read_data_1, read_data_2: 	out unsigned(15 downto 0); 	-- Read data 1 e 2
				clk: 						in std_logic; --Clock universal
				rst: 						in std_logic; --Reset universal
				read_reg_1: 				in unsigned(2 downto 0); -- Read register 1
				read_reg_2: 				in unsigned(2 downto 0); -- Read register 2
				write_reg:					in unsigned(2 downto 0); -- Write register
				en_write:					in std_logic  -- Enable write
			);
	end component;

	component ula is 
		port (
				seletor : 					in unsigned(1 downto 0);
				entrada01, entrada02 : 		in unsigned(15 downto 0);
				saida_ula: 					out unsigned(15 downto 0);
				saida_maior: 				out unsigned(0 downto 0)
			);
	end component;

	component mux2x1 is
		port( 
				entrada01, entrada02: 		in unsigned(15 downto 0);
				enable:						in std_logic;
				seletor:					in std_logic;
				saida:						out unsigned(15 downto 0)
			);
	end component;

	signal out_ula, out_banco1, out_banco2, out_mux: unsigned(15 downto 0);


	begin

		banco_reg_s: 	banco_reg port map(
										data 		=> out_ula, 
										read_data_1 => out_banco1,
										read_data_2 => out_banco2,
										clk 		=> clk,
										rst 		=> rst,
										en_write 	=> en_write,
										write_reg 	=> write_reg,
										read_reg_1 	=> read_reg_1,
										read_reg_2 	=> read_reg_2
										);

		ula_s: 		ula port map(
										saida_ula 	=> out_ula, 
										entrada01 	=> out_banco1, 
										entrada02 	=> out_mux,
										seletor		=> sel_ula,
										saida_maior => saida_maior
								);

		mux_s:		mux2x1 port map(
										entrada01 	=> out_banco2,
										entrada02 	=> immediate,
										saida     	=> out_mux,
										seletor		=> sel_mux,
										enable 		=> en_mux
								);

		saida_ula <= out_ula;


end architecture;