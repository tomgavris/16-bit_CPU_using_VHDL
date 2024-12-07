library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_cache_tb is
end entity;

architecture sim of data_cache_tb is

	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	signal clk : std_logic :='1';
	signal datai :  std_logic_vector(15 downto 0); -- data that is input to the cachce in order to be stored
	signal ram_add  :  std_logic_vector(15 downto 0); -- address input
	signal rde_da_c   :  std_logic; --read enable
	signal wre_da_c   :  std_logic;--write enable
	signal ram_out :  std_logic_vector(15 downto 0);
	
begin

	i_data_cache : entity work.data_cache(bhv) port map(
		datai => datai,
		ram_add => ram_add,
		clk => clk, 
		rde_da_c => rde_da_c,
		wre_da_c => wre_da_c, 
		ram_out => ram_out);

	clk <= not clk after ClockPer/2;

	process is 
	begin
		wait for 10 ns;
		datai <= x"0020";
		ram_add <= x"0001";
		wre_da_c <= '1';
		wait for 10 ns;
		datai <= x"000A";
		ram_add <= x"0002";
		wre_da_c <= '1';
		wait for 10 ns;
		wre_da_c <= '0';
		ram_add <= x"0001";
		rde_da_c <= '1';
		wait for 10 ns;
		rde_da_c <= '0';
		datai <= x"00CB";
		ram_add <= x"0004";
		wre_da_c <= '1';
		wait for 10 ns;
		wre_da_c <= '0';
		ram_add <= x"0004";
		rde_da_c <= '1';
		wait;
	end process;


end architecture;