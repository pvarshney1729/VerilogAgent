module TopModule (
    input logic in,     // Input signal (1-bit)
    output logic out    // Output signal (1-bit)
);

// Behavioral Description:
// This module implements a combinational NOT gate. 
// The output 'out' is always the logical negation of the input 'in'.

assign out = ~in; // Output is the inverse of the input

endmodule