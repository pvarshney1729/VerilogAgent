module TopModule (
    logic a,
    logic b,
    logic c,
    logic d,
    logic out
);

    assign out = (~c & ~d) | (~c & b) | (c & ~d & a) | (c & d & ~a);

endmodule