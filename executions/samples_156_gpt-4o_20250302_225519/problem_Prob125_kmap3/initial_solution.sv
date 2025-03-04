module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

assign out = (~c & ~d & a) | (~c & d & b) | (c & d) | (c & ~d & a);

endmodule