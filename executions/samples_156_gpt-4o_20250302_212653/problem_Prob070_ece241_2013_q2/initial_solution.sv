module TopModule (
    input logic a,  // LSB
    input logic b,
    input logic c,
    input logic d,  // MSB
    output logic out_sop,
    output logic out_pos
);

    // Minimized Sum-of-Products (SOP) expression
    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);

    // Minimized Product-of-Sums (POS) expression
    assign out_pos = (d | ~c | ~b | a) & (d | c | ~b | ~a) & (~d | c | b | a);

endmodule