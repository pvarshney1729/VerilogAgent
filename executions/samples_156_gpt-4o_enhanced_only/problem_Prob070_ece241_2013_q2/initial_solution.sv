module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Calculate the output using sum-of-products (SOP) form
    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);

    // Calculate the output using product-of-sums (POS) form
    assign out_pos = (d | c | b | a) & 
                     (d | c | b | ~a) & 
                     (d | ~c | ~b | a) & 
                     (d | ~c | b | ~a) & 
                     (d | ~c | b | a) & 
                     (~d | c | ~b | ~a) & 
                     (~d | c | b | ~a) & 
                     (~d | ~c | b | ~a) & 
                     (~d | ~c | b | a);

endmodule