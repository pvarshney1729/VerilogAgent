module TopModule (
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    assign out_and = &in;        // AND operation
    assign out_or = |in;         // OR operation
    assign out_xor = ^in;        // XOR operation

endmodule