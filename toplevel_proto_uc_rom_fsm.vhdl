library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_proto_uc_rom_fsm is
	port(
			clk : in std_logic;
			rst : in std_logic;
			instr : out unsigned(14 downto 0)
		);
end entity;

architecture a_toplevel_proto_uc_rom_fsm of toplevel_proto_uc_rom_fsm is
	component proto_uc is
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_out : out unsigned(6 downto 0)
	 	);
	end component proto_uc;

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
	
	signal data_out_s, endereco_s: unsigned(6 downto 0);
	signal instr_s : unsigned(14 downto 0);
	signal estado_s, wr_en: std_logic;
	--signal opcode: unsigned;

begin

	proto_uc_s:	proto_uc port map (
						data_out => data_out_s,
						clk 	 => clk,
			 			rst 	 => rst,
						wr_en	 => wr_en
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

	endereco_s <= data_out_s when estado_s = '0';		-- faz a leitura da rom no estado 0
	instr <= instr_s;
	wr_en <= '0' when estado_s = '0' else -- liga a escrita no pc no estado 1
			 '1';


	
end architecture a_toplevel_proto_uc_rom_fsm;