-- $Id: progMem16.vhd 343 2016-05-05 14:59:09Z Peter $

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY progMem16 IS
GENERIC ( S : INTEGER := 16;  -- Memory locations (less than or equal to 2^N) 
          N : INTEGER := 16 ); -- Address bits
                              -- Data bits fixed at 16
port(
  clock        : in std_logic;
  data_in      : in std_logic_vector (15 downto 0);
  write_addr   : in std_logic_vector (N-1 downto 0);
  read_addr    : in std_logic_vector (N-1 downto 0);
  write_enable : in std_logic;
  data_out     : out std_logic_vector (15 downto 0));
END;

ARCHITECTURE behavioural OF progMem16  IS
  TYPE mem IS ARRAY (S-1 downto 0) OF std_logic_vector(15 downto 0);

  FUNCTION initialize_ram RETURN mem IS
  VARIABLE result : mem;
  BEGIN
    -- Sample program 1 :D 
    -- result(0) := "0000000000000000”; --LOAD R0
    -- ...
	 --result(0) := "0000000000000000"; --reset

--	 result(0) := "0000000010001000"; --LOAD R0
--	 result(1) := "0000000000000010"; --2
--	 result(2) := "0000000001001000"; --LOAD R0
--	 result(3) := "0000000000001111"; --15

	 --result(1) := "0000000000000010"; -- Store data 2 --or 16
	 --result(2) := "0000000000000000"; --BLANK
	
	
	 --result(2) := "0000100001000100"; -- MOV R1, R0
	-- result(4) := "0000010010000010"; -- ADD R0, R1
	-- result(4) := "0000010010000001"; -- XOR R0, R1
	 --result(5) := "0000000000000000"; --RETURN

	 
	 --MULTILOAD
	 	result(0) := "0000000010001000"; -- LOAD R0
	 	result(1) := "0000000000000100"; -- 4
	 	result(2) := "0000000001001000"; -- LOAD R1
	 	result(3) := "0000000000000011"; -- 3
	 	result(4) := "0000000000101000"; -- LOAD R2
	 	result(5) := "0000000000000011"; -- 3
	 	result(6) := "0000001001000010"; -- ADD R1, R2
	 	result(7) := "0000010010000010"; -- ADD R0, R1

    return result;
  END initialize_ram;

  SIGNAL raMem : mem := initialize_ram;
BEGIN
  PROCESS (clock)
  BEGIN
    IF clock'event and clock = '1' THEN
      data_out <= raMem(to_integer(unsigned(read_addr)));
    END IF;
  END PROCESS;
END behavioural;
