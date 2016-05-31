library verilog;
use verilog.vl_types.all;
entity controlunit is
    port(
        Clock           : in     vl_logic;
        Res             : in     vl_logic;
        w               : in     vl_logic;
        datastring      : in     vl_logic_vector(15 downto 0);
        Ain             : out    vl_logic;
        Gin             : out    vl_logic;
        Gout            : out    vl_logic;
        Data            : out    vl_logic;
        Done            : out    vl_logic;
        R0_in           : out    vl_logic;
        R0_out          : out    vl_logic;
        R1_in           : out    vl_logic;
        R1_out          : out    vl_logic;
        R2_in           : out    vl_logic;
        R2_out          : out    vl_logic;
        R3_in           : out    vl_logic;
        R3_out          : out    vl_logic;
        ALU             : out    vl_logic_vector(3 downto 0);
        funct           : in     vl_logic_vector(15 downto 0)
    );
end controlunit;
