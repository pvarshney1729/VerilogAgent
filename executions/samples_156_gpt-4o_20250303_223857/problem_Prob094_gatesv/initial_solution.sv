module TopModule (
    input  logic [3:0] in,            // 4-bit input vector
    output logic [3:0] out_both,      // 4-bit output vector
    output logic [3:0] out_any,       // 4-bit output vector
    output logic [3:0] out_different  // 4-bit output vector
);

    // Combinational logic for out_both
    assign out_both[0] = in[0] & in[1];
    assign out_both[1] = in[1] & in[2];
    assign out_both[2] = in[2] & in[3];
    assign out_both[3] = 1'b0;

    // Combinational logic for out_any
    assign out_any[0] = 1'b0;
    assign out_any[1] = in[1] | in[0];
    assign out_any[2] = in[2] | in[1];
    assign out_any[3] = in[3] | in[2];

    // Combinational logic for out_different
    assign out_different[0] = in[0] ^ in[3];
    assign out_different[1] = in[1] ^ in[0];
    assign out_different[2] = in[2] ^ in[1];
    assign out_different[3] = in[3] ^ in[2];

endmodule