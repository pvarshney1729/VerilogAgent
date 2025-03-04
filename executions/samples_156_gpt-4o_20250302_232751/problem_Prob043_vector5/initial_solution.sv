module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    always @(*) begin
        out[0] = ~(a ^ a);
        out[1] = ~(a ^ b);
        out[2] = ~(a ^ c);
        out[3] = ~(a ^ d);
        out[4] = ~(a ^ e);
        out[5] = ~(b ^ a);
        out[6] = ~(b ^ b);
        out[7] = ~(b ^ c);
        out[8] = ~(b ^ d);
        out[9] = ~(b ^ e);
        out[10] = ~(c ^ a);
        out[11] = ~(c ^ b);
        out[12] = ~(c ^ c);
        out[13] = ~(c ^ d);
        out[14] = ~(c ^ e);
        out[15] = ~(d ^ a);
        out[16] = ~(d ^ b);
        out[17] = ~(d ^ c);
        out[18] = ~(d ^ d);
        out[19] = ~(d ^ e);
        out[20] = ~(e ^ a);
        out[21] = ~(e ^ b);
        out[22] = ~(e ^ c);
        out[23] = ~(e ^ d);
        out[24] = ~(e ^ e);
    end

endmodule