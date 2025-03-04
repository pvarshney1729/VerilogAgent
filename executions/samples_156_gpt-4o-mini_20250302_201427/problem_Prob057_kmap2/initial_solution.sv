module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);
    assign out = (~c & ~d) | (~c & b) | (c & d & a) | (c & ~d & ~a);
endmodule