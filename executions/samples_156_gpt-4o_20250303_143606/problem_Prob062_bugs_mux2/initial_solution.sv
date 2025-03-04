```verilog
module Mux2to1_8bit (
    input        sel,        // 1-bit select signal
    input  [7:0] a,          // 8-bit input signal 'a'
    input  [7:0] b,          // 8-bit input signal 'b'
    output [7:0] out         // 8-bit output signal
);

    // Behavioral Description:
    // The module implements a 2-to-1 multiplexer for 8-bit wide inputs.
    // When 'sel' is 0, 'out' is assigned the value of 'a'. 
    // When 'sel' is 1, 'out' is assigned the value of 'b'.
    assign out = sel ? b : a;

endmodule
```