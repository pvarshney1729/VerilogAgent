module TopModule (
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

assign out_and = &in;      // AND operation across all bits
assign out_or = |in;       // OR operation across all bits
assign out_xor = ^in;      // XOR operation across all bits

endmodule