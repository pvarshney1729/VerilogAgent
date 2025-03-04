```verilog
module TopModule (
    input wire a,   // Single-bit input, 0 or 1
    input wire b,   // Single-bit input, 0 or 1
    output wire q   // Single-bit output, 0 or 1
);

    // Logical AND operation to determine the output
    assign q = a & b;

endmodule
```