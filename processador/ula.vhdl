library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
			seletor: 				in unsigned(1 downto 0);
			entrada01, entrada02: 	in unsigned(15 downto 0);
			saida_ula: 				out unsigned(15 downto 0);
			n_bit, c_bit, z_bit: 	out std_logic
		);
end entity ula;

architecture a_ula of ula is

	signal entrada01_17, entrada02_17, soma_17: unsigned(16 downto 0);
	signal soma_16: unsigned(15 downto 0);

begin
	entrada01_17 <= '0' & entrada01;
	entrada02_17 <= '0' & entrada02;
	soma_17 	<=	entrada01_17 + entrada02_17 						WHEN seletor="00" else
					entrada02_17 - entrada01_17 						WHEN seletor="01" else 
					entrada01_17(7 downto 0) * entrada02_17(7 downto 0)	WHEN seletor="10" else
					entrada01_17 										WHEN seletor="11" and entrada01_17 > entrada02_17 else
					entrada02_17 										WHEN seletor="11" and entrada01_17 < entrada02_17 else
					"00000000000000000";

	soma_16 <= 		entrada01 + entrada02 							WHEN seletor="00" else
					entrada02 - entrada01 							WHEN seletor="01" else 
					entrada01(7 downto 0) * entrada02(7 downto 0)	WHEN seletor="10" else
					entrada01 										WHEN seletor="11" and entrada01 > entrada02 else
					entrada02 										WHEN seletor="11" and entrada01 < entrada02 else
					"0000000000000000";

	n_bit <=	 	'1' 											WHEN soma_16(15) = '1' else 
					'0';

	z_bit <= 		'1'												WHEN soma_16 = "0000000000000000" else
					'0';

	-- verificar se isso faz sentido
	c_bit <= 		soma_17(16);

	saida_ula <= soma_16;

end architecture;