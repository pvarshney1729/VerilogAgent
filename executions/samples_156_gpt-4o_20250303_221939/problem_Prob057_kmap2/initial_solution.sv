module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

    assign out = (~c & ~d & (~a | b | ~b)) |
                 (~c & d & (~a | ~b)) |
                 (c & d & (b | ~a)) |
                 (c & ~d & ~a & b);

endmodule