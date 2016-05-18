LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Tlatch IS
 PORT (Clk, enable, reset : in std_logic;
		Q : out std_logic);
		
END Tlatch;

ARCHITECTURE behaviour OF Tlatch IS

signal T: STD_LOGIC;
ATTRIBUTE keep:boolean;
ATTRIBUTE keep of T_q, T_qnot, D : SIGNAL IS true;


BEGIN
process (Clk, reset)
begin
	if(reset = '1') then
		t <= '0';
		elsif (Clk event and Clk = '1') then
			if(enable = '1') then
				t<= not (t);
			end if;
		end if;
end process;
Q <= Qnot;


end
