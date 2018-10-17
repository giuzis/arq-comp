library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_com_jump is
	port(
			clk : in std_logic;
			rst : in std_logic;
			instr : out unsigned(14 downto 0)
		);
end entity;

architecture a_toplevel_com_jump of toplevel_com_jump is
	component proto_uc_jump is
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			jump_flag: in std_logic;
			data_in: in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
	 	);
	end component proto_uc_jump;

	component rom is
		port( 
			clk : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado : out unsigned(14 downto 0)
		);
	end component rom;

	component fsm is
	 	port(   
	 			clk : in std_logic;
				rst : in std_logic;
				estado: out std_logic
	 	);
	end component fsm;

	component unidade_de_controle is
	  	port (
				instr 	    : in unsigned(14 downto 0);
		  		jump_flag	: out std_logic;
		  		erro_flag   : out std_logic
	  	) ;
	end component ; 
	
	signal data_out_s, endereco_s, endereco_jump: unsigned(6 downto 0);
	signal instr_s : unsigned(14 downto 0);
	signal estado_s, wr_en, jump_flag, erro_flag: std_logic;
	--signal opcode: unsigned;

begin

	proto_uc_jump_s:	proto_uc_jump port map (
								data_out => data_out_s,
								clk 	 => clk,
			 					rst 	 => rst,
								wr_en	 => wr_en,
								jump_flag => jump_flag,
								data_in => endereco_jump
							);

	rom_s:		rom port map (
						clk 	 => clk,
			 			endereco => endereco_s,
						dado	 => instr_s
						);

	fsm_s:		fsm port map (
						clk 	=> clk,
						rst 	=> rst,
						estado 	=> estado_s
						);

	uc:			unidade_de_controle port map (
						instr => instr_s,
						jump_flag => jump_flag,
						erro_flag => erro_flag
						);

	instr <= instr_s; -- 

	endereco_jump <= instr_s(6 downto 0); -- separa o possivel endereco para o jump

	endereco_s <= data_out_s when estado_s = '0';		-- faz a leitura da rom no estado 0

	wr_en <= '0' when estado_s = '0' else -- liga a escrita no pc no estado 1
			 '1';


	
end architecture a_toplevel_com_jump;