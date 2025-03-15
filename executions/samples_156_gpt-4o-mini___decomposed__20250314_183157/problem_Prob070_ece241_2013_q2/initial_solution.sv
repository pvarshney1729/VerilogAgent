module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

// out_sop (Sum of Products) for 2, 7, 15
assign out_sop = (a & ~b & ~c & d) | (a & b & c & d) | (~a & b & c & d); // 2, 7, 15

// out_pos (Product of Sums) for 0, 1, 4, 5, 6, 9, 10, 13, 14
assign out_pos = (~a | b | c | ~d) & (~a | ~b | c | d) & (~a | ~b | ~c | d) & 
                 (a | ~b | ~c | d) & (a | b | ~c | ~d) & (a | b | c | ~d);

endmodule