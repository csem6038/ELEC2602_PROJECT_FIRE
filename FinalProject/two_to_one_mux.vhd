LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY two_to_one_mux IS
PORT(a, b, sel : IN STD_LOGIC;
	res : OUT STD_LOGIC);
END two_to_one_mux;

ARCHITECTURE Behaviour OF two_to_one_mux IS
	BEGIN
	res <= a when (sel = '0') else b;
	
END Behaviour;
