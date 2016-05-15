LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY register16 IS
 PORT ( Clk, Enable: IN STD_LOGIC;
Data_in: IN STD_LOGIC_VECTOR(15 downto 0);
Data_out : OUT STD_LOGIC_VECTOR(15 downto 0));
END register16;
	ARCHITECTURE Structural OF register16 IS
	 SIGNAL D : STD_LOGIC_VECTOR(15 downto 0);
	BEGIN
	 process (Clk)
	 begin
	if (Clk'event and Clk = '1') then
	if(Enable = '1') then 
	D <= data_in;
	end if;
	end if;
	end process;
Data_out <= D;
END Structural; 