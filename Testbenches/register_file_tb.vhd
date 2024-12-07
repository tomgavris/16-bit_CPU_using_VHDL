library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file_tb is
end entity;

--needs some data inside the register file for the tb to run

architecture sim of register_file_tb is

	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	signal inrf, outr1, outr2 : std_logic_vector(15 downto 0);
	signal adr1, adr2, adr3 : std_logic_vector(3 downto 0);
	signal clk : std_logic := '1';
	signal wre_reg : std_logic;

begin 
	
	i_register_file : entity work.register_file(bhv) port map(
		inrf => inrf,
		adr1 => adr1,
		adr2 => adr2,
		adr3 => adr3,
		outr1 => outr1,
		outr2 => outr2,
		clk => clk,
		wre_reg => wre_reg);
		
	clk <= not clk after ClockPer/2;
	
	process is 
	begin
		wait for 10 ns;
		wre_reg <= '1';
		adr3 <= x"1";
		inrf <= x"AD58";
		wait for 10 ns;
		wre_reg <= '1';
		adr3 <= x"2";
		inrf <= x"9C8F";
		wait for 10 ns;
		wre_reg <= '0';
		adr1 <= x"2";
		adr2 <= x"1";
		wait for 10 ns;
		wre_reg <= '1';
		adr3 <= x"F";
		inrf <= x"8541";
		wait for 10 ns;
		wre_reg <= '1';
		adr3 <= x"A";
		inrf <= x"25BC";
		wait for 10 ns;
		wre_reg <= '0';
		adr1 <= x"A";
		adr2 <= x"F";
		wait;
	end process;
end architecture;