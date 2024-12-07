library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_ext is
	port(
		d : in std_logic_vector(3 downto 0); --input for branch 
		num_s : in std_logic_vector(7 downto 0); --input for ldi
		ext_sel : in std_logic;
		f : out std_logic_vector(15 downto 0));
end entity;

architecture bhv of sign_ext is

begin
	process(d, num_s, ext_sel) is
	begin
		if ext_sel = '0' then
			f <= std_logic_vector(resize(unsigned(d), 16));
		elsif ext_sel ='1' then
			f <= std_logic_vector(resize(unsigned(num_s), 16));
		else 
			f <= (others => 'X');
		end if;
	end process;
end architecture;