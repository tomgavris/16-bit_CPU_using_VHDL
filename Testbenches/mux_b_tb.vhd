library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_b_tb is
end entity;

architecture sim of mux_b_tb is

	signal sig1 : std_logic_vector(15 downto 0) := x"00AA";
	signal sig2 : std_logic_vector(15 downto 0) := x"00BB";
	signal sig3 : std_logic_vector(15 downto 0) := x"00CC";

	signal sel1 : std_logic_vector(1 downto 0) := "00";
	
	signal output1 : std_logic_vector(15 downto 0);
begin 
	
	i_mux_b : entity work.mux_b(bhv) port map(
	
		sig1mb => sig1,
		sig3mb => sig3,
		mB  => sel1,
		outputmb => output1);
	
	process is
	
		begin 
			wait for 10 ns;
			sel1 <= std_logic_vector(unsigned(sel1) + 1);
			wait for 10 ns;
			sel1 <= std_logic_vector(unsigned(sel1) + 1);
			wait for 10 ns;
			sel1 <= std_logic_vector(unsigned(sel1) + 1);
		wait;
		
	end process;
	
end architecture;