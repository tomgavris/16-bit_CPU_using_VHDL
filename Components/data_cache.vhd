library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_cache is
	port(
	datai : in std_logic_vector(15 downto 0); -- data that is input to the cachce in order to be stored
	ram_add  : in std_logic_vector(15 downto 0); -- address input
	clk   : in std_logic;
	rde_da_c   : in std_logic; --read enable
	wre_da_c   : in std_logic;--write enable
	ram_out : out std_logic_vector(15 downto 0));
end entity;

architecture bhv of data_cache is 

type data_mem is array(0 to 15) of std_logic_vector(15 downto 0);
signal mem : data_mem;

begin 

	process(rde_da_c, wre_da_c, datai, clk) is 
	begin
		if rising_edge(clk) then 
			if wre_da_c = '1' then 
				mem(to_integer(unsigned(ram_add))) <= datai;				
			elsif rde_da_c = '1' then 
				ram_out <= mem(to_integer(unsigned(ram_add)));
			end if;
		end if;
	end process;
end architecture;