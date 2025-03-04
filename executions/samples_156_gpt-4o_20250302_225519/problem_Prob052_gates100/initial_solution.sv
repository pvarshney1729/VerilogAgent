module TopModule (
    input [99:0] in,   // 100-bit wide input vector. in[0] is the LSB, in[99] is the MSB.
    output out_and,    // 1-bit output: result of AND operation across all bits of 'in'.
    output out_or,     // 1-bit output: result of OR operation across all bits of 'in'.
    output out_xor     // 1-bit output: result of XOR operation across all bits of 'in'.
);

    // Compute the logical AND of all bits in the input vector
    assign out_and = &in;

    // Compute the logical OR of all bits in the input vector
    assign out_or = |in;

    // Compute the logical XOR of all bits in the input vector
    assign out_xor = ^in;

endmodule