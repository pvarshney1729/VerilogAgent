module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form
    // Conditions for 2 (0010), 7 (0111), and 15 (1111)
    assign out_sop = (~a & ~b & c & ~d) |  // 2: 0010
                     (~a & b & c & d)   |  // 7: 0111
                     (a & b & c & d);      // 15: 1111

    // Minimum Product-of-Sums (POS) form
    // Conditions for 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
    assign out_pos = (a | b | c | ~d) &  // 0: 0000
                     (a | b | ~c | d) &  // 1: 0001
                     (a | b | ~c | ~d) & // 4: 0100
                     (a | ~b | c | d) &  // 5: 0101
                     (a | ~b | c | ~d) & // 6: 0110
                     (a | ~b | ~c | d) & // 9: 1001
                     (~a | b | c | d) &  // 10: 1010
                     (~a | b | ~c | d) & // 13: 1101
                     (~a | ~b | c | d);  // 14: 1110

endmodule