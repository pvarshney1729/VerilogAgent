```verilog
module TopModule (
    input wire a,        // 1-bit input, unsigned
    input wire b,        // 1-bit input, unsigned
    output wire out_and, // 1-bit output, result of a AND b
    output wire out_or,  // 1-bit output, result of a OR b
    output wire out_xor, // 1-bit output, result of a XOR b
    output wire out_nand,// 1-bit output, result of a NAND b
    output wire out_nor, // 1-bit output, result of a NOR b
    output wire out_xnor,// 1-bit output, result of a XNOR b
    output wire out_anotb// 1-bit output, result of a AND NOT b
);

    assign out_and = a & b;
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b;

endmodule
```