module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    input  logic e,
    output logic [24:0] out
);

    always @(*) begin
        out[24] = (a == a); // Comparison of a with itself
        out[23] = (a == b); // Comparison of a with b
        out[22] = (a == c); // Comparison of a with c
        out[21] = (a == d); // Comparison of a with d
        out[20] = (a == e); // Comparison of a with e
        out[19] = (b == a); // Comparison of b with a
        out[18] = (b == b); // Comparison of b with itself
        out[17] = (b == c); // Comparison of b with c
        out[16] = (b == d); // Comparison of b with d
        out[15] = (b == e); // Comparison of b with e
        out[14] = (c == a); // Comparison of c with a
        out[13] = (c == b); // Comparison of c with b
        out[12] = (c == c); // Comparison of c with itself
        out[11] = (c == d); // Comparison of c with d
        out[10] = (c == e); // Comparison of c with e
        out[ 9] = (d == a); // Comparison of d with a
        out[ 8] = (d == b); // Comparison of d with b
        out[ 7] = (d == c); // Comparison of d with c
        out[ 6] = (d == d); // Comparison of d with itself
        out[ 5] = (d == e); // Comparison of d with e
        out[ 4] = (e == a); // Comparison of e with a
        out[ 3] = (e == b); // Comparison of e with b
        out[ 2] = (e == c); // Comparison of e with c
        out[ 1] = (e == d); // Comparison of e with d
        out[ 0] = (e == e); // Comparison of e with itself
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly