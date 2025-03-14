module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);
    assign out[24] = (a == a) ? 1'b1 : 1'b0;  // Comparison of a with itself
    assign out[23] = (a == b) ? 1'b1 : 1'b0;  // Comparison of a with b
    assign out[22] = (a == c) ? 1'b1 : 1'b0;  // Comparison of a with c
    assign out[21] = (a == d) ? 1'b1 : 1'b0;  // Comparison of a with d
    assign out[20] = (a == e) ? 1'b1 : 1'b0;  // Comparison of a with e
    assign out[19] = (b == b) ? 1'b1 : 1'b0;  // Comparison of b with itself
    assign out[18] = (b == c) ? 1'b1 : 1'b0;  // Comparison of b with c
    assign out[17] = (b == d) ? 1'b1 : 1'b0;  // Comparison of b with d
    assign out[16] = (b == e) ? 1'b1 : 1'b0;  // Comparison of b with e
    assign out[15] = (c == c) ? 1'b1 : 1'b0;  // Comparison of c with itself
    assign out[14] = (c == d) ? 1'b1 : 1'b0;  // Comparison of c with d
    assign out[13] = (c == e) ? 1'b1 : 1'b0;  // Comparison of c with e
    assign out[12] = (d == d) ? 1'b1 : 1'b0;  // Comparison of d with itself
    assign out[11] = (d == e) ? 1'b1 : 1'b0;  // Comparison of d with e
    assign out[10] = (e == e) ? 1'b1 : 1'b0;  // Comparison of e with itself
endmodule