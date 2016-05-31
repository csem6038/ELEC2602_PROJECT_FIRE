LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sixteen_bit_sub IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END sixteen_bit_sub;

ARCHITECTURE Structure OF sixteen_bit_sub IS

	SIGNAL full : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL one : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL temp1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL temp2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	COMPONENT sixteen_bit_adder IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT sixteen_bit_xor IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

BEGIN
	full <= "1111111111111111";
	one <= "0000000000000001";
	
	xor1: sixteen_bit_xor PORT MAP(full, B, temp1);
	add1: sixteen_bit_adder PORT MAP(one, temp1, temp2);
	add2: sixteen_bit_adder PORT MAP(A,temp2,RESULT);
	
	
 
END Structure;
 