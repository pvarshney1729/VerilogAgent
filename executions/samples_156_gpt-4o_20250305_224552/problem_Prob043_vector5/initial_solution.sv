module TopModule (
    input wire a,  // 1-bit input
    input wire b,  // 1-bit input
    input wire c,  // 1-bit input
    input wire d,  // 1-bit input
    input wire e,  // 1-bit input
    output wire [24:0] out  // 25-bit output
);

    assign out[24] = ~(a ^ a);
    assign out[23] = ~(a ^ b);
    assign out[22] = ~(a ^ c);
    assign out[21] = ~(a ^ d);
    assign out[20] = ~(a ^ e);
    assign out[19] = ~(b ^ b);
    assign out[18] = ~(b ^ c);
    assign out[17] = ~(b ^ d);
    assign out[16] = ~(b ^ e);
    assign out[15] = ~(c ^ c);
    assign out[14] = ~(c ^ d);
    assign out[13] = ~(c ^ e);
    assign out[12] = ~(d ^ d);
    assign out[11] = ~(d ^ e);
    assign out[10] = ~(e ^ e);

endmodule