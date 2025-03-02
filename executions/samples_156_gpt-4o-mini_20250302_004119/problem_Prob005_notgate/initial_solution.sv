module TopModule (
    input  logic in,   // Single-bit input, binary (0 or 1)
    output logic out   // Single-bit output, binary (0 or 1)
);
    assign out = ~in; // Logical negation of the input
endmodule