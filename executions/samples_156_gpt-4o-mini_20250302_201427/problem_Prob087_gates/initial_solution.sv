module TopModule (
    input  logic a,        // Input: 1-bit, unsigned
    input  logic b,        // Input: 1-bit, unsigned
    output logic out_and,  // Output: 1-bit, result of logical AND between a and b
    output logic out_or,   // Output: 1-bit, result of logical OR between a and b
    output logic out_xor,  // Output: 1-bit, result of logical XOR between a and b
    output logic out_nand, // Output: 1-bit, result of logical NAND between a and b
    output logic out_nor,  // Output: 1-bit, result of logical NOR between a and b
    output logic out_xnor, // Output: 1-bit, result of logical XNOR between a and b
    output logic out_anotb // Output: 1-bit, result of 'a and (not b)'
);

assign out_and  = a & b;            // Logical AND operation
assign out_or   = a | b;            // Logical OR operation
assign out_xor  = a ^ b;            // Logical XOR operation
assign out_nand = ~(a & b);         // Logical NAND operation
assign out_nor  = ~(a | b);         // Logical NOR operation
assign out_xnor = ~(a ^ b);         // Logical XNOR operation
assign out_anotb = a & ~b;          // Logical 'a and (not b)' operation

endmodule