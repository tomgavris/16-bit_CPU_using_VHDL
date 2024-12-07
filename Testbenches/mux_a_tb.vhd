library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_a_tb is
end entity;

architecture sim of mux_a_tb is

	signal sig1ma : std_logic_vector(15 downto 0) := x"2456";
	signal sig2ma : std_logic_vector(15 downto 0) := x"897A";	
	signal outputma : std_logic_vector(15 downto 0);
	signal mA : std_logic;

begin
	
	i_muxa : entity work.mux_a(bhv) port map(
	sig1ma => sig1ma,
	sig2ma => sig2ma,
	outputma => outputma,
	mA => mA);
	
	process is
	begin
		wait for 10 ns;
		mA <= '1';
		wait for 10 ns;
		mA <= '0';
		wait for 10 ns;
		sig1ma <= x"567B";
		sig2ma <= x"ABCD";
		wait for 10 ns;
		mA <= '1';
		wait;
	end process;
end architecture;