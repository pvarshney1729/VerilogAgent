// Module: TopModule
// Description: This module implements a combinational logic circuit that computes
// the boolean function z = (x ^ y) & x.
// The module is designed for single-bit inputs and output.

module TopModule (
    input logic x, // 1-bit input
    input logic y, // 1-bit input
    output logic z // 1-bit output
);

// Combinational Logic Description:
// The output z is computed as the bitwise AND of x and the bitwise XOR of x and y.
// Truth Table:
// | x | y | x ^ y | (x ^ y) & x | z |
// |---|---|-------|-------------|---|
// | 0 | 0 |   0   |      0      | 0 |
// | 0 | 1 |   1   |      0      | 0 |
// | 1 | 0 |   1   |      1      | 1 |
// | 1 | 1 |   0   |      0      | 0 |

// Implementation:
assign z = (x ^ y) & x;

endmodule