```verilog
module TopModule (
    input logic a, // LSB
    input logic b,
    input logic c,
    input logic d, // MSB
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form
    // out_sop = (a' b c' d) + (a b c d) + (a b c d')
    assign out_sop = (~a & b & ~c & d) | (a & b & c & d) | (a & b & c & ~d);

    // Minimum Product-of-Sums (POS) form
    // out_pos = (a + b' + c + d') (a + b + c' + d) (a' + b + c + d)
    assign out_pos = (a | ~b | c | ~d) & (a | b | ~c | d) & (~a | b | c | d);

endmodule
```