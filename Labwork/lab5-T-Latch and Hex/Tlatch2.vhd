LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_signed.all; 

ENTITY Tlatch2 IS
 PORT (Clk, enable, reset : in std_logic;
		Q : out std_logic);
		
END Tlatch2;

ARCHITECTURE behaviour OF Tlatch2 IS

SIGNAL t : STD_LOGIC;

BEGIN
PROCESS(Clk, reset)
BEGIN
	IF reset = '1' then
		Q <= (others => '0');
	ELSIF (clk'event AND clk='1' AND enable='1') then
		Q <= Q+1;
	END IF;
	count <= Q;
END PROCESS; 

Q <= t;

end;
