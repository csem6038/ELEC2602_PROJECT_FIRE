LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sixteen_two_to_one_mux IS
	PORT(selection : IN STD_LOGIC;
			A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			CHOSEN : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END sixteen_two_to_one_mux;

ARCHITECTURE Behaviour OF sixteen_two_to_one_mux IS
BEGIN
	CHOSEN <= A when (selection = '0') else B;
END Behaviour;

