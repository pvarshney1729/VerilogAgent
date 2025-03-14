module TopModule (
    input  logic [7:0] in,  // Input signal (8 bits), unsigned representation
    output logic [31:0] out // Output signal (32 bits), signed representation
);

// Behavioral Description:
// This module implements a combinational logic circuit that sign-extends 
// the 8-bit input 'in' to a 32-bit output 'out'. The most significant bit 
// (MSB) of the input (in[7]) is used as the sign bit for sign extension.
// The output is constructed by concatenating 24 copies of in[7] with 
// the 8-bit input 'in'.

assign out = { {24{in[7]}}, in }; // Sign-extend the 8-bit input to 32 bits

endmodule