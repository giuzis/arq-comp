library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg is
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
end entity banco_reg;

architecture a_banco_reg of banco_reg is
	component reg16bits is
		port (
			 	clk : 		in std_logic;
			 	rst : 		in std_logic;
			 	wr_en : 	in std_logic;
			 	data_in : 	in unsigned(15 downto 0);
			 	data_out :  out unsigned(15 downto 0)
			);
	end component reg16bits;

	--Sinais de saída para os 7 registradores (o 8 é o 0)
	signal out_01, out_02, out_03, out_04, out_05, out_06, out_07, out_08 : unsigned(15 downto 0);

	--Sinais de enable para os 7 registradores (o Zero não tem write)
	signal en_01, en_02, en_03, en_04, en_05, en_06, en_07: std_logic;

	begin
		reg1: reg16bits port map(data_in => data, wr_en => en_01, data_out => out_01, clk => clk, rst => rst);
		reg2: reg16bits port map(data_in => data, wr_en => en_02, data_out => out_02, clk => clk, rst => rst);
		reg3: reg16bits port map(data_in => data, wr_en => en_03, data_out => out_03, clk => clk, rst => rst);
		reg4: reg16bits port map(data_in => data, wr_en => en_04, data_out => out_04, clk => clk, rst => rst);
		reg5: reg16bits port map(data_in => data, wr_en => en_05, data_out => out_05, clk => clk, rst => rst);
		reg6: reg16bits port map(data_in => data, wr_en => en_06, data_out => out_06, clk => clk, rst => rst);
		reg7: reg16bits port map(data_in => data, wr_en => en_07, data_out => out_07, clk => clk, rst => rst);

		--Definindo READ no REG01 (enviado pela ULA) baseado no read_reg_1
		--000 Seleciona o registrador 0;
		read_data_1 <=  "0000000000000000" WHEN read_reg_1="0000" ELSE 
						out_01 WHEN read_reg_1="0001" ELSE 
						out_02 WHEN read_reg_1="0010" ELSE
						out_03 WHEN read_reg_1="0011" ELSE
						out_04 WHEN read_reg_1="0100" ELSE
						out_05 WHEN read_reg_1="0101" ELSE
						out_06 WHEN read_reg_1="0110" ELSE
						out_07 WHEN read_reg_1="0111" ELSE
						"0000000000000000";

		--Definindo READ no REG02 (enviado pela ULA) baseado no read_reg_2
		--000 Seleciona o registrador 0;
		read_data_2 <=  "0000000000000000" WHEN read_reg_2="0000" ELSE 
						out_01 WHEN read_reg_2="0001" ELSE 
						out_02 WHEN read_reg_2="0010" ELSE
						out_03 WHEN read_reg_2="0011" ELSE
						out_04 WHEN read_reg_2="0100" ELSE
						out_05 WHEN read_reg_2="0101" ELSE
						out_06 WHEN read_reg_2="0110" ELSE
						out_07 WHEN read_reg_2="0111" ELSE
						"0000000000000000";

		-- Aqueles troço lá dos enables
		en_01 <= '1' WHEN en_write='1' AND write_reg="0001" ELSE '0';
		en_02 <= '1' WHEN en_write='1' AND write_reg="0010" ELSE '0';
		en_03 <= '1' WHEN en_write='1' AND write_reg="0011" ELSE '0';
		en_04 <= '1' WHEN en_write='1' AND write_reg="0100" ELSE '0';
		en_05 <= '1' WHEN en_write='1' AND write_reg="0101" ELSE '0';
		en_06 <= '1' WHEN en_write='1' AND write_reg="0110" ELSE '0';
		en_07 <= '1' WHEN en_write='1' AND write_reg="0111" ELSE '0';


end architecture a_banco_reg;