module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    assign out[24] = ~(a ^ a); // Always 1
    assign out[23] = ~(a ^ b);
    assign out[22] = ~(a ^ c);
    assign out[21] = ~(a ^ d);
    assign out[20] = ~(a ^ e);
    assign out[19] = ~(b ^ b); // Always 1
    assign out[18] = ~(b ^ c);
    assign out[17] = ~(b ^ d);
    assign out[16] = ~(b ^ e);
    assign out[15] = ~(c ^ c); // Always 1
    assign out[14] = ~(c ^ d);
    assign out[13] = ~(c ^ e);
    assign out[12] = ~(d ^ d); // Always 1
    assign out[11] = ~(d ^ e);
    assign out[10] = ~(e ^ e); // Always 1
    assign out[9:0] = 10'b0;   // Reserved bits set to 0

endmodule