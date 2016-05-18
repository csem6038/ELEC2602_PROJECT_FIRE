LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Tlatch IS
 PORT (Clk, enable, reset : in std_logic;
		Q : out std_logic);
		
END Tlatch;

ARCHITECTURE behaviour OF Tlatch IS

SIGNAL t : STD_LOGIC;

BEGIN
process (Clk, reset)
begin
	if(reset = '1') then
		t <= '0';
		elsif (Clk'event and Clk = '1') then
			if(enable = '1') then
				t <= not (t);
			end if;
		end if;
end process;

Q <= t;

end;
