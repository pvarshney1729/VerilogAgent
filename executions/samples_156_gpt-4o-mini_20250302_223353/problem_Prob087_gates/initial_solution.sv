module TopModule (
    input logic a,         // 1-bit input, binary (0 or 1)
    input logic b,         // 1-bit input, binary (0 or 1)
    output logic out_and,  // Output for logical AND operation of a and b
    output logic out_or,   // Output for logical OR operation of a and b
    output logic out_xor,  // Output for logical XOR operation of a and b
    output logic out_nand, // Output for logical NAND operation of a and b
    output logic out_nor,  // Output for logical NOR operation of a and b
    output logic out_xnor, // Output for logical XNOR operation of a and b
    output logic out_anotb // Output for logical AND operation of a and NOT b
);

assign out_and = a & b;       // Logical AND
assign out_or = a | b;        // Logical OR
assign out_xor = a ^ b;       // Logical XOR
assign out_nand = ~(a & b);   // Logical NAND
assign out_nor = ~(a | b);    // Logical NOR
assign out_xnor = ~(a ^ b);   // Logical XNOR
assign out_anotb = a & ~b;    // Logical AND of a and NOT b

endmodule