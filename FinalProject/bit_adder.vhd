LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bit_adder IS --an Adder for two bits and a carry
PORT(A, B, Cin : IN std_logic;
	result : OUT std_logic;
	Cout : OUT std_logic);
END bit_adder;

ARCHITECTURE Structure OF bit_adder IS
SIGNAL inter : std_logic;
COMPONENT two_to_one_mux IS
PORT(a, b, sel : IN STD_LOGIC;
	res : OUT STD_LOGIC);
END COMPONENT;
BEGIN
	
	inter <= A XOR B;
	result <= (Cin XOR inter);
	mux: two_to_one_mux PORT MAP(b, Cin, inter, Cout);
	
END Structure;
	
