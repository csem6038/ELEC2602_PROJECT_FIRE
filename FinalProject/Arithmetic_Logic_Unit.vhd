LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Arithmetic_Logic_Unit IS
	PORT( num1, num2 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			sel: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			chosen_result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END Arithmetic_Logic_Unit;

ARCHITECTURE Structure OF Arithmetic_Logic_Unit IS
SIGNAL intermediate1, intermediate2, intermediate3, intermediate4, intermediate5, intermediate6, intermediate7 : STD_LOGIC_VECTOR(15 DOWNTO 0);

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
	
	COMPONENT sixteen_bit_sub IS
			PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT sixteen_bit_nand IS
		PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT sixteen_bit_or IS
		PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT sixteen_bit_and IS
		PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
		
	
BEGIN
	adderres : sixteen_bit_adder PORT MAP(num1, num2, intermediate1);
	xorres : sixteen_bit_xor PORT MAP(num1, num2, intermediate2);
	sixteen_mux: sixteen_two_to_one_mux PORT MAP(sel(0), intermediate1, intermediate2, intermediate3);
	sub : sixteen_bit_sub PORT MAP(num1, num2, intermediate4);
	Qor : sixteen_bit_or PORT MAP(num1, num2, intermediate5);
	Qnand : sixteen_bit_nand PORT MAP(num1, num2, intermediate6);
	Qand : sixteen_bit_and PORT MAP(num1, num2, intermediate7);


	 chosen_result <= intermediate4 when sel = "0010" else 
			  intermediate5 when sel = "0100" else 
			  intermediate6 when sel = "1000" else 
			  intermediate7 when sel = "1001" else
			  intermediate3;
	
END Structure;