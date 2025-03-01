module TopModule(
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output overflow
);

    // Perform 8-bit signed addition
    assign s = a + b;

    // Detect signed overflow
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule