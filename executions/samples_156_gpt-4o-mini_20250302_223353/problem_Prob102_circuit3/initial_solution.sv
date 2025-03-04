module TopModule (
    input logic a,  // Unsigned 1-bit input
    input logic b,  // Unsigned 1-bit input
    input logic c,  // Unsigned 1-bit input
    input logic d,  // Unsigned 1-bit input
    output logic q  // Unsigned 1-bit output
);

    assign q = (b & d) | (c & a) | (c & b);

endmodule