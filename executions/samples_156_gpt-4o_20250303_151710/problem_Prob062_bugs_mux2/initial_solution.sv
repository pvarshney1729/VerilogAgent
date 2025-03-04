module TopModule (
    input        sel,        // Single-bit select signal
    input  [7:0] a,          // 8-bit input vector a
    input  [7:0] b,          // 8-bit input vector b
    output [7:0] out         // 8-bit output vector
);

    // The module implements a 2-to-1 multiplexer for 8-bit inputs.
    // When 'sel' is 0, the output 'out' is equal to input 'a'.
    // When 'sel' is 1, the output 'out' is equal to input 'b'.
    // The operation is combinational and does not depend on any clock signal.

    assign out = sel ? b : a;

endmodule