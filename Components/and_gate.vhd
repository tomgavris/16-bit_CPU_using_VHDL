library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_gate is
	port(
		and_a : in std_logic;
		and_b : in std_logic;
		and_c : out std_logic);
end entity;

architecture bhv of and_gate is

begin
	process(and_a, and_b) is 
	begin
		and_c <= and_a and and_b;
	end process;
end architecture;