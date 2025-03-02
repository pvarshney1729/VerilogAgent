module combinational_logic (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum of Products for decimal numbers 2 (0010), 7 (0111), and 15 (1111)
    assign out_sop = (a & ~b & ~c & d) | (~a & b & c & d) | (a & b & c & d);

    // Product of Sums considering don't-care conditions
    // Don't-care conditions can be represented as 'x' in K-map simplification
    assign out_pos = (~a | b | ~c) & (~a | ~b | ~d) & (a | ~b | ~c | ~d);

endmodule