module TopModule (
    input logic a,  // Single-bit input
    input logic b,  // Single-bit input
    input logic c,  // Single-bit input
    input logic d,  // Single-bit input
    output logic out // Single-bit output
);

    assign out = (c & ~d & ~b) | (~c & d & b);

endmodule