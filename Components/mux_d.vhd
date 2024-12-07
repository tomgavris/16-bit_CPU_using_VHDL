library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_d is
	port( 
		sig1md : in std_logic_vector(15 downto 0);
		sig2md : in std_logic_vector(15 downto 0);	
		sig3md : in std_logic_vector(15 downto 0);	
	
		outputmd : out std_logic_vector(15 downto 0);

		mD : in std_logic_vector(1 downto 0)); 
end entity;

architecture bhv of mux_d is
begin

	process(mD, sig1md, sig2md, sig3md) is 
		begin
			case mD is
				when "00" =>
					outputmd <= sig1md;
				when "01" =>
					outputmd <= sig2md;
				when  "10" =>
					outputmd <= sig3md;
				when others =>
					outputmd <= (others => 'X');
			end case;
			
	end process;
	
end architecture;