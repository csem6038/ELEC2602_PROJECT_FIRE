LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part3 IS
 PORT (SW : in std_logic_vector (17 downto 0);
		KEY : in std_logic_vector (0 downto 0);
		LEDG : out std_logic_vector (7 downto 0);
		LEDR : out std_logic_vector (17 downto 0);
		HEX0,HEX1,HEX2,HEX3: OUT STD_LOGIC_VECTOR(0 to 6)
		);
		
END part3;
ARCHITECTURE Behavior OF part3 IS

	COMPONENT hexdecode is
		port ( A : IN std_logic_vector(3 downto 0);
				D : OUT std_logic_vector(0 to 6));
	END COMPONENT;
	
	SIGNAL Reset, Clock, K : std_logic ;
	 
	TYPE State_type IS (B, C, D, E, F, G, H, I, A);
	signal count: integer;
	SIGNAL Y_present, Y_next : State_type;
	SIGNAL pass_set1: std_logic_vector(3 downto 0);
	SIGNAL pass_set2: std_logic_vector(3 downto 0);
	SIGNAL pass_set3: std_logic_vector(3 downto 0);
	SIGNAL pass_set0: std_logic_vector(3 downto 0);

	--pass_set <= SW(3 downto 0);
	--pass_check <= SW(7 downto 4);

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
	IF count='0' THEN
		pass_set0 <= SW(3 downto 0);
	ELSE IF count='1' THEN
		pass_set1 <= SW(3 downto 0);	
	ELSE IF count='2' THEN
		pass_set2 <= SW(3 downto 0);		
	ELSE IF count='3' THEN
		pass_set3 <= SW(3 downto 0);
	END IF;
	
	h0: hexdecode PORT MAP( pass_set0, HEX0);
	h1: hexdecode PORT MAP( pass_set1, HEX1);
	h2: hexdecode PORT MAP( pass_set2, HEX2);
	h3: hexdecode PORT MAP( pass_set3, HEX3);
	count<=count+1;

	END PROCESS; -- state_table
	
	
END Behavior;