library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_tb is
end entity;

architecture sim of cpu_tb is

	signal cpu_clk : std_logic := '1';
	signal reset : std_logic;
	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	
begin
	i_cpu : entity work.cpu(bhv) port map(
		cpu_clk => cpu_clk,
		reset => reset);
		
	cpu_clk <= not cpu_clk after ClockPer / 2;


end architecture;
