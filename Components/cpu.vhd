library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu is
	port( 
		cpu_clk : in std_logic;
		reset : in std_logic);
end entity;

architecture bhv of cpu is


	signal wre_pc_c, ext_sel_c, rde_ins_cc, bre_c, wre_ins_rc, wre_reg_c, mA_c, wre_da_cc, rde_da_cc, mE_c,clk, zer_c, rst_c, and_c_c, ww_pc_c : std_logic;
	signal	mB_c, mD_c : std_logic_vector(1 downto 0);
	signal  sh_c : std_logic_vector(2 downto 0);
	signal adr1_c, adr2_c, adr3_c, opcode_c,alu_sel_c, add3_c  : std_logic_vector (3 downto 0);
	signal num_c : std_logic_vector(7 downto 0);
	signal pc_in, adri_c, i_ir_c, outr1_c, outr2_c, a_c, b_c, c_c, inrf_c, f_c, ralu_out_c, ram_out_c : std_logic_vector (15 downto 0); -- programm counter input
	
	
begin 
	
	pc_cpu : entity work.prog_count(bhv) port map(
		clk => cpu_clk,
		pcin => pc_in,
		wrepc => ww_pc_c,
		rst => rst_c,
		pcout => adri_c);
	
	inst_cache_cpu : entity work.inst_cache(bhv) port map(
		adri => adri_c,
		rde_inst => rde_ins_cc,
		rom_o => i_ir_c);
	
	inst_reg_cpu : entity work.inst_reg(bhv) port map(
		clk => cpu_clk,
		wre_inst_r => wre_ins_rc,
		i_ir => i_ir_c,
		add1 => adr1_c,
		add2 => adr2_c,
		add3 => add3_c,
		sh => sh_c,
		num => num_c,
		opcode => opcode_c);
		
	mux_e_cpu : entity work.mux_e(bhv) port map(
		sig1me => adr1_c,
		sig2me => add3_c,
		outputme => adr3_c,
		mE => mE_c);
		
	register_file_cpu : entity work.register_file(bhv) port map(
		clk => cpu_clk,
		wre_reg => wre_reg_c,
		adr1 => adr1_c,
		adr2 => adr2_c,
		adr3 => adr3_c,
		inrf => inrf_c,
		outr1 => outr1_c,
		outr2 => outr2_c);
		
	mux_a_cpu : entity work.mux_a(bhv) port map(
		sig1ma => adri_c,
		sig2ma => outr1_c,
		outputma => a_c,
		mA => mA_c);
		
	mux_b_cpu : entity work.mux_b(bhv) port map(
		sig1mb => outr2_c,
		sig3mb => f_c,
		outputmb => b_c,
		mB => mB_c);
		
		
	sign_ext_cpu : entity work.sign_ext(bhv) port map(
		d => add3_c,
		num_s =>num_c,
		ext_sel => ext_sel_c,
		f => f_c);
	
	alu_cpu : entity work.alu(bhv) port map(
		a => a_c,
		b => b_c,
		alu_sel => alu_sel_c,
		c => c_c,
		sh => sh_c,
		zer => zer_c);
	
	alu_reg_cpu : entity work.alu_reg(bhv) port map(
		clk => cpu_clk,
		inreg => c_c,
		ralu_out => ralu_out_c);
	
	control_unit_cpu : entity work.control_unit(bhv) port map(
		clk => cpu_clk,
		opcode => opcode_c,
		rst => rst_c,
		wre_pc => wre_pc_c,
		rde_ins_c => rde_ins_cc,
		bre => bre_c,
		wre_ins_r => wre_ins_rc,
		wre_reg => wre_reg_c ,
		mA => mA_c,
		wre_da_c => wre_da_cc,
		rde_da_c => rde_da_cc,
		mE => mE_c,
		ext_sel => ext_sel_c,
		mD => mD_c,
		mB => mB_c,
		alu_sel => alu_sel_c);
	
	data_cache : entity work.data_cache(bhv) port map(
		clk => cpu_clk,
		datai => outr1_c,
		ram_add => outr2_c,
		ram_out => ram_out_c,
		wre_da_c => wre_da_cc,
		rde_da_c => rde_da_cc);
	
	mux_c_cpu : entity work.mux_c(bhv) port map(
		sig1mc => c_c,
		sig2mc => ralu_out_c,
		outputmc => pc_in,
		mC => and_c_c);
	
	mux_d_cpu : entity work.mux_d(bhv) port map(
		sig1md => ram_out_c,
		sig2md => ralu_out_c,
		sig3md => f_c,
		outputmd => inrf_c,
		mD => mD_c);
			
	and_gate_cpu : entity work.and_gate(bhv) port map(
		and_a => bre_c,
		and_b =>zer_c,
		and_c => and_c_c);
		
	or_gate_cpu : entity work.or_gate(bhv) port map(
		or_a => wre_pc_c,
		or_b => and_c_c,
		or_c => ww_pc_c);
end architecture;