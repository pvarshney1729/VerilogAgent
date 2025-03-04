```verilog
module TopModule (
    input logic a, // 1-bit, unsigned
    input logic b, // 1-bit, unsigned
    input logic c, // 1-bit, unsigned
    input logic d, // 1-bit, unsigned
    output logic q // 1-bit, unsigned
);

    // Combinational logic expression
    assign q = (b) || (c && !d);

endmodule
```