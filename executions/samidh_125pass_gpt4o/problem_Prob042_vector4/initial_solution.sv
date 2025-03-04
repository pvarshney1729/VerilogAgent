module SignExtend8to32 (
    input  logic signed [7:0] in,   // 8-bit signed input
    output logic signed [31:0] out  // 32-bit signed output
);

    // Description:
    // The module performs sign extension on an 8-bit signed input number
    // to produce a 32-bit signed output. The most significant bit (MSB) of the 
    // input is replicated 24 times to preserve the signed value in the extended 
    // form. This is useful for operations that require larger bit-widths while 
    // maintaining the sign of the original number.

    // Implementation:
    // The output is formed by concatenating 24 copies of the sign bit (in[7]) 
    // followed by the original 8-bit input.
    assign out = {{24{in[7]}}, in};

    // Notes:
    // - This implementation assumes the input is a signed 8-bit number and the 
    //   output is a signed 32-bit number.
    // - The module is purely combinational and does not require any clock or reset.
    // - Bit indexing: bit[0] refers to the least significant bit (LSB), and bit[7] 
    //   refers to the most significant bit (MSB) of the input `in`.

endmodule