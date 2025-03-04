```verilog
module TopModule (
    input logic a,   // Input: a, 1-bit, unsigned
    input logic b,   // Input: b, 1-bit, unsigned
    input logic c,   // Input: c, 1-bit, unsigned
    input logic d,   // Input: d, 1-bit, unsigned
    output logic out // Output: out, 1-bit, unsigned
);

    // Combinational logic derived from the Karnaugh map:
    assign out = (~c & ~a & b) | (~c & d & ~b) | (c & ~d & b) | (c & a & ~b);
    
endmodule
```