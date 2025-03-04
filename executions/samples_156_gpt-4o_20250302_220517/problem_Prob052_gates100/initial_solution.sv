module TopModule(
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // AND operation: all bits must be 1 for the result to be 1
    assign out_and = &in;

    // OR operation: at least one bit must be 1 for the result to be 1
    assign out_or = |in;

    // XOR operation: result is 1 if there is an odd number of 1s
    assign out_xor = ^in;

endmodule