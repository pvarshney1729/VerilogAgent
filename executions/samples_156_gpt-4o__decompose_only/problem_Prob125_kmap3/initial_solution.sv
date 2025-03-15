module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out
);

    // Simplified logic expression derived from the Karnaugh map
    assign out = (~c & a) | (c & b);

endmodule