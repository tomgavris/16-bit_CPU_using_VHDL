library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_cache is
	port(
		adri  : in std_logic_vector (15 downto 0); -- address input
		rde_inst   : in std_logic; -- read enable
		rom_o : out  std_logic_vector (15 downto 0)); -- rom's output
end entity;

architecture bhv of inst_cache is

	type rom_num is array(0 to 11) of std_logic_vector(15 downto 0); 
	signal rom1 : rom_num :=(	"1100000001010001", --LDI r1, 5
								"1100000010000010", --LDI r2, 8
								"0010000100100011", -- ADD r3,r1,r2
								"0100001100010100", -- AND r4,r3,r1
								"0001000101000010", -- BRE r1, r4 jump 2
								"1001010100110000", -- LOAD r5, r3
								"1011000100000000", --NOT r1
								"1100000000100110",--LDI r6, 2
								"1010001101100100", --MUL r4,r3,r6
								"0111011001000000", --SLL r6,2
								"0000001100100000"--STORE r3,r2			
							);
	
begin
	
	process (rde_inst, adri) is
	begin
		if rde_inst = '1' then 
		rom_o <= rom1(to_integer(unsigned(adri)));
		else
			rom_o <= (others => '0');
		end if;
	end process;
end architecture;	