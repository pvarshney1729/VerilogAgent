module TopModule (
    input logic a,   // Unsigned 1-bit input
    input logic b,   // Unsigned 1-bit input
    input logic c,   // Unsigned 1-bit input
    input logic d,   // Unsigned 1-bit input
    output logic out,    // Unsigned 1-bit output
    output logic out_n   // Unsigned 1-bit output, inverted version of 'out'
);

    logic and1_out; // Intermediate wire for the output of the first AND gate
    logic and2_out; // Intermediate wire for the output of the second AND gate

    // Layer 1: AND gates
    assign and1_out = a & b; // AND gate connected to inputs a and b
    assign and2_out = c & d; // AND gate connected to inputs c and d

    // Layer 2: OR gate
    assign out = and1_out | and2_out; // OR gate combining outputs of the AND gates

    // Inverted output
    assign out_n = ~out; // NOT gate inverting the output

endmodule