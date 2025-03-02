```verilog
module TopModule (
    input logic a,       // 1-bit input
    input logic b,       // 1-bit input
    output logic out_and,    // 1-bit output: Logical AND of a and b
    output logic out_or,     // 1-bit output: Logical OR of a and b
    output logic out_xor,    // 1-bit output: Logical XOR of a and b
    output logic out_nand,   // 1-bit output: Logical NAND of a and b
    output logic out_nor,    // 1-bit output: Logical NOR of a and b
    output logic out_xnor,   // 1-bit output: Logical XNOR of a and b
    output logic out_anotb   // 1-bit output: Logical AND of a and NOT b
);

    assign out_and = a & b;       // Logical AND
    assign out_or = a | b;        // Logical OR
    assign out_xor = a ^ b;       // Logical XOR
    assign out_nand = ~(a & b);   // Logical NAND
    assign out_nor = ~(a | b);    // Logical NOR
    assign out_xnor = ~(a ^ b);   // Logical XNOR
    assign out_anotb = a & ~b;    // Logical AND of a and NOT b

endmodule
```