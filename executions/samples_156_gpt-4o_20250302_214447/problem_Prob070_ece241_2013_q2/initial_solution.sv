```verilog
module TopModule(
    input logic a, // 1-bit input
    input logic b, // 1-bit input
    input logic c, // 1-bit input
    input logic d, // 1-bit input
    output logic out_sop, // 1-bit output for SOP
    output logic out_pos  // 1-bit output for POS
);

    // Minimum Sum-of-Products (SOP) form
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimum Product-of-Sums (POS) form
    assign out_pos = (a | ~b | ~c | d) & (~a | b | ~c | ~d) & (a | b | c | d);

endmodule
```