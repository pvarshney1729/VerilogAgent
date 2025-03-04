module TopModule (
    input wire a,  // 1-bit input
    input wire b,  // 1-bit input
    input wire c,  // 1-bit input
    input wire d,  // 1-bit input
    output wire out // 1-bit output
);

    assign out = (~c & ~d & b) | (~c & d & ~b) | (c & ~d & b) | (c & d & ~b);

endmodule