module TopModule (
    input  logic [99:0] in,    // 100-bit input vector
    output logic        out_and, // 1-bit output for AND operation
    output logic        out_or,  // 1-bit output for OR operation
    output logic        out_xor  // 1-bit output for XOR operation
);

    // AND operation across all bits
    assign out_and = &in;

    // OR operation across all bits
    assign out_or = |in;

    // XOR operation across all bits
    assign out_xor = ^in;

endmodule