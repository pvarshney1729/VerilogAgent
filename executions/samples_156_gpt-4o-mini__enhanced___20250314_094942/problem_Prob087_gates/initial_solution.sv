module TopModule (
    input logic a,         // Input signal 'a', 1-bit
    input logic b,         // Input signal 'b', 1-bit
    output logic out_and,  // Output: a AND b
    output logic out_or,   // Output: a OR b
    output logic out_xor,  // Output: a XOR b
    output logic out_nand, // Output: a NAND b
    output logic out_nor,  // Output: a NOR b
    output logic out_xnor, // Output: a XNOR b
    output logic out_anotb // Output: a AND NOT b
);

assign out_and = a & b;            // Logical AND
assign out_or = a | b;             // Logical OR
assign out_xor = a ^ b;            // Logical XOR
assign out_nand = ~(a & b);        // Logical NAND
assign out_nor = ~(a | b);         // Logical NOR
assign out_xnor = ~(a ^ b);        // Logical XNOR
assign out_anotb = a & ~b;         // Logical AND NOT

endmodule