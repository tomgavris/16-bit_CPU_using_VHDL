library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_reg is
	port(
		inreg : in std_logic_vector (15 downto 0); --register's input
		clk   : in std_logic;
		ralu_out  : out std_logic_vector (15 downto 0) --reigster's output
		);

end entity;

architecture bhv of alu_reg is
begin
	
	process(clk) is 
	begin 
		if rising_edge(clk) then 
			ralu_out <= inreg;
		end if;
	end process;
end architecture;