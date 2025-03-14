module TopModule (
    input logic a,      // Input signal a (1-bit)
    input logic b,      // Input signal b (1-bit)
    input logic c,      // Input signal c (1-bit)
    input logic d,      // Input signal d (1-bit)
    output logic out,   // Output signal out (1-bit)
    output logic out_n   // Inverted output signal out_n (1-bit)
);

// Intermediate wires to connect AND and OR gates
logic and1_out; // Output of AND gate 1 (a AND b)
logic and2_out; // Output of AND gate 2 (c AND d)

// Combinational Logic Implementation
assign and1_out = a & b;     // AND gate 1: a AND b
assign and2_out = c & d;     // AND gate 2: c AND d
assign out = and1_out | and2_out;  // OR gate: out = (a AND b) OR (c AND d)
assign out_n = ~out;         // NOT gate: out_n = NOT out

endmodule