module TopModule (
    input logic a,  // 1-bit input, MSB
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input, LSB
    output logic out_sop, // 1-bit output in minimum sum-of-products form
    output logic out_pos  // 1-bit output in minimum product-of-sums form
);

    // Minimum Sum-of-Products (SOP) expression
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimum Product-of-Sums (POS) expression
    assign out_pos = (a | b | ~c | d) & (a | ~b | ~c | ~d) & (~a | ~b | c | ~d);

endmodule