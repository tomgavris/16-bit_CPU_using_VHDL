library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prog_count is
	port(
		pcin : in std_logic_vector (15 downto 0); -- programm counter input
		pcout : out std_logic_vector (15 downto 0); -- instruction cache adress
		wrepc : in std_logic; --write enable signal
		clk : in std_logic;
		rst : in std_logic);
	
end entity;

architecture bhv of prog_count is
	
	signal pc : std_logic_vector (15 downto 0) := (others => '0'); -- setting pc to first adress
	
begin

		
	pcout <= pc;
	process(clk) is 
	begin 
		if rising_edge(clk) then 
			if wrepc = '1' then
				pc <= pcin;
			elsif rst ='1' then 
				pc <= (others => '0');
			end if;
			
		end if;
		
	end process;

	
end architecture;