```verilog
module TopModule (
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // AND operation using assign statement
    assign out_assign = a & b;

    // AND operation using combinational always block
    always_comb begin
        out_alwaysblock = a & b;
    end

endmodule
```