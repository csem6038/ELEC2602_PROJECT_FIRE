library verilog;
use verilog.vl_types.all;
entity controlunit_vlg_sample_tst is
    port(
        Clock           : in     vl_logic;
        funct           : in     vl_logic_vector(15 downto 0);
        Res             : in     vl_logic;
        w               : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end controlunit_vlg_sample_tst;
