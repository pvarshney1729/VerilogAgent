module TopModule (
    input logic a, // Least Significant Bit
    input logic b,
    input logic c,
    input logic d, // Most Significant Bit
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) for out_sop
    // Logic-1 for 2 (0010), 7 (0111), 15 (1111)
    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);

    // Minimum Product-of-Sums (POS) for out_pos
    // Logic-0 for 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
    assign out_pos = (d | c | ~b | a) & (d | ~c | b | a) & (d | ~c | b | ~a) & (~d | c | ~b | a) &
                     (~d | c | ~b | ~a) & (~d | ~c | b | a) & (~d | ~c | b | ~a);

endmodule