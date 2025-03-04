module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input
    output logic out // 1-bit output
);

    // Implementing the simplified Boolean expression
    assign out = (c & ~d) ^ (a & b);

endmodule