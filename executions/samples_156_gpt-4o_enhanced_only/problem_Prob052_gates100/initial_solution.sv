module TopModule(
    input  logic [99:0] in,
    output logic        out_and,
    output logic        out_or,
    output logic        out_xor
);

    // Use reduction operators to compute the outputs
    assign out_and = &in;  // Reduction AND
    assign out_or  = |in;  // Reduction OR
    assign out_xor = ^in;  // Reduction XOR

endmodule