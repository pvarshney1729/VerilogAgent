module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    always_comb begin
        out[24] = ~(a ^ a); // Always 1
        out[23] = ~(a ^ b);
        out[22] = ~(a ^ c);
        out[21] = ~(a ^ d);
        out[20] = ~(a ^ e);
        out[19] = ~(b ^ b); // Always 1
        out[18] = ~(b ^ c);
        out[17] = ~(b ^ d);
        out[16] = ~(b ^ e);
        out[15] = ~(c ^ c); // Always 1
        out[14] = ~(c ^ d);
        out[13] = ~(c ^ e);
        out[12] = ~(d ^ d); // Always 1
        out[11] = ~(d ^ e);
        out[10] = ~(e ^ e); // Always 1
        // Remaining bits can be set to 0 or optimized out
        out[9:0] = 10'b0;
    end

endmodule