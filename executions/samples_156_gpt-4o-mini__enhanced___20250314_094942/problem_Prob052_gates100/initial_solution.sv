module TopModule (
    input logic [99:0] in,        // 100-bit input vector, in[99] is MSB, in[0] is LSB
    output logic out_and,         // Single-bit output for AND operation
    output logic out_or,          // Single-bit output for OR operation
    output logic out_xor          // Single-bit output for XOR operation
);

// Combinational logic implementation
assign out_and = &in;         // AND operation across all input bits
assign out_or  = |in;         // OR operation across all input bits
assign out_xor = ^in;         // XOR operation across all input bits

endmodule