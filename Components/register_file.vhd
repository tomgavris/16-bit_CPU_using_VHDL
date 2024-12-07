library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port(
		adr1  : in std_logic_vector (3 downto 0); -- address no.1
		adr2  : in std_logic_vector (3 downto 0);
		adr3  : in std_logic_vector (3 downto 0);
		inrf : in std_logic_vector (15 downto 0); -- data that will be stored to the register
		wre_reg   : in std_logic; -- write enable
		clk   : in std_logic;
		outr1  :  out std_logic_vector (15 downto 0); -- data stored inside register with address adr1
		outr2  :  out std_logic_vector (15 downto 0));
end entity;

architecture bhv of register_file is 

type registerfile is array(0 to 15) of std_logic_vector(15 downto 0);
signal reg : registerfile;


begin

	process(clk) is 
	begin 
		if rising_edge(clk) then 
			outr1 <= reg(to_integer((unsigned(adr1))));
			outr2 <= reg(to_integer((unsigned(adr2))));
				if wre_reg = '1' then 
					reg(to_integer(unsigned(adr3))) <= inrf;
				end if;
		end if;
	end process;
end architecture;