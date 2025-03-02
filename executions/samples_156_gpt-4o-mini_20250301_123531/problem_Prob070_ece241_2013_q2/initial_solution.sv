module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) expression
    assign out_sop = (a & ~b & c & ~d) | (a & b & c & d) | (d & c);

    // Product-of-Sums (POS) expression
    assign out_pos = (~a | ~b | ~c | ~d) & (~a | ~b | c | d) & (~a | b | ~c | d) & (a | ~b | ~c | ~d);

endmodule