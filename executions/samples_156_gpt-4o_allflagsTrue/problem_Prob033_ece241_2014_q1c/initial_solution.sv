module TopModule(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);

    // Perform the addition
    assign s = a + b;

    // Detect signed overflow
    assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

endmodule