```verilog
module TopModule (
    input  [2:0] a,              // 3-bit unsigned input vector
    input  [2:0] b,              // 3-bit unsigned input vector
    output [2:0] out_or_bitwise, // 3-bit unsigned output vector for bitwise OR
    output       out_or_logical, // 1-bit output for logical OR
    output [5:0] out_not         // 6-bit unsigned output vector for NOT operations
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = |(a | b);

    // Bitwise NOT operations
    assign out_not[5:3] = ~b;
    assign out_not[2:0] = ~a;

endmodule
```