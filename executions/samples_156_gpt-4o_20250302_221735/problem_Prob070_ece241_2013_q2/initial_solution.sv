module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) form
    // Logic-1 for values: 2 (0010), 7 (0111), 15 (1111)
    // Don't care for values: 3 (0011), 8 (1000), 11 (1011), 12 (1100)
    assign out_sop = (~d & ~c & b & ~a) |  // 2 (0010)
                     (~d & c & b & a)   |  // 7 (0111)
                     (d & c & b & a);      // 15 (1111)

    // Product-of-Sums (POS) form
    // Logic-0 for values: 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
    // Don't care for values: 3 (0011), 8 (1000), 11 (1011), 12 (1100)
    assign out_pos = (d | c | ~b | a) &   // 0 (0000), 1 (0001)
                     (d | ~c | b | a) &   // 4 (0100), 5 (0101)
                     (d | ~c | ~b | a) &  // 6 (0110)
                     (~d | c | b | ~a) &  // 9 (1001)
                     (~d | c | ~b | a) &  // 10 (1010)
                     (~d | ~c | b | ~a);  // 13 (1101), 14 (1110)

endmodule