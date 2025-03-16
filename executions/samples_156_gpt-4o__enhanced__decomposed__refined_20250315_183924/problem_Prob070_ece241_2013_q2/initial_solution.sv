module TopModule (
    input [3:0] in,
    output logic out_sop,
    output logic out_pos
);

    // Assign individual bits from the input vector
    logic a, b, c, d;
    assign a = in[3];
    assign b = in[2];
    assign c = in[1];
    assign d = in[0];

    // Minimum Sum-of-Products (SOP) expression for out_sop
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimum Product-of-Sums (POS) expression for out_pos
    assign out_pos = (a | b | c | ~d) & (a | ~b | ~c | d) & (~a | ~b | ~c | ~d);

endmodule