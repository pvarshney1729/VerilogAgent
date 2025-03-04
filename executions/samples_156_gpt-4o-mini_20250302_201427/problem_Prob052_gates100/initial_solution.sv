module TopModule(
    input [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);
    assign out_and = &in; // AND reduction
    assign out_or = |in;  // OR reduction
    assign out_xor = ^in; // XOR reduction
endmodule