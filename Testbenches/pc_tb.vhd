library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;

architecture sim of pc_tb is

	signal pcin :  std_logic_vector (15 downto 0) := x"0000"; -- programm counter input
	signal pcout :  std_logic_vector (15 downto 0); -- instruction cache adress
	signal wrepc :  std_logic; --write enable signal
	signal clk :  std_logic :='1';
	signal rst :  std_logic;
	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	
begin 

	i_pctb : entity work.prog_count(bhv) port map(
		pcin => pcin,
		pcout => pcout,
		wrepc => wrepc,
		clk => clk,
		rst => rst);

clk <= not clk after ClockPer/2;

	process is
	begin
		wait for 10 ns;
		wrepc <= '1';
		pcin <= std_logic_vector(unsigned(pcin ) + 1);
		wait for 10 ns;
		wrepc <= '1';
		pcin <= std_logic_vector(unsigned(pcin ) + 1);
		wait for 10 ns;
		wrepc <= '1';
		pcin <= std_logic_vector(unsigned(pcin ) + 1);
		wait for 10 ns;
		wrepc <= '1';
		pcin <= std_logic_vector(unsigned(pcin ) + 1);
		wait for 10 ns;
		wrepc <= '0';
		rst <= '1';
		wait;	
	end process;
end architecture;