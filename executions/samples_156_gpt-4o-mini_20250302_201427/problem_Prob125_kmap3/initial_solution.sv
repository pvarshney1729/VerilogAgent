```verilog
module TopModule (
    input logic a, // 1-bit input, unsigned
    input logic b, // 1-bit input, unsigned
    input logic c, // 1-bit input, unsigned
    input logic d, // 1-bit input, unsigned
    output logic out // 1-bit output, unsigned
);

    assign out = (~c & ~b & a) | (~c & b & a) | (c & a) | (c & b);

endmodule
```