module TopModule (
    input  wire signed [7:0] a,   // 8-bit signed input
    input  wire signed [7:0] b,   // 8-bit signed input
    output wire signed [7:0] s,   // 8-bit signed output
    output wire overflow          // 1-bit overflow flag
);

    assign s = a + b;

    // Detect signed overflow
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule