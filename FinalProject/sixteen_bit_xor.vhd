LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sixteen_bit_xor IS
PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END sixteen_bit_xor;

ARCHITECTURE structure OF sixteen_bit_xor IS
BEGIN
	RESULT(0) <= A(0) XOR B(0);
	RESULT(1) <= A(1) XOR B(1);
	RESULT(2) <= A(2) XOR B(2);
	RESULT(3) <= A(3) XOR B(3);
	RESULT(4) <= A(4) XOR B(4);
	RESULT(5) <= A(5) XOR B(5);
	RESULT(6) <= A(6) XOR B(6);
	RESULT(7) <= A(7) XOR B(7);
	RESULT(8) <= A(8) XOR B(8);
	RESULT(9) <= A(9) XOR B(9);
	RESULT(10) <= A(10) XOR B(10);
	RESULT(11) <= A(11) XOR B(11);
	RESULT(12) <= A(12) XOR B(12);
	RESULT(13) <= A(13) XOR B(13);
	RESULT(14) <= A(14) XOR B(14);
	RESULT(15) <= A(15) XOR B(15);

END structure;
