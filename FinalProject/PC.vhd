Library ieee;
USE ieee.std_logic_1164.all;
USE Ieee.std_logic_unsigned.all;

ENTITY PC IS
PORT (  clk, reset, nextCount: IN std_logic;
        PC_out: OUT std_logic_vector(15 DOWNTO 0));
END PC;

ARCHITECTURE BEHAVIOUR of PC IS

SIGNAL tempPC : std_logic_vector(15 DOWNTO 0);

BEGIN
    PROCESS (nextCount, reset, clk) 
        BEGIN
            IF(reset='1') THEN
					tempPC <= "0000000000000000"; --resets value of program counter

            ELSIF (clk'event and clk = '1') THEN
					--IF(nextCount = '1') THEN
						tempPC<=tempPC+"0000000000000001"; -- increments program counter
					--END IF;
				END IF;
	END PROCESS;
	PC_out<=tempPC; --output of the program counter
END;