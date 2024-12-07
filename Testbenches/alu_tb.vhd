library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- SIMULATION HAS BEEN COMPLETED
-- SOMETHING NEEDS TO BE DONE ABOUT THE MULTIPLICATION PROCESS 

entity alu_tb is
end entity;

architecture sim of alu_tb is

	signal a : std_logic_vector(15 downto 0) := x"0011";
	signal b : std_logic_vector(15 downto 0) := x"0010"; --0000 0000 0001 0000
	signal c  : std_logic_vector (15 downto 0);
	signal zer : std_logic;
	signal sh : std_logic_vector(2 downto 0);
	signal alu_sel : std_logic_vector(3 downto 0) := "0000";
	signal mul_sig : std_logic_vector(31 downto 0);
	
begin 
	
	i_alu_tb : entity work.alu(bhv) port map(
		a => a,
		b => b,
		c => c,
		zer => zer,
		sh => sh,
		alu_sel => alu_sel);

	process is
	begin 
			-- 0000 is and
			wait for 10 ns;
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0001 or
			wait for 10 ns;
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0010 xor
			wait for 10 ns;
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0011 addition
			wait for 10 ns;
			a <= x"0010";
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0100 subtraction
			wait for 10 ns;
			a <= x"0001";
			sh <= "011";
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0101 lls
			wait for 10 ns;
			a <= x"0A20";
			sh <= "010";
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0110 lrs
			wait for 10 ns;
			a <= x"0010";
			b <= x"0012";
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --0111 mull
			wait for 10 ns;
			alu_sel <= std_logic_vector(unsigned(alu_sel) + 1); --1000 not
			wait;
	end process;
end architecture;