module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    assign out = (~c & ~d) | (~c & d & ~b) | (~c & b & ~a) | (~c & ~b & ~d) | (c & ~d & a) | (c & b & a) | (c & ~b & d);

endmodule