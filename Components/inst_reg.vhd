library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_reg is
	port(
		i_ir : in std_logic_vector (15 downto 0); -- input of the register
		wre_inst_r   : in std_logic; -- write enable
		add1  : out std_logic_vector (3 downto 0); --number of register 1
		add2  : out std_logic_vector (3 downto 0);
		add3  : out std_logic_vector (3 downto 0);
		opcode: out std_logic_vector (3  downto 0); --oparation code
		sh : out std_logic_vector(2 downto 0); --bits used for shift operation
		d : out std_logic_vector(3 downto 0); -- bits used for branch
		clk   : in std_logic; 
		num : out std_logic_vector(7 downto 0)-- bits used for ldi
		);

end entity;

architecture bhv of inst_reg is
begin
	
process(clk) is 
begin 
	if rising_edge(clk) and wre_inst_r = '1' then
			opcode <= i_ir(15 downto 12);
			add1 <= i_ir(11 downto 8);
			add2 <= i_ir(7 downto 4);
			add3 <= i_ir(3 downto 0);
			sh <= i_ir(7 downto 5);
			d <= i_ir(3 downto 0);
			num <= i_ir(11 downto 4);
	end if;
end process;
end architecture;