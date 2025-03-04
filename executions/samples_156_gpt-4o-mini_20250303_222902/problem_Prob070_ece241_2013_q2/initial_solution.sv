module TopModule (
    input logic a,    // LSB of 4-bit input
    input logic b,    // Second bit of 4-bit input
    input logic c,    // Third bit of 4-bit input
    input logic d,    // MSB of 4-bit input
    output logic out_sop, // Output in minimum sum-of-products form
    output logic out_pos  // Output in minimum product-of-sums form
);

    // Sum-of-Products (SOP) logic for out_sop
    assign out_sop = (d == 1 && c == 1 && b == 1 && a == 1) || // 15
                     (d == 0 && c == 1 && b == 1 && a == 1) || // 7
                     (d == 0 && c == 0 && b == 1 && a == 0);   // 2

    // Product-of-Sums (POS) logic for out_pos
    assign out_pos = (d || c || b || !a) && // 0
                     (d || c || !b || !a) && // 1
                     (d || !c || b || !a) && // 4
                     (d || !c || !b || a) && // 5
                     (d || !c || !b || !a) && // 6
                     (!d || c || !b || a) && // 9
                     (!d || !c || b || a) && // 10
                     (!d || c || b || !a) && // 13
                     (!d || c || !b || !a);  // 14

endmodule