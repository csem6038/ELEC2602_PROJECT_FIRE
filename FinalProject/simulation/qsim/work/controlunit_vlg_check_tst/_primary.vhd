library verilog;
use verilog.vl_types.all;
entity controlunit_vlg_check_tst is
    port(
        Ain             : in     vl_logic;
        Data            : in     vl_logic;
        Done            : in     vl_logic;
        Gin             : in     vl_logic;
        Gout            : in     vl_logic;
        R0_in           : in     vl_logic;
        R0_out          : in     vl_logic;
        R1_in           : in     vl_logic;
        R1_out          : in     vl_logic;
        R2_in           : in     vl_logic;
        R2_out          : in     vl_logic;
        R3_in           : in     vl_logic;
        R3_out          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end controlunit_vlg_check_tst;
