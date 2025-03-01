```verilog
module Mux2to1_8bit (
    input        sel,      // Selection signal: 0 selects input `a`, 1 selects input `b`.
    input  [7:0] a,        // 8-bit input vector `a`
    input  [7:0] b,        // 8-bit input vector `b`
    output [7:0] out       // 8-bit output vector
);

assign out = sel ? b : a;

endmodule
```