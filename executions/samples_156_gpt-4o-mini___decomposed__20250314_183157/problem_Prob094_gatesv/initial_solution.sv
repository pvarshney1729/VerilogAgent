module TopModule (
    input  logic [3:0] in,
    output logic [3:0] out_both,
    output logic [3:0] out_any,
    output logic [3:0] out_different
);

assign out_both[3] = 1'b0; // No left neighbor for in[3]
assign out_both[2] = in[3] & in[2];
assign out_both[1] = in[2] & in[1];
assign out_both[0] = in[1] & in[0];

assign out_any[0] = 1'b0; // No right neighbor for in[0]
assign out_any[1] = in[1] | in[0];
assign out_any[2] = in[2] | in[1];
assign out_any[3] = in[3] | in[2];

assign out_different[0] = in[0] ^ in[3]; // Compare in[0] with its left neighbor in[3]
assign out_different[1] = in[1] ^ in[0]; // Compare in[1] with its left neighbor in[0]
assign out_different[2] = in[2] ^ in[1]; // Compare in[2] with its left neighbor in[1]
assign out_different[3] = in[3] ^ in[2]; // Compare in[3] with its left neighbor in[2]

endmodule