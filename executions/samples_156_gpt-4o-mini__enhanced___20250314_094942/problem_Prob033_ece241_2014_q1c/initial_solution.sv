module TopModule (
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output overflow
);
    logic signed [7:0] sum;
    assign sum = a + b;
    assign s = sum;

    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule