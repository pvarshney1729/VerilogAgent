module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Generate out_sop (minimum sum-of-products form)
    assign out_sop = (d & c & b & a) |         // Decimal 15
                     (1'b0 & c & b & a) |     // Decimal 2
                     (d & 1'b0 & 1'b1 & 1'b1); // Decimal 7

    // Generate out_pos (minimum product-of-sums form)
    assign out_pos = (d | c | ~b | ~a) &        // Not 0
                     (d | c | ~b | a) &        // Not 1
                     (~d | c | b | ~a) &       // Not 4
                     (~d | c | b | a) &        // Not 5
                     (~d | ~c | b | a) &       // Not 6
                     (d | ~c | ~b | a) &       // Not 9
                     (d | ~c | b | ~a) &       // Not 10
                     (d | c | ~b | ~a) &       // Not 13
                     (d | c | b | ~a);         // Not 14

endmodule