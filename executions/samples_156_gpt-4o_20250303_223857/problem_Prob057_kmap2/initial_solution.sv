```verilog
module TopModule (
    input logic a,  // Input bit 0
    input logic b,  // Input bit 1
    input logic c,  // Input bit 2
    input logic d,  // Input bit 3
    output logic out // Output bit
);

    assign out = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & b & c & ~d) | (~a & b & c & d) |
                 (a & ~b & ~c & ~d) | (a & ~b & c & ~d) | (a & b & ~c & ~d) | (a & b & c & d);

endmodule
```