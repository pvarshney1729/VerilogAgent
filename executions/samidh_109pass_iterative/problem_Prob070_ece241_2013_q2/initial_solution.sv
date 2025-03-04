module TopModule(
    input logic a,  // LSB
    input logic b,
    input logic c,
    input logic d,  // MSB
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form
    assign out_sop = (b & ~c & ~d) | (b & c & d) | (a & b & c & d);

    // Minimum Product-of-Sums (POS) form
    assign out_pos = (~a | ~b | ~c) & (~b | ~c | ~d) & (~a | ~b | ~d);

endmodule