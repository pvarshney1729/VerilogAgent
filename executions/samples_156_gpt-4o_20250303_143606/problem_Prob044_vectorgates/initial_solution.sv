```verilog
module TopModule(
    input wire [2:0] a,             // 3-bit unsigned input vector a
    input wire [2:0] b,             // 3-bit unsigned input vector b
    output wire [2:0] out_or_bitwise, // 3-bit unsigned output for bitwise OR
    output wire out_or_logical,     // 1-bit output for logical OR
    output wire [5:0] out_not       // 6-bit unsigned output for NOT operation
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = |(a | b);

    // NOT operation
    assign out_not[5:3] = ~b;
    assign out_not[2:0] = ~a;

endmodule
```