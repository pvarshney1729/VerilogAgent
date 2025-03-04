module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) minimization
    // Minterms for 2 (0010), 7 (0111), 15 (1111)
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product-of-Sums (POS) minimization
    // Maxterms for 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | ~c | d) & (a | ~b | ~c | ~d) & (~a | b | c | d);

endmodule