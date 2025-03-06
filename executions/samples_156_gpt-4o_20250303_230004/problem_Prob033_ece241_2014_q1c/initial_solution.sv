module TopModule(
    input signed [7:0] a,
    input signed [7:0] b,
    output [7:0] s,
    output overflow
);

    assign s = a + b;

    assign overflow = ((a[7] == 0 && b[7] == 0 && s[7] == 1) ||
                       (a[7] == 1 && b[7] == 1 && s[7] == 0));

endmodule