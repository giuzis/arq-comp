library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
	 port(   clk : in std_logic;
			 rst : in std_logic;
			 estado: out std_logic
			--wr_en : in std_logic;
			--data_in : in unsigned(15 downto 0);
			--data_out : out unsigned(15 downto 0)
	 );
end entity;

architecture a_fsm of fsm is
 	signal estado_s: std_logic;
	begin
			process(clk,rst) -- acionado se houver mudança em clk ou rst
			 begin
				 if rst='1' then
				 estado_s <= '0';
				 elsif rising_edge(clk) then -- Se estiver na subida de um clk, então muda estado.
				 estado_s <= not estado_s;
				 end if;
			end process;
			estado <= estado_s;
end architecture;
