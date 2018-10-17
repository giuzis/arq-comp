library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_proto_uc_tb is
end entity;

architecture a_rom_proto_uc_tb of rom_proto_uc_tb is
	component rom_proto_uc is
		port (
			clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			dado : out unsigned(14 downto 0)
		);
	end component rom_proto_uc;

	signal clk, rst, wr_en: std_logic;
	signal dado: unsigned(14 downto 0);

	begin

	 uut: rom_proto_uc port map(clk => clk, rst => rst, wr_en => wr_en, dado => dado);

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
		 wr_en <= '0';
		 wait for 100 ns;
		 rst <= '0';
		 wr_en <= '1';
		 wait;
	 end process;

end architecture a_rom_proto_uc_tb;