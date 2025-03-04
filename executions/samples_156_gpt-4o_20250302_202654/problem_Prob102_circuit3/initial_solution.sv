module TopModule (
    input  logic a, // 1-bit input, assumed unsigned
    input  logic b, // 1-bit input, assumed unsigned
    input  logic c, // 1-bit input, assumed unsigned
    input  logic d, // 1-bit input, assumed unsigned
    output logic q  // 1-bit output, assumed unsigned
);

    assign q = (b & d) | (a & d) | (b & c);

endmodule