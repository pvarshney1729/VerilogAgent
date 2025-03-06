```verilog
module TopModule (
    input [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    assign out_and = &in;  // 4-input AND
    assign out_or = |in;   // 4-input OR
    assign out_xor = ^in;  // 4-input XOR

endmodule
```