```verilog
module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) form for minterms 2, 7, 15
    assign out_sop = (~a & ~b & c & ~d) |  // 2: 0010
                     (~a & b & c & d)   |  // 7: 0111
                     (a & b & c & d);      // 15: 1111

    // Product-of-Sums (POS) form for maxterms 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | ~c | d) &   // 0: 0000
                     (a | b | ~c | ~d) &  // 1: 0001
                     (a | ~b | c | d) &   // 4: 0100
                     (a | ~b | c | ~d) &  // 5: 0101
                     (a | ~b | ~c | d) &  // 6: 0110
                     (~a | b | c | ~d) &  // 9: 1001
                     (~a | b | ~c | d) &  // 10: 1010
                     (~a | ~b | c | ~d) & // 13: 1101
                     (~a | ~b | ~c | d);  // 14: 1110

endmodule
```