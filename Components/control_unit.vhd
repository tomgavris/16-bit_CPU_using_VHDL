library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
	port(
		opcode : in std_logic_vector(3 downto 0);
		clk, rst    : in std_logic;
		wre_pc, rde_ins_c, bre, wre_ins_r, wre_reg, mA, wre_da_c, rde_da_c, mE, ext_sel : out std_logic;
		mB, mD     : out std_logic_vector(1 downto 0);
		alu_sel: out std_logic_vector(3 downto 0)
		);
end entity;

-- wre = write enable, rde = read enable
-- pc = programm counter, inst_c = instructioms cache, da_c = data cache, mA/mB = mux A/B, mED: mux for E and D  
-- bre = branch 

architecture bhv of control_unit is

type state is (prwtos_kuk, deuteros_kuk, tritos_kuk, tetartos_kuk);
signal cur_state, next_state : state;

begin 
	process(clk) is
	begin
		if rst = '1' then 
			cur_state <= prwtos_kuk;
		elsif rising_edge(clk) then 
			cur_state <= next_state;
		end if;
	end process;


	process(cur_state, opcode) is
	begin
		case cur_state is
			when prwtos_kuk =>
				wre_pc <= '1';
				rde_ins_c <= '1';
				bre <= '0';
				wre_ins_r <= '1';
				wre_reg <= '0';
				mA <= '0';
				mB <= "01";
				alu_sel <= "0011"; -- to alu_sel είναι 011 γιατί πρέπει να κάνει προσθεση ΜΠ+1
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= deuteros_kuk;
				
			when deuteros_kuk =>
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '0';
				mB <= "10";
				alu_sel <= "0011"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tritos_kuk;
				
			when tritos_kuk =>
				if opcode = "0000" then -- store
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= 'X';
				mB <= "XX";
				alu_sel <= "XXXX"; 
				rde_da_c <= '0';
				wre_da_c <= '1';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= prwtos_kuk;
				elsif opcode = "0001" then -- bre
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '1';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '0';
				mA <= '0';
				mB <= "10";
				alu_sel <= "0011"; -- to alu_sel είναι 011 γιατί πρέπει να κάνει προσθεση ΜΠ+d
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= '0';
				next_state <= tetartos_kuk;	
				elsif opcode = "0010" then -- add
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0011"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "0011" then -- sub
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0100"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "0100" then -- and
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0000"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "0101" then -- or
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0001"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "0110" then -- xor
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0010"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "0111" then -- left shift
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0101"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "1000" then -- right shift
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0110"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				elsif opcode = "1001" then -- load
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "XXXX"; 
				rde_da_c <= '1';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				
				elsif opcode = "1010" then -- mull
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0111"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	

				elsif opcode = "1011" then -- not
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "1000"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= 'X';
				next_state <= tetartos_kuk;	
				
				elsif opcode = "1100" then -- ldi
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '1';
				mA <= 'X';
				mB <= "XX";
				alu_sel <= "XXXX"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= '1';
				mD <= "10";
				ext_sel <= '1';
				next_state <= prwtos_kuk;	
				end if;
				
			when tetartos_kuk =>
				if opcode = "1001" then -- load
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '1';
				mA <= 'X';
				mB <= "XX";
				alu_sel <= "XXXX"; 
				rde_da_c <= '1';
				wre_da_c <= '0';
				mE <= '0';
				mD <= "00";
				next_state <= prwtos_kuk;
				elsif opcode = "0001" then -- bre
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '1';
				wre_ins_r <= '0';
				wre_reg <= '0';
				mA <= '1';
				mB <= "00";
				alu_sel <= "0100";
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= 'X';
				mD <= "XX";
				ext_sel <= '0';
				next_state <= prwtos_kuk;	
				elsif opcode = "0010" or opcode = "0011" or opcode = "0100" or opcode = "0101" or opcode = "0110" or opcode = "1001" or opcode = "1010" then 
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '1';
				mA <= 'X';
				mB <= "XX";
				alu_sel <= "XXXX"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= '1';
				mD <= "01";
				next_state <= prwtos_kuk;
				elsif opcode = "1011" or opcode = "0111" or opcode = "1000" then --SSL, SLR , NOT 
				wre_pc <= '0';
				rde_ins_c <= '0';
				bre <= '0';
				wre_ins_r <= '0';
				wre_reg <= '1';
				mA <= 'X';
				mB <= "XX";
				alu_sel <= "XXXX"; 
				rde_da_c <= '0';
				wre_da_c <= '0';
				mE <= '0';
				mD <= "01";
				next_state <= prwtos_kuk;
				end if;
			when others => null;
		end case;
	end process;
end architecture;
