library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_cache_tb is
end entity;

-- I NEED TO HAVE SOME DATA INSIDE THESE ADDRESSES IN ORDER TO HAVE RESULTS

architecture sim of inst_cache_tb is

	signal adri : std_logic_vector(15 downto 0) := x"0003";
	signal rom_o : std_logic_vector(15 downto 0);
	signal rde_inst : std_logic;

begin 
	
	i_inst_cache : entity work.inst_cache(bhv) port map(
		adri => adri,
		rom_o => rom_o,
		rde_inst => rde_inst);
		
	process is
	begin 
		wait for 10 ns;
		rde_inst <= '1';
		wait for 10 ns;
		adri <= x"000A";
		wait for 10 ns;
		adri <= x"0005";
		wait for 10 ns;
		rde_inst <= '0';
		adri <= x"0001";
		wait;
	end process;
end architecture;