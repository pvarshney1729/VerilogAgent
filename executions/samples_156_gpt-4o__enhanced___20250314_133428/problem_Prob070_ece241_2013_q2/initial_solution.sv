```verilog
module TopModule (
    input wire a,  // 1-bit input, least significant bit (LSB)
    input wire b,  // 1-bit input
    input wire c,  // 1-bit input
    input wire d,  // 1-bit input, most significant bit (MSB)
    output wire out_sop,  // 1-bit output
    output wire out_pos   // 1-bit output
);

    // Sum-of-Products (SOP) form
    assign out_sop = (~d & ~c & b & ~a) | (~d & c & b & a) | (d & c & b & a);

    // Product-of-Sums (POS) form
    assign out_pos = (d | ~c | ~b | a) & (d | c | ~b | ~a) & (~d | ~c | b | a) & (~d | c | b | a);

endmodule
```