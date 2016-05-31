LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Arithmetic_Logic_Unit IS
	PORT( num1, num2 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			sel : IN STD_LOGIC;
			chosen_result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END Arithmetic_Logic_Unit;

ARCHITECTURE Structure OF Arithmetic_Logic_Unit IS
SIGNAL intermediate1, intermediate2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	COMPONENT sixteen_bit_adder IS
			PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	COMPONENT sixteen_bit_xor IS
			PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	COMPONENT sixteen_two_to_one_mux IS
	PORT(selection : IN STD_LOGIC;
			A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			CHOSEN : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
BEGIN
	adderres : sixteen_bit_adder PORT MAP(num1, num2, intermediate1);
	xorres : sixteen_bit_xor PORT MAP(num1, num2, intermediate2);
	sixteen_mux: sixteen_two_to_one_mux PORT MAP(sel, intermediate1, intermediate2, chosen_result);
	
END Structure;