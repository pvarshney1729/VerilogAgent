module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    // Combinational logic derived from the Karnaugh map
    assign out = (~c & ~d) | (~c & b) | (c & ~d & ~b) | (c & d);

endmodule