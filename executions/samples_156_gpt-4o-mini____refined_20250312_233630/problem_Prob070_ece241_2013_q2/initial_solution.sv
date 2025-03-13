module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // out_sop: 2, 7, 15 -> 3'b010, 3'b111, 4'b1111
    assign out_sop = (a & ~b & ~c & d) | (~a & b & c & d) | (a & b & c & d);

    // out_pos: 0, 1, 4, 5, 6, 9, 10, 13, 14 -> 4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110
    assign out_pos = ~(~(a | b | c | d) & ~(a | ~b | ~c | d) & ~(~a | b | ~c | ~d) & ~(~a | ~b | c | ~d) &
                       ~(a | ~b | c | ~d) & ~(~a | b | c | d) & ~(a | b | ~c | d) & ~(a | b | c | ~d));

endmodule