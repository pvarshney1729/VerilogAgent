module TopModule (
    input  wire [3:0] in,            // 4-bit input vector
    output wire [2:0] out_both,      // 3-bit output vector for both condition
    output wire [2:0] out_any,       // 3-bit output vector for any condition
    output wire [3:0] out_different  // 4-bit output vector for different condition
);

    // out_both[i] = in[i] & in[i+1]
    assign out_both[0] = in[0] & in[1];
    assign out_both[1] = in[1] & in[2];
    assign out_both[2] = in[2] & in[3];

    // out_any[i] = in[i] | in[i-1]
    assign out_any[0] = in[1] | in[0];
    assign out_any[1] = in[2] | in[1];
    assign out_any[2] = in[3] | in[2];

    // out_different[i] = in[i] ^ in[(i+1) % 4]
    assign out_different[0] = in[0] ^ in[1];
    assign out_different[1] = in[1] ^ in[2];
    assign out_different[2] = in[2] ^ in[3];
    assign out_different[3] = in[3] ^ in[0];

endmodule