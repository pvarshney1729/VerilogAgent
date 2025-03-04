// Module: TopModule
// Description: A combinational logic circuit with AND, OR, and NOT gates.
//              This module takes four 1-bit inputs and produces two 1-bit outputs.

module TopModule(
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input
    output logic out,   // 1-bit output: result of OR operation
    output logic out_n  // 1-bit output: inverted result of OR operation
);

// Intermediate signals for connecting gates
logic and1_out; // Output of AND gate connecting inputs a and b
logic and2_out; // Output of AND gate connecting inputs c and d

// Combinational Logic
assign and1_out = a & b; // First AND gate
assign and2_out = c & d; // Second AND gate
assign out = and1_out | and2_out; // OR gate combining outputs of AND gates
assign out_n = ~out; // NOT gate inverting the OR gate output

endmodule