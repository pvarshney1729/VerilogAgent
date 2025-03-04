module TopModule (
    input        sel,       // 1-bit select signal
    input  [7:0] a,         // 8-bit input port
    input  [7:0] b,         // 8-bit input port
    output [7:0] out        // 8-bit output port
);

// Description:
// This module implements a 2-to-1 multiplexer with 8-bit wide data inputs.
// The output 'out' will equal 'a' when 'sel' is 0, and 'b' when 'sel' is 1.

assign out = (sel == 1'b0) ? a : b;

endmodule