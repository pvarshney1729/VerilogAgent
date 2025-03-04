```verilog
module Mux2to1_8bit (
    input        sel,          // 1-bit selection signal
    input  [7:0] a,            // 8-bit input data bus 'a'
    input  [7:0] b,            // 8-bit input data bus 'b'
    output [7:0] out           // 8-bit output data bus 'out'
);

assign out = sel ? b : a;      // Ternary operator used for clarity

endmodule
```