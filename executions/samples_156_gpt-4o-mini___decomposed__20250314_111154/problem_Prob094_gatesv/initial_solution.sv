module TopModule (
    input  logic [3:0] in,
    output logic [3:0] out_both,
    output logic [3:0] out_any,
    output logic [3:0] out_different
);

    assign out_both[0] = 1'b0;                   // No left neighbor for in[0]
    assign out_both[1] = in[1] & in[0];          // Check in[1] and in[0]
    assign out_both[2] = in[2] & in[1];          // Check in[2] and in[1]
    assign out_both[3] = in[3] & in[2];          // Check in[3] and in[2]

    assign out_any[0] = 1'b0;                    // No right neighbor for in[0]
    assign out_any[1] = in[1] | in[0];           // Check in[1] and in[0]
    assign out_any[2] = in[2] | in[1];           // Check in[2] and in[1]
    assign out_any[3] = in[3] | in[2];           // Check in[3] and in[2]

    assign out_different[0] = in[0] ^ in[3];     // Check in[0] and in[3] (wrap around)
    assign out_different[1] = in[1] ^ in[0];     // Check in[1] and in[0]
    assign out_different[2] = in[2] ^ in[1];     // Check in[2] and in[1]
    assign out_different[3] = in[3] ^ in[2];     // Check in[3] and in[2]

endmodule