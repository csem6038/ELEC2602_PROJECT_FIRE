LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sixteen_bit_adder IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END sixteen_bit_adder;

ARCHITECTURE Structure OF sixteen_bit_adder IS
	SIGNAL carry_vect : STD_LOGIC_VECTOR(15 DOWNTO 0);

	COMPONENT bit_adder IS --an Adder for two bits and a carry
	PORT(A, B, Cin : IN std_logic;
		result : OUT std_logic;
		Cout : OUT std_logic);
	END COMPONENT;
BEGIN

 fa0: bit_adder PORT MAP(A(0), B(0), '0', RESULT(0), carry_vect(0));
 fa1: bit_adder PORT MAP(A(1), B(1), carry_vect(0) , RESULT(1), carry_vect(1));
 fa2: bit_adder PORT MAP(A(2), B(2), carry_vect(1) , RESULT(2), carry_vect(2));
 fa3: bit_adder PORT MAP(A(3), B(3), carry_vect(2) , RESULT(3), carry_vect(3));
 fa4: bit_adder PORT MAP(A(4), B(4), carry_vect(3) , RESULT(4), carry_vect(4));
 fa5: bit_adder PORT MAP(A(5), B(5), carry_vect(4) , RESULT(5), carry_vect(5));
 fa6: bit_adder PORT MAP(A(6), B(6), carry_vect(5) , RESULT(6), carry_vect(6));
 fa7: bit_adder PORT MAP(A(7), B(7), carry_vect(6) , RESULT(7), carry_vect(7));
 fa8: bit_adder PORT MAP(A(8), B(8), carry_vect(7) , RESULT(8), carry_vect(8));
 fa9: bit_adder PORT MAP(A(9), B(9), carry_vect(8) , RESULT(9), carry_vect(9));
 fa10: bit_adder PORT MAP(A(10), B(10), carry_vect(9) , RESULT(10), carry_vect(10));
 fa11: bit_adder PORT MAP(A(11), B(11), carry_vect(10) , RESULT(11), carry_vect(11));
 fa12: bit_adder PORT MAP(A(12), B(12), carry_vect(11) , RESULT(12), carry_vect(12));
 fa13: bit_adder PORT MAP(A(13), B(13), carry_vect(12) , RESULT(13), carry_vect(13));
 fa14: bit_adder PORT MAP(A(14), B(14), carry_vect(13) , RESULT(14), carry_vect(14));
 fa15: bit_adder PORT MAP(A(15), B(15), carry_vect(14) , RESULT(15), carry_vect(15));
 
 END Structure;
 