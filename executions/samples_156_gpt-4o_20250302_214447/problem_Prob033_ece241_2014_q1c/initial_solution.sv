module TopModule(
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output logic overflow
);

    assign s = a + b;

    // Overflow detection logic
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule