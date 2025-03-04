module TopModule (
    input  wire [3:0] in_bits,    // 4-bit input representing a, b, c, d collectively
    output wire       out_sop,    // Sum-of-products form output
    output wire       out_pos     // Product-of-sums form output
);

    // Sum-of-Products (SOP) form
    assign out_sop = (in_bits == 4'b0010) | (in_bits == 4'b0111) | (in_bits == 4'b1111);

    // Product-of-Sums (POS) form
    assign out_pos = ~((in_bits[3] | in_bits[2] | ~in_bits[1] | in_bits[0]) & 
                       (in_bits[3] | ~in_bits[2] | in_bits[1] | in_bits[0]) & 
                       (~in_bits[3] | ~in_bits[2] | in_bits[1] | ~in_bits[0]));

endmodule