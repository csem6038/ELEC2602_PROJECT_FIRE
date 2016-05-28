-- $Id: progMem16.vhd 343 2016-05-05 14:59:09Z Peter $

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY progMem16 IS
GENERIC ( S : INTEGER := 16;  -- Memory locations (less than or equal to 2^N) 
          N : INTEGER := 8 ); -- Address bits
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
    -- Enter your own program here
    -- result(0) := "0000000000000000”; --LOAD R0
    -- ...
    return result;
  END initialize_ram;

  SIGNAL raMem : mem := initialize_ram;
BEGIN
  PROCESS (clock)
  BEGIN
    IF clock'event and clock = '1' THEN
      IF write_enable = '1' THEN
        raMem(to_integer(unsigned(write_addr))) <= data_in;
      END IF;
      data_out <= raMem(to_integer(unsigned(read_addr)));
    END IF;
  END PROCESS;
END behavioural;
