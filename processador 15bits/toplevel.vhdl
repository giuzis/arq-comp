library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
	port(
			clk : in std_logic;
			rst : in std_logic;
			instr : out unsigned(15 downto 0);
			saida_ula : out unsigned(15 downto 0)
		);
end entity;

architecture a_toplevel of toplevel is
	component proto_uc_jump is
		port(
				clk : in std_logic;
				pc_rst : in std_logic;
				pc_wr_en : in std_logic;
				jump_flag : in std_logic;
				pc_data_in : in unsigned(5 downto 0);
				pc_data_out : out unsigned(5 downto 0)
	 	);
	end component proto_uc_jump;

	component rom is
		port(
				clk : in std_logic;
				endereco : in unsigned(5 downto 0);
				instr : out unsigned(15 downto 0)
		);
	end component rom;

	component ram is
		port(
				clk 	 : in std_logic;
				endereco : in unsigned(6 downto 0);
				wr_en    : in std_logic;
				dado_in  : in unsigned(15 downto 0);
				dado_out : out unsigned(15 downto 0)
			);
	end component ram;

	component maquina_estados is
	 	port(
	 			clk : in std_logic;
				rst : in std_logic;
				estado: out unsigned(1 downto 0)
	 	);
	end component maquina_estados;

	component unidade_de_controle is
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
  		);
	end component unidade_de_controle;

	component banco_reg is
		port(
				data: 						in unsigned(15 downto 0); 	--Dado para write.
				read_data_1, read_data_2: 	out unsigned(15 downto 0); 	-- Read data 1 e 2
				clk: 						in std_logic; --Clock universal
				rst: 						in std_logic; --Reset universal
				read_reg_1: 				in unsigned(3 downto 0); -- Read register 1
				read_reg_2: 				in unsigned(3 downto 0); -- Read register 2
				write_reg:					in unsigned(3 downto 0); -- Write register
				en_write:					in std_logic  -- Enable write
		);
	end component banco_reg;

	component mux2x1_4bits is
		 port (
				entrada01, entrada02: 	in unsigned(3 downto 0);
				enable:					in std_logic;
				seletor:				in std_logic;
				saida:					out unsigned(3 downto 0)
		);
	end component mux2x1_4bits;

	component mux2x1_16bits is
		 port (
				entrada01, entrada02: 	in unsigned(15 downto 0);
				enable:					in std_logic;
				seletor:				in std_logic;
				saida:					out unsigned(15 downto 0)
		);
	end component mux2x1_16bits;

	component ula is
		port(
				seletor: 				in unsigned(1 downto 0);
				entrada01, entrada02: 	in unsigned(15 downto 0);
				saida_ula: 				out unsigned(15 downto 0);
				n_bit, c_bit, z_bit: 	out std_logic
			);
	end component ula;

	component barramento is
	port (
			instr: in unsigned(15 downto 0);
			opcode: out unsigned(3 downto 0);
			src: out unsigned(3 downto 0);
			dest: out unsigned(3 downto 0);
			end_jump: out unsigned(5 downto 0);
			immediate: out unsigned(7 downto 0);
			opcode_jump: out unsigned(5 downto 0)
		);
	end component barramento;

	component reg_flags is
	port (
			clk : in std_logic;
	 		rst : in std_logic;
	 		wr_en : in std_logic;
	 		c_bit_in, n_bit_in, z_bit_in : in std_logic;
	 		c_bit_out, n_bit_out, z_bit_out : out std_logic
		);
	end component reg_flags;

	signal endereco_s, endereco_jump: unsigned(5 downto 0);
	signal instr_s, saida_ula_s, entrada01_ula, entrada02_ula, data_src, immediate_ext: unsigned(15 downto 0);
	signal pc_wr_en, jump_flag, erro_flag, enable_mux, reg_wr_en, mux_reg_flag, mux_immediate_flag, reg_flags_wr_en: std_logic;
	signal opcode, end_src, end_dest, end_reg_2, zero: unsigned(3 downto 0);
	signal immediate: unsigned(7 downto 0);
	signal opcode_jump: unsigned(5 downto 0);
	signal operation_ula, estado_s: unsigned(1 downto 0);
	signal c_bit_out_ula, z_bit_out_ula, n_bit_out_ula, c_bit, z_bit, n_bit: std_logic;
	--Sinais da RAM
	signal ram_data_in, ram_data_out: unsigned(15 downto 0);
	signal ram_address: unsigned(6 downto 0);
	signal ram_wr_en: std_logic;

