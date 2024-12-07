library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(
	
	a       : in std_logic_vector (15 downto 0); -- opperand a
	b       : in std_logic_vector (15 downto 0); -- opperand b
	alu_sel : in std_logic_vector (3 downto 0); 
	sh : in std_logic_vector(2 downto 0);
	c  : out std_logic_vector (15 downto 0); -- output
	zer     : out std_logic); -- result equals 0
end entity;

architecture bhv of alu is

signal mul_sig : std_logic_vector(31 downto 0);

begin
	
	process(a,b,sh, mul_sig, alu_sel) is
	begin
		
		if alu_sel = "0000" then
			c <= a and b;
		elsif alu_sel = "0001" then
			c <= a or b;
		elsif alu_sel = "0010" then
			c <= a xor b;
		elsif alu_sel = "0011" then
			c <=  std_logic_vector(unsigned(a) + unsigned(b)); 
		elsif alu_sel = "0100" then
			c <=  std_logic_vector(unsigned(a) - unsigned(b));
			if a = b then
				zer <= '1';
			else 
				zer <= '0';
			end if;
		elsif alu_sel = "0101" then -- logical left shift
			c <= std_logic_vector(shift_left(unsigned(a), to_integer(unsigned(sh))));
		elsif alu_sel = "0110" then -- logical right shift
			c <= std_logic_vector(shift_right(unsigned(a), to_integer(unsigned(sh))));
		elsif alu_sel = "0111" then 
			mul_sig <=  std_logic_vector(unsigned(a) * unsigned(b));
			c <= mul_sig(15 downto 0); 
		elsif alu_sel = "1000" then
			c <= not a;
		else 
			c <= (others =>'Z'); -- NULL?
		end if;
	end process;
end architecture;