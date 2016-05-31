library verilog;
use verilog.vl_types.all;
entity Arithmetic_Logic_Unit is
    port(
        num1            : in     vl_logic_vector(15 downto 0);
        num2            : in     vl_logic_vector(15 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        chosen_result   : out    vl_logic_vector(15 downto 0)
    );
end Arithmetic_Logic_Unit;
