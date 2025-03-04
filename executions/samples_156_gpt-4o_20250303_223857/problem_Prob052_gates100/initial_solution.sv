module TopModule(
    input [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Compute the AND of all bits
    assign out_and = &in;

    // Compute the OR of all bits
    assign out_or = |in;

    // Compute the XOR of all bits
    assign out_xor = ^in;

endmodule