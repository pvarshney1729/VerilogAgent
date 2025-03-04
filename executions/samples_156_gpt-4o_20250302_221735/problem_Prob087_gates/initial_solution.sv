module TopModule (
    input logic a,      // 1-bit input
    input logic b,      // 1-bit input
    output logic out_and,   // 1-bit output: Logical AND of a and b
    output logic out_or,    // 1-bit output: Logical OR of a and b
    output logic out_xor,   // 1-bit output: Logical XOR of a and b
    output logic out_nand,  // 1-bit output: Logical NAND of a and b
    output logic out_nor,   // 1-bit output: Logical NOR of a and b
    output logic out_xnor,  // 1-bit output: Logical XNOR of a and b
    output logic out_anotb  // 1-bit output: Logical AND of a and NOT b
);

    // Combinational logic for each output
    assign out_and = a & b;
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b;

endmodule