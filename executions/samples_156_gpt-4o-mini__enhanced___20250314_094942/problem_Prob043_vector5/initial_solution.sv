module TopModule (
    input  logic a,         // 1-bit input signal a
    input  logic b,         // 1-bit input signal b
    input  logic c,         // 1-bit input signal c
    input  logic d,         // 1-bit input signal d
    input  logic e,         // 1-bit input signal e
    output logic [24:0] out // 25-bit output vector
);

    always @(*) begin
        // Compute pairwise comparisons
        out[0]  = (e == e);
        out[1]  = (e == d);
        out[2]  = (e == c);
        out[3]  = (e == b);
        out[4]  = (e == a);
        out[5]  = (d == d);
        out[6]  = (d == c);
        out[7]  = (d == b);
        out[8]  = (d == a);
        out[9]  = (c == c);
        out[10] = (c == b);
        out[11] = (c == a);
        out[12] = (b == b);
        out[13] = (b == a);
        out[14] = (a == a);
        out[15] = (a == b);
        out[16] = (a == c);
        out[17] = (a == d);
        out[18] = (a == e);
        out[19] = (b == c);
        out[20] = (b == d);
        out[21] = (b == e);
        out[22] = (c == d);
        out[23] = (c == e);
        out[24] = (d == e);
    end

    initial begin
        out = 25'b0; // Initialize output to zero
    end

endmodule