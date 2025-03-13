[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    always @(*) begin
        out[24] = ~(a ^ a); // 1'b0
        out[23] = ~(a ^ b); // 1'b0
        out[22] = ~(a ^ c); // 1'b0
        out[21] = ~(a ^ d); // 1'b0
        out[20] = ~(a ^ e); // 1'b0
        out[19] = ~(b ^ a); // 1'b0
        out[18] = ~(b ^ b); // 1'b0
        out[17] = ~(b ^ c); // 1'b0
        out[16] = ~(b ^ d); // 1'b0
        out[15] = ~(b ^ e); // 1'b0
        out[14] = ~(c ^ a); // 1'b0
        out[13] = ~(c ^ b); // 1'b0
        out[12] = ~(c ^ c); // 1'b0
        out[11] = ~(c ^ d); // 1'b0
        out[10] = ~(c ^ e); // 1'b0
        out[ 9] = ~(d ^ a); // 1'b0
        out[ 8] = ~(d ^ b); // 1'b0
        out[ 7] = ~(d ^ c); // 1'b0
        out[ 6] = ~(d ^ d); // 1'b0
        out[ 5] = ~(d ^ e); // 1'b0
        out[ 4] = ~(e ^ a); // 1'b0
        out[ 3] = ~(e ^ b); // 1'b0
        out[ 2] = ~(e ^ c); // 1'b0
        out[ 1] = ~(e ^ d); // 1'b0
        out[ 0] = ~(e ^ e); // 1'b0
    end

endmodule
[DONE]