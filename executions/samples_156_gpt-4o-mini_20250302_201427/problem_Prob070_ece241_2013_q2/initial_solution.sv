module TopModule (
    logic a,
    logic b,
    logic c,
    logic d,
    logic out_sop,
    logic out_pos
);

    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);
    assign out_pos = (d | ~c | ~b | a) & (~d | c | ~b | ~a) & (d | c | ~b | ~a);

endmodule