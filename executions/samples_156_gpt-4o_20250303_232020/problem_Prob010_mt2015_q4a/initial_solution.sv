// Module: TopModule
// Description: This module implements a combinational logic function for
// the output z, based on the inputs x and y. The function is defined as:
// z = (x XOR y) AND x

module TopModule (
    input  wire x,  // 1-bit input signal x
    input  wire y,  // 1-bit input signal y
    output wire z   // 1-bit output signal z
);

// Combinational logic implementation
// The module computes the output z as the bitwise AND of x and the bitwise XOR of x and y
assign z = (x ^ y) & x; // The XOR (^) and AND (&) operations are performed on single-bit inputs

endmodule