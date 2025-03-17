module TopModule(
    input logic [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for 4-input AND gate
    assign out_and = in[3] & in[2] & in[1] & in[0];

    // Combinational logic for 4-input OR gate
    assign out_or = in[3] | in[2] | in[1] | in[0];

    // Combinational logic for 4-input XOR gate
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule