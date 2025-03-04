module TopModule (
    input logic a,    // MSB of the input binary number
    input logic b,    // Second MSB
    input logic c,    // Third MSB
    input logic d,    // LSB of the input binary number
    output logic out_sop,  // Output in minimum sum-of-products form
    output logic out_pos   // Output in minimum product-of-sums form
);

    // Sum-of-Products (SOP) form
    // out_sop = (a'b'cd) + (a'bcd) + (abcd)
    assign out_sop = (~a & ~b & c & d) | (~a & b & c & d) | (a & b & c & d);

    // Product-of-Sums (POS) form
    // out_pos = (a + b + ~c + ~d) * (a + ~b + ~c + d) * (~a + ~b + c + d)
    assign out_pos = (a | b | ~c | ~d) & (a | ~b | ~c | d) & (~a | ~b | c | d);

endmodule