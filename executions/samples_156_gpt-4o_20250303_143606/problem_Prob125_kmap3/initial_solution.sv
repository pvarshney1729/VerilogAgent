```verilog
module TopModule (
    input wire a,  // 1-bit input, unsigned
    input wire b,  // 1-bit input, unsigned
    input wire c,  // 1-bit input, unsigned
    input wire d,  // 1-bit input, unsigned
    output wire out // 1-bit output, unsigned
);

    // Simplified logic expression derived from the Karnaugh map
    assign out = (~a & b & c) | (b & ~c) | (a & c);

endmodule
```