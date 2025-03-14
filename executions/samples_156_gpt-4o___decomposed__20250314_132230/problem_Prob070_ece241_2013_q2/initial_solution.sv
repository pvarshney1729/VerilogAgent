module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) form for outputs on 2, 7, 15
    // 2 = 0010, 7 = 0111, 15 = 1111
    assign out_sop = (~a & ~b & c & ~d) |  // 2
                     (~a & b & c & d)   |  // 7
                     (a & b & c & d);      // 15

    // Product-of-Sums (POS) form for outputs on 2, 7, 15
    // Remaining outputs are 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | ~c | d) &   // Not 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (a | ~b | ~c | ~d) &
                     (~a | ~b | c | d);

endmodule