module TopModule (
    input logic [3:0] in,       // 4-bit input vector
    output logic out_and,       // 1-bit output for 4-input AND
    output logic out_or,        // 1-bit output for 4-input OR
    output logic out_xor        // 1-bit output for 4-input XOR
);

    // Combinational logic for outputs
    assign out_and = in[3] & in[2] & in[1] & in[0]; // 4-input AND
    assign out_or  = in[3] | in[2] | in[1] | in[0]; // 4-input OR
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0]; // 4-input XOR

endmodule