LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY controlunit IS
 PORT (Clock, Res,w : in std_logic;
		datastring : in std_logic_vector(15 downto 0);
		Ain,Gin,Gout,Data,Done : out std_logic; --deleted Aout from this file in all spaces marked by ***
		
		R0_in, R0_out, R1_in,R1_out,
		R2_in, R2_out, R3_in,R3_out : out std_logic;
	
		ALU: out std_logic_vector(3 downto 0);
		
		funct: in std_logic_vector(15 downto 0)

		);
		
END controlunit;

ARCHITECTURE Behavior OF controlunit IS
	--SIGNAL Res, Clock, K : std_logic ;
	 
	TYPE State_type IS (RESET, LOAD0, LOAD1, MOV, XOR0, XOR1, XOR2, ADD0, ADD1, ADD2, SUB0, SUB1, SUB2, OR0, OR1, OR2, AND0, AND1, AND2, NAND0, NAND1, NAND2, NOP,LOADU,CLEAN);
	SIGNAL Y_present, Y_next : State_type;
	SIGNAL temp: std_logic_vector(3 downto 0);
	SIGNAL dataround: std_logic;
	--SIGNAL	Rx, Ry:  std_logic_vector(3 downto 0);

	
	BEGIN
		PROCESS (w,clock) -- state table
		BEGIN
		
		IF Res = '1' THEN
			Y_present <= RESET;
		ELSIF (Clock'EVENT AND Clock = '1') THEN
			Y_present <= Y_next ;
			
		END IF ;
		END PROCESS;
	
		--Aout<='0';	***
		PROCESS (Y_present)
		BEGIN
		Ain<='0';
		Gin<='0';
		Gout<='0';
		ALU <= "0000";
		Data<='0';
		Done <='0';
		dataround <= '0';
		R0_in <= '0';
		R1_in <= '0';
		R2_in <= '0';
		R3_in <= '0';
	
		R0_out <= '0';
		R1_out <= '0';
		R2_out <= '0';
		R3_out <= '0';
		
		CASE Y_present IS
			WHEN RESET =>
								--data<='0';

			--EVERYTHING IS INVERTED LEL
--				IF( dataround='1' ) THEN
--					Data<='1';
--					R0_in <= temp(3);
--					R1_in <= temp(2);
--					R2_in <= temp(1);
--					R3_in <= temp(0);
--					dataround<='0';
				IF (funct(3 downto 0)="1000") THEN
					temp(3) <= funct(7);
					temp(2) <= funct(6);
					temp(1) <= funct(5);
					temp(0) <= funct(4);
					dataround <= '1';
					--Y_next <= LOAD0;
					Y_next <= LOAD0;
				ELSIF (funct(3 downto 0)="0100") THEN
					Y_next <= MOV;
				ELSIF (funct(3 downto 0)="0010") THEN
					Y_next <= ADD0;	
				ELSIF (funct(3 downto 0)="0001") THEN
					Y_next <= XOR0;
				ELSIF (funct(3 downto 0)="1001") THEN
					Y_next <= SUB0;
				ELSIF (funct(3 downto 0)="1010") THEN
					Y_next <= OR0;
				ELSIF (funct(3 downto 0)="1100") THEN
					Y_next <= AND0;
				ELSIF (funct(3 downto 0)="1011") THEN
					Y_next <= NAND0;

--				ELSIF (funct(3 downto 0)="1111") THEN --this makes it work with 1111 lol
--					Data<='1';
--					R0_in <= '1';
--					R1_in <= '0';
--					R2_in <= '0';
--					R3_in <= '0';
--					Done<='1';
--					Y_Next <= RESET;
				ELSE
				--	Y_next <= NOP;
					Y_next <= RESET;
				END IF;
			WHEN NOP =>
				
				Y_next <= RESET;	
				Done <='1';
			WHEN CLEAN =>
				
				Y_next <= RESET;	
				
				Ain<='0';
				Gin<='0';
				Gout<='0';
				ALU <= "0000";
				Data<='0';
				Done <='0';
				
				R0_in <= '0';
				R1_in <= '0';
				R2_in <= '0';
				R3_in <= '0';
			
				R0_out <= '0';
				R1_out <= '0';
				R2_out <= '0';
				R3_out <= '0';
			
				Done <='1';
				
				--not being used
			WHEN	LOADU =>
--				Data <= '1';
--				dataround <= '1';
--				R0_in <= funct(7);
--				R1_in <= funct(6);
--				R2_in <= funct(5);
--				R3_in <= funct(4);
				Done <= '1';
				Y_next <= RESET;
				
			WHEN LOAD0 =>
				
				Y_next <= LOAD1;
				Done <= '1';
				--Done <= '1';
--				R0_in <= temp(3);
--				R1_in <= temp(2);
--				R2_in <= temp(1);
--				R3_in <= temp(0);
--				Data <= '1'; --moved data in to load0

			WHEN LOAD1 =>
				Data <= '1';

				R0_in <= temp(3);
				R1_in <= temp(2);
				R2_in <= temp(1);
				R3_in <= temp(0);
				
				--Done <= '1';
				--Done <= '1'; --WORKS WITH THIS COMMENTED
				--Y_next <= RESET;
				--Y_next <=LOADU;
				Y_next <=NOP;

			WHEN MOV =>
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);

				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				Done <= '1';

				
				Y_next <= RESET;
				
			WHEN ADD0 =>
				Ain <= '1';
				R0_out <= funct(7);
				R1_out <= funct(6);
				R2_out <= funct(5);
				R3_out <= funct(4);
				
				ALU <= "0000";
				Y_next <= ADD1;
				
			WHEN ADD1 =>
				Gin<='1';
				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				
				ALU <= "0000";
				Y_next <= ADD2;
				
			WHEN ADD2 =>
				Gout<='1';
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);
				ALU <= "0000";
				Done <= '1';

				Y_next <= RESET;
				
			WHEN XOR0 =>
				Ain <= '1';
				R0_out <= funct(7);
				R1_out <= funct(6);
				R2_out <= funct(5);
				R3_out <= funct(4);
				ALU <= "0001";
				Y_next <= XOR1;	
				
			WHEN XOR1 =>
				Gin<='1';
				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				
				
				ALU <= "0001";
				Y_next <= XOR2;
				
			WHEN XOR2 =>
				Gout<='1';
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);
				ALU <= "0001";
				Done <= '1';

				Y_next <= RESET;
				
			WHEN SUB0 =>
				Ain <= '1';
				R0_out <= funct(7);
				R1_out <= funct(6);
				R2_out <= funct(5);
				R3_out <= funct(4);
				ALU <= "0010";
				Y_next <= SUB1;	
				
			WHEN SUB1 =>
				Gin<='1';
				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				
				
				ALU <= "0010";
				Y_next <= SUB2;
				
			WHEN SUB2 =>
				Gout<='1';
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);
				ALU <= "0010";
				Done <= '1';

				Y_next <= RESET;
		
			WHEN OR0 =>
				Ain <= '1';
				R0_out <= funct(7);
				R1_out <= funct(6);
				R2_out <= funct(5);
				R3_out <= funct(4);
				ALU <= "0100";
				Y_next <= OR1;	
				
			WHEN OR1 =>
				Gin<='1';
				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				
				
				ALU <= "0100";
				Y_next <= OR2;
				
			WHEN OR2 =>
				Gout<='1';
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);
				ALU <= "0100";
				Done <= '1';

				Y_next <= RESET;
				
			WHEN NAND0 =>
				Ain <= '1';
				R0_out <= funct(7);
				R1_out <= funct(6);
				R2_out <= funct(5);
				R3_out <= funct(4);
				ALU <= "1000";
				Y_next <= NAND1;	
				
			WHEN NAND1 =>
				Gin<='1';
				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				
				
				ALU <= "1000";
				Y_next <= NAND2;
				
			WHEN NAND2 =>
				Gout<='1';
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);
				ALU <= "1000";
				Done <= '1';

				Y_next <= RESET;	
				
			WHEN AND0 =>
				Ain <= '1';
				R0_out <= funct(7);
				R1_out <= funct(6);
				R2_out <= funct(5);
				R3_out <= funct(4);
				ALU <= "1001";
				Y_next <= AND1;	
				
			WHEN AND1 =>
				Gin<='1';
				R0_out <= funct(11);
				R1_out <= funct(10);
				R2_out <= funct(9);
				R3_out <= funct(8);
				
				
				ALU <= "1001";
				Y_next <= AND2;
				
			WHEN AND2 =>
				Gout<='1';
				R0_in <= funct(7);
				R1_in <= funct(6);
				R2_in <= funct(5);
				R3_in <= funct(4);
				ALU <= "1001";
				Done <= '1';

				Y_next <= RESET;	
				
		END CASE;
	END PROCESS; -- state_table

	
END Behavior;