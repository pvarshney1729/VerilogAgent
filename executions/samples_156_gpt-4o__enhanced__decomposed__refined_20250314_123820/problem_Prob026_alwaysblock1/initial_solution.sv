```verilog
module TopModule (
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // AND operation using an assign statement
    assign out_assign = a & b;

    // AND operation using a combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
```