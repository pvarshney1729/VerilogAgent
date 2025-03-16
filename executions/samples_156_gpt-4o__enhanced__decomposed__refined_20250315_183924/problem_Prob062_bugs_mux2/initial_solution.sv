```verilog
module Multiplexer2to1 (
    input        sel,    // Select signal: 0 selects input 'a', 1 selects input 'b'
    input  [7:0] a,      // 8-bit input vector 'a'
    input  [7:0] b,      // 8-bit input vector 'b'
    output [7:0] out     // 8-bit output vector 'out'
);

// Combinational logic for 2-to-1 multiplexer
assign out = sel ? b : a;

endmodule
```