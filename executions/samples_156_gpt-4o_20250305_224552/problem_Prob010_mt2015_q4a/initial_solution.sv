```verilog
module TopModule (
    input wire x,  // 1-bit input, unsigned
    input wire y,  // 1-bit input, unsigned
    output wire z  // 1-bit output, unsigned
);

    // Implement the boolean function z = (x ^ y) & x
    assign z = (x ^ y) & x;

endmodule
```