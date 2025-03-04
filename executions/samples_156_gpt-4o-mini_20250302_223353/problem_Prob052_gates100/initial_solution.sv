module TopModule (
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    assign out_and = &in;   // Logical AND of all input bits
    assign out_or = |in;    // Logical OR of all input bits
    assign out_xor = ^in;   // Logical XOR of all input bits

endmodule