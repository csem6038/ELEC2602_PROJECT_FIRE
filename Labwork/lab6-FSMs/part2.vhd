LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part2 IS
 PORT (SW : in std_logic_vector (17 downto 16);
		KEY : in std_logic_vector (0 downto 0);
		LEDG : out std_logic_vector (7 downto 0);
		LEDR : out std_logic_vector (17 downto 0)
		);
		
END part2;
ARCHITECTURE Behavior OF part2 IS
	SIGNAL Reset, Clock, K : std_logic ;
	 
	TYPE State_type IS (B, C, D, E, F, G, H, I, A);
	SIGNAL Y_present, Y_next : State_type;
	
	BEGIN
	PROCESS (Y_present) -- state table
	BEGIN
	K <= SW(17);
	Reset <= SW(16);
	Clock <= KEY(0);
	LEDG <= (OTHERS => '0'); --state 4	
	LEDR (17 downto 10) <= (OTHERS => '0');

	IF SW(16) = '1' THEN
		LEDR (8 downto 0) <= "000000000" ; -- resets to state A
		Y_present <= A;
	ELSIF (KEY(0)'EVENT AND KEY(0) = '1') THEN
		Y_present <= Y_next ;
		
	END IF ;
	
		CASE Y_present IS
			WHEN A =>
				IF K='1' THEN
					Y_next <= B;
				ELSE
					Y_next <= F;
				END IF;
				LEDR (8 downto 0) <= "000000000";

			WHEN B =>
				IF K='1' THEN
				Y_next <= C;
				ELSE
				Y_next <= G;
				END IF;
				LEDR (8 downto 0) <= "000000011";

			WHEN C =>
				IF K='1' THEN
				Y_next <= D;
				ELSE
				Y_next <= H;
				END IF;
					LEDR (8 downto 0) <= "000000101";

			WHEN D =>
				IF K='1' THEN
				Y_next <= E;
				ELSE
				Y_next <= I;
				END IF;
				LEDR (8 downto 0) <= "000001001";


			WHEN E =>
				IF K='1' THEN
				Y_next <= B;
				ELSE
				Y_next <= F;
				END IF;
						LEDG <= (OTHERS => '1'); --state 4	

					LEDR (8 downto 0) <= "000010001";

			WHEN F =>
				Y_next <= G;
					LEDR (8 downto 0) <= "000100001";

			WHEN G =>
				Y_next <= H;
					LEDR (8 downto 0) <= "001000001";

			WHEN H =>
				Y_next <= I;
					LEDR (8 downto 0) <= "010000001";

			WHEN I =>
				IF K='1' THEN
				Y_next <= B;
				ELSE
				Y_next <= F;
				END IF;
				LEDR (17 downto 10) <= (OTHERS => '1');
					LEDR (8 downto 0) <= "100000001";
		END CASE;
	END PROCESS; -- state_table

	
END Behavior;