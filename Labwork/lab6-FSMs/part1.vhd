LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part1 IS
 PORT (SW : in std_logic_vector (17 downto 16);
		KEY : in std_logic_vector (0 downto 0);
		LEDG : out std_logic_vector (7 downto 0);
		LEDR : out std_logic_vector (17 downto 0)
		);
		
END part1;
ARCHITECTURE Behavior OF part1 IS
	SIGNAL y_present, y_next : std_logic_vector(8 downto 0) ;
	SIGNAL Reset, Clock : std_logic ;

	BEGIN
	PROCESS (KEY(0), SW(16))
	BEGIN
	--Reset <=SW(16);
	--Clock <=KEY(0);

	IF SW(16) = '1' THEN
		y_present <= "000000000" ; -- resets to state A
	ELSIF (KEY(0)'EVENT AND KEY(0) = '1') THEN
		y_present <= y_next ;
	END IF ;
	
	END PROCESS ;

	y_next(0) <= '1';
	y_next(1) <= (NOT(y_present(0)) AND SW(17)) OR (y_present(4) AND SW(17)) OR (y_present(8) AND SW(17));
	y_next(2) <= y_present(1) AND SW(17);
	y_next(3) <= y_present(2) AND SW(17);
	y_next(4) <= y_present(3) AND SW(17);
	y_next(5) <= (y_present(4) AND NOT(SW(17))) OR (NOT(y_present(0)) AND NOT(SW(17))) OR (y_present(8) AND NOT(SW(17)));
	y_next(6) <= (y_present(1) OR y_present(5)) AND NOT (SW(17));
	y_next(7) <= (y_present(6) OR y_present(2)) AND NOT (SW(17));
	y_next(8) <= (y_present(7) OR y_present(3)) AND NOT (SW(17));
	
	LEDR (8 downto 0) <= y_present;
	LEDR (17 downto 10) <= (OTHERS => y_present(8)); --state 8
	LEDG <= (OTHERS => y_present(4)); --state 4
	
	
END Behavior;