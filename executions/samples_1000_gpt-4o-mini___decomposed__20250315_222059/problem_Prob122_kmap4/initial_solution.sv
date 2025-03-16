module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);
    assign out = (~c & d & ~b) | (c & ~d & b) | (c & d & ~a) | (a & ~b & ~d) | (a & b & ~c);
endmodule