LIBRARY ieee;

USE ieee.std_logic_1164.all;

 

entity counter16 is

generic ( N : integer := 16 );
          port( CLK, reset, t : in std_logic;
          Q : out std_logic_vector(N-1 downto 0));

end counter16;

 

ARCHITECTURE structural of counter16 is

COMPONENT Tlatch2 IS

          port(  CLK, t, reset: in std_logic;

                     Q: out std_logic);

          END COMPONENT;

         
SIGNAL Qtemp: std_logic_vector(N-1 downto 0); -- check signal (N-1 downto 1)

SIGNAL Ttemp: std_logic;

 

BEGIN 

c1: Tlatch2 port map(CLK, t, reset, Q(0));

b:       FOR i IN 1 TO N-1 GENERATE                             

                     Ttemp <= t AND Qtemp(i);

                     c2: lab5part1 port map (CLK, Ttemp, reset, Qtemp(i));

          END GENERATE;

          Q <= Qtemp;

END structural;
