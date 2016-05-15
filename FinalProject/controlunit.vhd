LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY controlunit IS
 PORT (Clock, Res,w : in std_logic;
		Ain,Gin,Gout,Data : out std_logic; --deleted Aout from this file in all spaces marked by ***
		
		R0_in, R0_out, R1_in,R1_out,
		R2_in, R2_out, R3_in,R3_out: out std_logic;
		
		
		funct: in std_logic_vector(15 downto 0)

		);
		
END controlunit;

ARCHITECTURE Behavior OF controlunit IS
	--SIGNAL Res, Clock, K : std_logic ;
	 
	TYPE State_type IS (RESET, LOAD, MOV, XOR0, XOR1, XOR2, ADD0, ADD1, ADD2);
	SIGNAL Y_present, Y_next : State_type;
	--SIGNAL	Rx, Ry:  std_logic_vector(3 downto 0);

	
	BEGIN
	PROCESS (w,clock) -- state table
	BEGIN
	
	IF Res = '1' THEN
		Y_present <= RESET;
	ELSIF (Clock'EVENT AND Clock = '1') THEN
		Y_present <= Y_next ;
		
	END IF ;
	
		--Aout<='0';	***
		Ain<='0';
		Gin<='0';
		Gout<='0';
	
		CASE Y_present IS
			WHEN RESET =>
				IF (funct(3 downto 0)="0001") THEN
					Y_next <= LOAD;
				ELSIF (funct(3 downto 0)="0010") THEN
					Y_next <= MOV;
				ELSIF (funct(3 downto 0)="0100") THEN
					Y_next <= ADD0;	
				ELSIF (funct(3 downto 0)="1000") THEN
					Y_next <= XOR0;
				END IF;
					
			WHEN LOAD =>
				data <= '1';
				R0_in <= funct(8);
				R1_in <= funct(9);
				R2_in <= funct(10);
				R3_in <= funct(11);
				
				Y_next <= RESET;

			WHEN MOV =>
				R0_in <= funct(8);
				R1_in <= funct(9);
				R2_in <= funct(10);
				R3_in <= funct(11);

				R0_out <= funct(4);
				R1_out <= funct(5);
				R2_out <= funct(6);
				R3_out <= funct(7);
				
				
				Y_next <= RESET;
				
			WHEN XOR0 =>
				R0_out <= funct(8);
				R1_out <= funct(9);
				R2_out <= funct(10);
				R3_out <= funct(11);
				
	
				Y_next <= XOR1;	
				
			WHEN XOR1 =>

				R0_out <= funct(8);
				R1_out <= funct(9);
				R2_out <= funct(10);
				R3_out <= funct(11);
				
				
				Gin<='1';
				Y_next <= XOR2;
				
			WHEN XOR2 =>
				Gout<='1';
				R0_in <= funct(8);
				R1_in <= funct(9);
				R2_in <= funct(10);
				R3_in <= funct(11);

				Y_next <= RESET;
			
			WHEN ADD0 =>
				R0_out <= funct(8);
				R1_out <= funct(9);
				R2_out <= funct(10);
				R3_out <= funct(11);
				Y_next <= ADD1;	
				
			WHEN ADD1 =>
				Gin<='1';

				R0_out <= funct(8);
				R1_out <= funct(9);
				R2_out <= funct(10);
				R3_out <= funct(11);
				Y_next <= ADD2;
				
			WHEN ADD2 =>
				Gout<='1';
				R0_in <= funct(8);
				R1_in <= funct(9);
				R2_in <= funct(10);
				R3_in <= funct(11);
				Y_next <= RESET;
				
				
		END CASE;
	END PROCESS; -- state_table

	
END Behavior;