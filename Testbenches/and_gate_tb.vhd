library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_gate_tb is
end entity;

architecture sim of and_gate_tb is

	signal and_a : std_logic;
	signal and_b :std_logic;
	signal and_c : std_logic;
	
begin 

	i_andgate_tb : entity work.and_gate (bhv) port map( 
		and_a => and_a,
		and_b => and_b,
		and_c => and_c);

	process is
	begin
		wait for 10 ns;
		and_a <= '0';
		and_b <= '0';
		wait for 10 ns;
		and_a <= '0';
		and_b <= '1';
		wait for 10 ns;
		and_a <= '1';
		and_b <= '0';
		wait for 10 ns;
		and_a <= '1';
		and_b <= '1';
		wait;
	end process;
end architecture;