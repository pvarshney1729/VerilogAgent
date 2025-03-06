module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out_sop,
    output wire out_pos
);

    // Sum-of-Products (SOP) form
    // Minimize for: 2 (0010), 7 (0111), 15 (1111)
    // Don't cares: 3 (0011), 8 (1000), 11 (1011), 12 (1100)
    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);

    // Product-of-Sums (POS) form
    // Minimize for: 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
    // Don't cares: 3 (0011), 8 (1000), 11 (1011), 12 (1100)
    assign out_pos = (d | ~c | ~b | a) & (d | c | ~b | ~a) & (~d | c | b | a);

endmodule