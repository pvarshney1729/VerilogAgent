module TopModule (
    input  logic [3:0] in,          // 4-bit input vector
    output logic [3:0] out_both,    // 4-bit output vector indicating if both the current bit and the left neighbor are '1'
    output logic [3:0] out_any,     // 4-bit output vector indicating if either the current bit or the right neighbor is '1'
    output logic [3:0] out_different // 4-bit output vector indicating if the current bit is different from the left neighbor
);

    // out_both logic
    assign out_both[3] = 1'b0; // No left neighbor for in[3]
    assign out_both[2] = in[2] & in[3];
    assign out_both[1] = in[1] & in[2];
    assign out_both[0] = in[0] & in[1];

    // out_any logic
    assign out_any[0] = 1'b0; // No right neighbor for in[0]
    assign out_any[1] = in[1] | in[0];
    assign out_any[2] = in[2] | in[1];
    assign out_any[3] = in[3] | in[2];

    // out_different logic
    assign out_different[0] = in[0] ^ in[1];
    assign out_different[1] = in[1] ^ in[2];
    assign out_different[2] = in[2] ^ in[3];
    assign out_different[3] = in[3] ^ in[0]; // Wrap-around

endmodule