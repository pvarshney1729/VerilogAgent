module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    assign out[24] = ~(a ^ a); // Compare `a` with `a`
    assign out[23] = ~(a ^ b); // Compare `a` with `b`
    assign out[22] = ~(a ^ c); // Compare `a` with `c`
    assign out[21] = ~(a ^ d); // Compare `a` with `d`
    assign out[20] = ~(a ^ e); // Compare `a` with `e`
    assign out[19] = ~(b ^ a); // Compare `b` with `a`
    assign out[18] = ~(b ^ b); // Compare `b` with `b`
    assign out[17] = ~(b ^ c); // Compare `b` with `c`
    assign out[16] = ~(b ^ d); // Compare `b` with `d`
    assign out[15] = ~(b ^ e); // Compare `b` with `e`
    assign out[14] = ~(c ^ a); // Compare `c` with `a`
    assign out[13] = ~(c ^ b); // Compare `c` with `b`
    assign out[12] = ~(c ^ c); // Compare `c` with `c`
    assign out[11] = ~(c ^ d); // Compare `c` with `d`
    assign out[10] = ~(c ^ e); // Compare `c` with `e`
    assign out[ 9] = ~(d ^ a); // Compare `d` with `a`
    assign out[ 8] = ~(d ^ b); // Compare `d` with `b`
    assign out[ 7] = ~(d ^ c); // Compare `d` with `c`
    assign out[ 6] = ~(d ^ d); // Compare `d` with `d`
    assign out[ 5] = ~(d ^ e); // Compare `d` with `e`
    assign out[ 4] = ~(e ^ a); // Compare `e` with `a`
    assign out[ 3] = ~(e ^ b); // Compare `e` with `b`
    assign out[ 2] = ~(e ^ c); // Compare `e` with `c`
    assign out[ 1] = ~(e ^ d); // Compare `e` with `d`
    assign out[ 0] = ~(e ^ e); // Compare `e` with `e`

endmodule