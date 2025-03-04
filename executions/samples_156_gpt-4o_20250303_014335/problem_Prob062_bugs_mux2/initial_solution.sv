// Enhanced Specification for an 8-bit 2-to-1 Multiplexer

// Module Interface
module TopModule (
    input logic       sel,    // Selection line, determines output source
    input logic [7:0] a,      // 8-bit input source A
    input logic [7:0] b,      // 8-bit input source B
    output logic [7:0] mux_out // 8-bit output of the multiplexer
);

// Description:
// This module implements an 8-bit 2-to-1 multiplexer. The output 'mux_out' 
// selects between input 'a' and input 'b' based on the control signal 'sel'.
// When 'sel' is low (0), 'mux_out' will output the value of 'a'. 
// When 'sel' is high (1), 'mux_out' will output the value of 'b'.

// Signal Definitions:
// - All signals are unsigned and use little-endian bit ordering (bit[0] is LSB).
// - 'sel' is a single-bit input used to select between data sources 'a' and 'b'.

// Combinational Logic Implementation:
assign mux_out = sel ? b : a;

endmodule