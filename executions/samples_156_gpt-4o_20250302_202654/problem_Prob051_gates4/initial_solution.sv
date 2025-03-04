module TopModule(
    input [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for AND operation
    assign out_and = in[3] & in[2] & in[1] & in[0];

    // Combinational logic for OR operation
    assign out_or = in[3] | in[2] | in[1] | in[0];

    // Combinational logic for XOR operation
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule