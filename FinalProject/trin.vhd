LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY trin IS
 GENERIC ( N : INTEGER := 16 );
 PORT ( A : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
 enable : IN STD_LOGIC;
 Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END trin;
ARCHITECTURE Behavior OF trin IS
BEGIN
 Q <= (OTHERS => 'Z') WHEN enable = '0' ELSE A;
END Behavior ;