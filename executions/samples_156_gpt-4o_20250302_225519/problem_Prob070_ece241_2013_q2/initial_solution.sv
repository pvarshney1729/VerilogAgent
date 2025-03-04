module TopModule(
    input [3:0] in_bits,
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form for out_sop
    // out_sop = (in_bits == 4'b0010) || (in_bits == 4'b0111) || (in_bits == 4'b1111)
    assign out_sop = (in_bits == 4'b0010) || (in_bits == 4'b0111) || (in_bits == 4'b1111);

    // Minimum Product-of-Sums (POS) form for out_pos
    // out_pos = !( (a + b + !c + !d) * (a + !b + !c + d) * (!a + !b + c + d) )
    // where a = in_bits[3], b = in_bits[2], c = in_bits[1], d = in_bits[0]
    assign out_pos = !((in_bits[3] || in_bits[2] || !in_bits[1] || !in_bits[0]) &&
                       (in_bits[3] || !in_bits[2] || !in_bits[1] || in_bits[0]) &&
                       (!in_bits[3] || !in_bits[2] || in_bits[1] || in_bits[0]));

endmodule