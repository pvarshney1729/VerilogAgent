module TopModule (
    input  logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

assign out_both[99] = 1'b0; // No left neighbor
assign out_both[98:0] = in[99:1] & in[98:0];

assign out_any[0] = 1'b0; // No right neighbor for in[0]
assign out_any[99:1] = in[99:1] | in[98:0];

assign out_different[0] = in[0] ^ in[99]; // Compare in[0] with in[99]
assign out_different[99:1] = in[99:1] ^ in[98:0]; // Compare in[i] with in[i-1]

endmodule