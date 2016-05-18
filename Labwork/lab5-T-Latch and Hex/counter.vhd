LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY counter IS
 PORT (
		SW : in std_logic_vector(1 downto 0);
		KEY : in std_logic_vector(0 downto 0);
		LEDR : out std_logic_vector(15 downto 0);
		HEX0,HEX1,HEX2,HEX3: OUT STD_LOGIC_VECTOR(0 to 6);
		Q : out std_logic);
END counter;

ARCHITECTURE behaviour OF counter IS

COMPONENT Tlatch is 
	PORT (Clk, enable, reset : in std_logic;
		Q : out std_logic);
END COMPONENT Tlatch;
COMPONENT hexdecode is
	port ( A : IN std_logic_vector(3 downto 0);
			D : OUT std_logic_vector(0 to 6));
END COMPONENT;


SIGNAL Qout : std_logic_vector(15 downto 0);
SIGNAL Aout : std_logic_vector(15 downto 0);

BEGIN

t0 : Tlatch port map( KEY(0), SW(1), SW(0),Qout(0));
Aout(0) <= SW(1);

	GEN_T: 
		for I in 0 to 14 generate
		Aout(i+1) <= Qout(i) AND Aout(i);
      t : Tlatch port map (KEY(0), Aout(i+1), SW(0), Qout(i+1));
		end generate GEN_T;

	LEDR <= Qout;
	h0: hexdecode PORT MAP( Qout(3 downto 0), HEX0);
	h1: hexdecode PORT MAP( Qout(7 downto 4), HEX1);
	h2: hexdecode PORT MAP( Qout(11 downto 8), HEX2);
	h3: hexdecode PORT MAP( Qout(15 downto 12), HEX3);

	

end;
