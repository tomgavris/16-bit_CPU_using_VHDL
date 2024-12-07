library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_ext_tb is
end entity;

-- works fine

architecture sim of sign_ext_tb is

	signal d : std_logic_vector(3 downto 0) := "0010";
	signal f : std_logic_vector(15 downto 0);
	signal ext_sel : std_logic;
	signal num_s :  std_logic_vector(7 downto 0) := x"AB";
	
begin 
	
	i_sign_ext : entity work.sign_ext(bhv) port map(
	d => d,
	ext_sel => ext_sel,
	num_s => num_s,
	f =>f);
	
	process is
	begin
		wait for 10 ns;
		ext_sel <= '1';
		num_s <= std_logic_vector(unsigned(num_s)+1);
		wait for 10 ns;
		num_s <= std_logic_vector(unsigned(num_s)+1);
		wait for 10 ns;
		ext_sel <= '0';
		d <= std_logic_vector(unsigned(d)+1);
		wait for 10 ns;
		d <= "1010";
		wait for 10 ns;
		d <= std_logic_vector(unsigned(d)+1);
		wait for 10 ns;
		d <= "1111";
		wait;
	end process;
end architecture;