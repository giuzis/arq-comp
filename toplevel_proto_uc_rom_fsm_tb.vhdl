library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_proto_uc_rom_fsm_tb is
end entity;

architecture a_toplevel_proto_uc_rom_fsm_tb of toplevel_proto_uc_rom_fsm_tb is
	component toplevel_proto_uc_rom_fsm is
		port(
			clk : in std_logic;
			rst : in std_logic;
			instr : out unsigned(14 downto 0)
		);
	end component toplevel_proto_uc_rom_fsm;

	signal clk, rst: std_logic;
	signal instr: unsigned(14 downto 0);

	begin

	 uut: toplevel_proto_uc_rom_fsm port map(clk => clk, rst => rst, instr => instr);

	 process -- sinal de clock
	 begin
		 clk <= '0';
		 wait for 50 ns;
		 clk <= '1';
		 wait for 50 ns;
	 end process;

	 process -- sinal de reset
		 begin
		 rst <= '1';
		 wait for 100 ns;
		 rst <= '0';
		 wait;
	 end process;

end architecture a_toplevel_proto_uc_rom_fsm_tb;