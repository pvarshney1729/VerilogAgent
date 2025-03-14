```verilog
module TopModule (
    input logic x,          // One-bit input: x (unsigned)
    input logic y,          // One-bit input: y (unsigned)
    output logic z          // One-bit output: z (unsigned)
);

    assign z = (x ^ y) & x; // Implementing the boolean function z = (x^y) & x

endmodule
```