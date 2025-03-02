```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic out
);

    // Combinational logic for the output
    assign out = (a & b) | (b & c) | (a & c);

endmodule
```