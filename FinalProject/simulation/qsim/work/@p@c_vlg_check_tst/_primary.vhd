library verilog;
use verilog.vl_types.all;
entity PC_vlg_check_tst is
    port(
        PC_out          : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end PC_vlg_check_tst;
