module TopModule(
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out
);
    // Implementing the logic derived from the Karnaugh map
    assign out = (~c & ~d) | (c & ~d & ~a) | (c & d & a) | (~c & d & a);
endmodule