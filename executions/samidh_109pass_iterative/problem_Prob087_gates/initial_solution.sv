module TopModule(
    input wire a,    // 1-bit input signal
    input wire b,    // 1-bit input signal
    output wire out_and,   // 1-bit output for AND operation
    output wire out_or,    // 1-bit output for OR operation
    output wire out_xor,   // 1-bit output for XOR operation
    output wire out_nand,  // 1-bit output for NAND operation
    output wire out_nor,   // 1-bit output for NOR operation
    output wire out_xnor,  // 1-bit output for XNOR operation
    output wire out_anotb  // 1-bit output for AND-NOT operation
);

    // Combinational logic for each output
    assign out_and = a & b;       // Logical AND
    assign out_or = a | b;        // Logical OR
    assign out_xor = a ^ b;       // Logical XOR
    assign out_nand = ~(a & b);   // Logical NAND
    assign out_nor = ~(a | b);    // Logical NOR
    assign out_xnor = ~(a ^ b);   // Logical XNOR
    assign out_anotb = a & ~b;    // AND with NOT of b

endmodule