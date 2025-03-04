// Module: TopModule
// Description: This module takes an 8-bit input and outputs the input bits in reversed order.

module TopModule (
    input logic [7:0] in,   // 8-bit wide input port
    output logic [7:0] out  // 8-bit wide output port
);

// Behavioral Description:
// The module is purely combinational and reverses the bit order of the input.
// Bit[0] indicates the least significant bit (LSB) and Bit[7] the most significant bit (MSB).

// Implementation Details:
// The operation does not depend on any clock signal, thus it is purely combinational.
// There is no reset or initial state for this module as it does not contain any storage elements.

assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};

// Note: The assignment above reverses the bit order from MSB to LSB.
// Example: If `in` = 8'b10110011, then `out` = 8'b11001101.

endmodule