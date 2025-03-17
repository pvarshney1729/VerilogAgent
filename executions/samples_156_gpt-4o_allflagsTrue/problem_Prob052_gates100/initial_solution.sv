module TopModule (
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Compute the 100-input AND gate output
    assign out_and = &in;

    // Compute the 100-input OR gate output
    assign out_or = |in;

    // Compute the 100-input XOR gate output
    assign out_xor = ^in;

endmodule