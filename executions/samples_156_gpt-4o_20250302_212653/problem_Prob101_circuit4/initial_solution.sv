module TopModule (
    input logic a,  // Single bit input
    input logic b,  // Single bit input
    input logic c,  // Single bit input
    input logic d,  // Single bit input
    output logic q  // Single bit output
);

assign q = (c & ~a) | (b & ~a) | (a & (b | c));

endmodule