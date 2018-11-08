library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_flags is
 port( 
	 clk : in std_logic;
	 rst : in std_logic;
	 wr_en : in std_logic;
	 c_bit_in, n_bit_in, z_bit_in : in std_logic;
	 c_bit_out, n_bit_out, z_bit_out : out std_logic
 );
end entity;


architecture a_reg_flags of reg_flags is
	signal registro_c, registro_z, registro_n: std_logic;
begin
 	process(clk,rst,wr_en) -- acionado se houver mudança em clk, rst ou wr_en

 	begin
 	if rst = '1' then
		registro_c <= '0';
		registro_n <= '0';
		registro_z <= '0';
 	elsif wr_en = '1' then
		if rising_edge(clk) then
			registro_c <= c_bit_in;
			registro_n <= n_bit_in;
			registro_z <= z_bit_in;
 	end if;
 	end if;
 	end process;

 	c_bit_out <= registro_c;
 	n_bit_out <= registro_n;
 	z_bit_out <= registro_z;

end architecture;