begin

	proto_uc_jump_s: proto_uc_jump port map (
						pc_data_out => endereco_s,
						clk 	 => clk,
			 			pc_rst 	 => rst,
						pc_wr_en => pc_wr_en,
						jump_flag => jump_flag,
						pc_data_in => endereco_jump
	);

	reg_flags_s:	reg_flags port map (
						clk 	=> clk,
	 					rst 	=> rst,
	 					wr_en 	=> reg_flags_wr_en,
	 					c_bit_in => c_bit_out_ula,
	 					n_bit_in => n_bit_out_ula,
	 					z_bit_in => z_bit_out_ula,
	 					c_bit_out => c_bit,
	 					n_bit_out => n_bit,
	 					z_bit_out => z_bit
	);

	rom_s:		rom port map (
						clk 	 => clk,
			 			endereco => endereco_s,
						instr	 => instr_s
	);

	ram_s:	ram port map(
						clk => clk,
						endereco => ram_address,
						dado_in => ram_data_in,
						dado_out => ram_data_out,
						wr_en => ram_wr_en
	);

	fsm_s:		maquina_estados port map (
						clk 	=> clk,
						rst 	=> rst,
						estado 	=> estado_s
	);

	uc:			unidade_de_controle port map (
						opcode_jump => opcode_jump,
						opcode => opcode,
						jump_flag => jump_flag,
						reg_wr_en => reg_wr_en,
						update_pc => pc_wr_en,
						mux_reg_flag => mux_reg_flag,
						mux_immediate_flag => mux_immediate_flag,
						maquina_de_estados => estado_s,
						operation_ula => operation_ula,
						z_bit => z_bit,
						c_bit => c_bit,
						n_bit => n_bit,
						reg_flags_wr_en => reg_flags_wr_en
	);

	barramento_s: barramento port map (
						instr => instr_s,
						opcode => opcode,
						src => end_src,
						dest => end_dest,
						end_jump => endereco_jump,
						immediate => immediate,
						opcode_jump => opcode_jump
	);

	mux_reg: 	mux2x1_4bits port map (
						entrada01 => end_dest,
						entrada02 => zero,
						enable => enable_mux,
						seletor => mux_reg_flag,
						saida => end_reg_2
	);

	mux_immediate: mux2x1_16bits port map (
						entrada01 => data_src,
						entrada02 => immediate_ext,
						enable => enable_mux,
						seletor => mux_immediate_flag,
						saida => entrada01_ula
	);

	ula_s:		ula port map (
						seletor => operation_ula,
						entrada01 => entrada01_ula,
						entrada02 => entrada02_ula,
						saida_ula => saida_ula_s,
						c_bit => c_bit_out_ula,
						z_bit => z_bit_out_ula,
						n_bit => n_bit_out_ula
	);

	banco_reg_s:	banco_reg port map (
						clk => clk,
						rst => rst,
						data => saida_ula_s,
						read_data_1 => data_src,
						read_data_2 => entrada02_ula,
						read_reg_1 => end_src,
						read_reg_2 => end_reg_2,
						write_reg => end_dest,
						en_write => reg_wr_en
	);


	immediate_ext <= "11111111" & immediate when immediate(7)='1' else
					 "00000000" & immediate;

	saida_ula <= saida_ula_s;

	instr <= instr_s;

	enable_mux <= '1';
	zero <= "0000";

	--Barramentos(?) da RAM.
	ram_data_in <= saida_ula_s;






end architecture a_toplevel;