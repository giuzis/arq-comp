library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_tb is
end entity ;

architecture a_banco_reg_tb of banco_reg_tb is
	component banco_reg is
		port (
				data: 						in unsigned(15 downto 0); 	--Dado para write.
				read_data_1, read_data_2: 	out unsigned(15 downto 0); -- Read data 1 e 2
				clk: 						in std_logic; --Clock universal
				rst: 						in std_logic; --Reset universal
				read_reg_1: 				in unsigned(2 downto 0); -- Read register 1
				read_reg_2: 				in unsigned(2 downto 0); -- Read register 2
				write_reg:					in unsigned(2 downto 0); -- Write register
				en_write:					in std_logic  -- Enable write
		);
	end component banco_reg;

	signal clk,rst,en_write: std_logic;
	signal write_reg,read_reg_1,read_reg_2: unsigned(2 downto 0);
	signal data,read_data_1,read_data_2: unsigned(15 downto 0) ;

begin
	uut: banco_reg port map (
		data=>data,
		read_data_1=>read_data_1,
		read_data_2=>read_data_2,
		clk=>clk,
		rst=>rst,
		read_reg_1=>read_reg_1,
		read_reg_2=>read_reg_2,
		write_reg=>write_reg,
		en_write=>en_write
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
	end process ;
	
	process
	begin
		wait for 200 ns;
		en_write<='1' ;
		read_reg_1<="001";
		read_reg_2<="001";
		data<="1111000011110000";
		write_reg<="001";
		wait for 150 ns;
		read_reg_2<="001";
		write_reg<="010";
		wait for 150 ns;
		read_reg_2<="010";
		write_reg<="011";
		wait for 150 ns;
		read_reg_2<="011";
		write_reg<="100";
		wait for 150 ns;
		read_reg_2<="100";
		write_reg<="101";
		wait for 150 ns;
		read_reg_2<="101";
		write_reg<="110";
		wait for 150 ns;
		read_reg_2<="110";
		write_reg<="111";
		wait for 150 ns;
		read_reg_2<="111";
		write_reg<="000";
		wait for 150 ns;
		read_reg_2<="000";
		wait for 150 ns;
		en_write <= '0';
		data<="1111111111110000";
		write_reg <= "001";
		wait for 150 ns;
		read_reg_2<="001";
		
		wait for 150 ns;
		read_reg_1<="000";
		read_reg_2<="000";

		wait;
	end process;
end architecture ;
