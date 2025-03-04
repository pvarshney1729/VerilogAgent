module TopModule (
    input [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for AND operation
    assign out_and = &in;

    // Combinational logic for OR operation
    assign out_or = |in;

    // Combinational logic for XOR operation
    assign out_xor = ^in;

endmodule