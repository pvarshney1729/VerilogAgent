module TopModule (
    input logic a,          // Single-bit input
    input logic b,          // Single-bit input
    output logic out_and,   // Logical AND of a and b
    output logic out_or,    // Logical OR of a and b
    output logic out_xor,   // Logical XOR of a and b
    output logic out_nand,  // Logical NAND of a and b
    output logic out_nor,   // Logical NOR of a and b
    output logic out_xnor,  // Logical XNOR of a and b
    output logic out_anotb   // Logical AND of a and NOT b
);

assign out_and = a & b;          // Logical AND
assign out_or = a | b;           // Logical OR
assign out_xor = a ^ b;          // Logical XOR
assign out_nand = ~(a & b);      // Logical NAND
assign out_nor = ~(a | b);       // Logical NOR
assign out_xnor = ~(a ^ b);      // Logical XNOR
assign out_anotb = a & ~b;       // Logical AND of a and NOT b

endmodule