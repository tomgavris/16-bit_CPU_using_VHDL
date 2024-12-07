library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_reg_tb is
end entity;

-- works fine

architecture sim of inst_reg_tb is

	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	signal i_ir : std_logic_vector(15 downto 0) := x"0001";
	signal add1, add2, add3, opcode : std_logic_vector(3 downto 0);
	signal clk : std_logic := '1';
	signal wre_inst_r : std_logic;
	signal sh : std_logic_vector(2 downto 0);
	signal d : std_logic_vector(3 downto 0);

begin 
	
	i_inst_reg : entity work.inst_reg(bhv) port map(
		i_ir => i_ir,
		add1 => add1,
		add2 => add2,
		add3 => add3,
		opcode => opcode,
		clk => clk,
		d => d,
		sh => sh,
		wre_inst_r => wre_inst_r);
		
	clk <= not clk after ClockPer/2;
		
	process is 
	begin
		wait for 10 ns;
		wre_inst_r <= '1';
		i_ir <= x"0A01";
		wait for 20 ns;
		i_ir <= x"B021";
		wait for 20 ns;
		i_ir <= std_logic_vector(unsigned(i_ir) + 1);
		wait for 20 ns;
		i_ir <= std_logic_vector(unsigned(i_ir) + 1);
		wait for 20 ns;
		wre_inst_r <= '0';
		i_ir <= std_logic_vector(unsigned(i_ir) + 1);
		wait for 20 ns;
		i_ir <= std_logic_vector(unsigned(i_ir) + 1);
		wait;
	end process;
end architecture;