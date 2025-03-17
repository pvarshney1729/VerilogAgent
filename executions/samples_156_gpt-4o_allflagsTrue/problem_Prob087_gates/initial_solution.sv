module TopModule(
    input  wire a,
    input  wire b,
    output wire out_and,
    output wire out_or,
    output wire out_xor,
    output wire out_nand,
    output wire out_nor,
    output wire out_xnor,
    output wire out_anotb
);

    assign out_and   = a & b;     // Logical AND
    assign out_or    = a | b;     // Logical OR
    assign out_xor   = a ^ b;     // Logical XOR
    assign out_nand  = ~(a & b);  // Logical NAND
    assign out_nor   = ~(a | b);  // Logical NOR
    assign out_xnor  = a ~^ b;    // Logical XNOR
    assign out_anotb = a & ~b;    // Logical AND-NOT

endmodule