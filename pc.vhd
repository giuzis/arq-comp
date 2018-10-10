library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	 port(   clk : in std_logic;
			 rst : in std_logic;
			 wr_en : in std_logic;
			 data_in : in unsigned(14 downto 0);
			 data_out : out unsigned(14 downto 0)
	 );
end entity;

architecture a_pc of pc is
 	signal registro: unsigned(14 downto 0);
	begin
			process(clk,rst,wr_en) -- acionado se houver mudança em clk, rst ou wr_en
			 begin
				 if rst='1' then -- manda 0 pro pc quando reseta.
				 registro <= "000000000000000";
				 elsif wr_en='1' then
				 if rising_edge(clk) then -- Se estiver na subida de um clk, então registra.
				 registro <= data_in; --manda o que tem na entrada pro registro.
				 end if;
				 end if;
				 end process;

		 data_out <= registro; -- conexao direta, fora do processo
end architecture;
