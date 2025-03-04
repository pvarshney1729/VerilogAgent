module TopModule (
    input  logic in1,  // Single-bit input
    input  logic in2,  // Single-bit input, inverted in logic
    output logic out   // Single-bit output
);

    assign out = in1 & ~in2;

endmodule