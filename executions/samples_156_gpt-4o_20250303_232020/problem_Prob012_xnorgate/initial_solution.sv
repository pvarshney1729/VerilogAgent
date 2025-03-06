// Module Name: XnorGateModule
// Description: This module implements a 1-bit XNOR gate.
// All operations are purely combinational with no sequential logic involved.

module XnorGateModule (
    input logic a,    // 1-bit input signal 'a'
    input logic b,    // 1-bit input signal 'b'
    output logic out  // 1-bit output signal 'out'
);

// Combinational Logic:
// The output 'out' is the XNOR of inputs 'a' and 'b'.
// XNOR truth table: out = 1 if a == b, otherwise out = 0.
assign out = ~(a ^ b);

endmodule