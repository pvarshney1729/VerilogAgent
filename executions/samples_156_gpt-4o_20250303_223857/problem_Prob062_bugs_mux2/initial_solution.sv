```verilog
module TopModule (
    input        sel,        // 1-bit selection signal
    input  [7:0] a,          // 8-bit input vector a
    input  [7:0] b,          // 8-bit input vector b
    output [7:0] out         // 8-bit output vector out
);

// Functionality: 
// This module implements a combinational 8-bit 2-to-1 multiplexer. 
// When `sel` is '0', `out` is equal to `a`.
// When `sel` is '1', `out` is equal to `b`.

assign out = (sel == 1'b0) ? a : b;

endmodule
```