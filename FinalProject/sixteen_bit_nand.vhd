LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sixteen_bit_nand IS
PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	RESULT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END sixteen_bit_nand;

ARCHITECTURE structure OF sixteen_bit_nand IS
BEGIN
	RESULT(0) <= A(0) NAND B(0);
	RESULT(1) <= A(1) NAND B(1);
	RESULT(2) <= A(2) NAND B(2);
	RESULT(3) <= A(3) NAND B(3);
	RESULT(4) <= A(4) NAND B(4);
	RESULT(5) <= A(5) NAND B(5);
	RESULT(6) <= A(6) NAND B(6);
	RESULT(7) <= A(7) NAND B(7);
	RESULT(8) <= A(8) NAND B(8);
	RESULT(9) <= A(9) NAND B(9);
	RESULT(10) <= A(10) NAND B(10);
	RESULT(11) <= A(11) NAND B(11);
	RESULT(12) <= A(12) NAND B(12);
	RESULT(13) <= A(13) NAND B(13);
	RESULT(14) <= A(14) NAND B(14);
	RESULT(15) <= A(15) NAND B(15);

END structure;
