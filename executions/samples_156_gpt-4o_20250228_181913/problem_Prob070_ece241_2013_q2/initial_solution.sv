module TopModule (
    input logic a,  // Bit 0 (Least Significant Bit)
    input logic b,  // Bit 1
    input logic c,  // Bit 2
    input logic d,  // Bit 3 (Most Significant Bit)
    output logic out_sop, // Output in minimum sum-of-products form
    output logic out_pos  // Output in minimum product-of-sums form
);

    // Sum-of-Products Expression
    assign out_sop = (d & ~c & ~b & a) | (~d & c & b & a) | (d & c & b & a);

    // Product-of-Sums Expression
    assign out_pos = (d | ~c | b | ~a) & (~d | c | b | a) & (d | c | b | a);

endmodule