module TopModule (
    input  logic [3:0] in_vector,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

assign out_and = &in_vector;  // Logical AND of all bits
assign out_or  = |in_vector;  // Logical OR of all bits
assign out_xor = ^in_vector;  // Logical XOR of all bits

endmodule