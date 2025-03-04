module TopModule (
    input logic a,  // LSB of input vector
    input logic b,
    input logic c,
    input logic d,  // MSB of input vector
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) form
    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);

    // Product-of-Sums (POS) form
    assign out_pos = (d | ~c | a) & (d | ~b | ~a) & (~d | c | ~b | a);

endmodule