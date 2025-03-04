module TopModule(
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Perform a 100-input AND operation
    assign out_and = &in;

    // Perform a 100-input OR operation
    assign out_or = |in;

    // Perform a 100-input XOR operation
    assign out_xor = ^in;

endmodule