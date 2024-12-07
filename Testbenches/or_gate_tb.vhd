library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_gate_tb is
end entity;

architecture sim of or_gate_tb is

	signal or_a : std_logic;
	signal or_b :std_logic;
	signal or_c : std_logic;
	
begin 

	i_orgate_tb : entity work.or_gate (bhv) port map( 
		or_a => or_a,
		or_b => or_b,
		or_c => or_c);

	process is
	begin
		wait for 10 ns;
		or_a <= '0';
		or_b <= '0';
		wait for 10 ns;
		or_a <= '0';
		or_b <= '1';
		wait for 10 ns;
		or_a <= '1';
		or_b <= '0';
		wait for 10 ns;
		or_a <= '1';
		or_b <= '1';
		wait;
	end process;
end architecture;