library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_reg_tb is
end entity;

architecture sim of alu_reg_tb is

	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	signal inreg : std_logic_vector (15 downto 0)  := x"1D0A";
	signal clk   : std_logic := '1';
	signal ralu_out  : std_logic_vector (15 downto 0);

begin 
	
	i_alu_reg : entity work.alu_reg(bhv) port map(
		inreg => inreg,
		clk => clk,
		ralu_out => ralu_out);
	
	clk <= not clk after ClockPer / 2;
	
	process is 
	begin 
		wait for 10 ns;
		inreg <= x"2034";
		wait for 10 ns;
		inreg <= x"ADF1";
		wait for 10 ns;
		inreg <= x"8901";
		wait for 10 ns;
		inreg <= x"4A5F";
		wait for 10 ns;
		inreg <= x"56AC";
		wait;
	end process;
end architecture;