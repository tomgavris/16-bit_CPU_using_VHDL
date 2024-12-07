library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

-- works fine

architecture sim of control_unit_tb is

	constant ClockFreq : integer := 100e6;
	constant ClockPer : time := 1000 ms / ClockFreq;
	signal opcode :  std_logic_vector(3 downto 0) := "0000";
	signal clk : std_logic := '1';
	signal rst : std_logic;
	signal wre_pc, rde_ins_c, bre, wre_ins_r, wre_reg, mA, wre_da_c, rde_da_c, mE : std_logic;
	signal mB, mD : std_logic_vector(1 downto 0);
	signal alu_sel: std_logic_vector(3 downto 0);
begin 
	
	i_control_unit : entity work.control_unit(bhv) port map(
		opcode => opcode,
		clk => clk,
		rst => rst,
		wre_pc => wre_pc,
		rde_ins_c => rde_ins_c,
		bre => bre,
		wre_ins_r => wre_ins_r,
		wre_reg => wre_reg,
		mA => mA,
		wre_da_c => wre_da_c,
		rde_da_c => rde_da_c,
		mE => mE,
		mD => mD,
		mB => mB,
		alu_sel => alu_sel);
		
		clk <= not clk after ClockPer /2;
		
	process is
	begin 
		wait for 30 ns;
		opcode <= "0001";
		wait for 40 ns;
		opcode <= "0010";
		wait for 40 ns;
		opcode <= "0011";
		wait for 40 ns;
		opcode <= "0100";
		wait for 40 ns;
		opcode <= "0101";
		wait for 40 ns;
		opcode <= "0110";
		wait for 40 ns;
		opcode <= "0111";
		wait for 40 ns;
		opcode <= "1000";
		wait for 40 ns;
		opcode <= "1001";
		wait for 40 ns;
		opcode <= "1010";
		wait for 40 ns;
		opcode <= "1011";
		wait for 40 ns;
		opcode <= "1100";
		wait for 30	 ns;
		opcode <= "1000";
		wait for 10 ns;
		rst <= '1';
		wait;
	end process;
end architecture;