module TopModule (
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    assign out_both = {1'b0, in[98:0] & in[99:1]};
    assign out_any = {in[98:0] | in[99:1], 1'b0};
    assign out_different = {in[98:0] ^ in[99:1], in[0] ^ in[99]};

endmodule