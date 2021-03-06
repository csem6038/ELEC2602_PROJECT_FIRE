LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DLatch is
 port (D, clk : in std_logic;
 Qnot, Q : out std_logic);
end DLatch;
ARCHITECTURE behavioural OF DLatch is
BEGIN
PROCESS (clk, D)
BEGIN
 if (clk = '1') then
 Q <= D;
 Qnot <= not D;
 end if;
END PROCESS;
END;