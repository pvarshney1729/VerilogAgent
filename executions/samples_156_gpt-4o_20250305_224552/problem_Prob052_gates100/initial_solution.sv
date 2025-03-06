```verilog
module TopModule (
    input [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);
    assign out_and = &in; // AND reduction operator
    assign out_or = |in;  // OR reduction operator
    assign out_xor = ^in; // XOR reduction operator
endmodule
```