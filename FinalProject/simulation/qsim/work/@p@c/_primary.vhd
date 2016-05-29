library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        nextCount       : in     vl_logic;
        PC_out          : out    vl_logic_vector(15 downto 0)
    );
end PC;
