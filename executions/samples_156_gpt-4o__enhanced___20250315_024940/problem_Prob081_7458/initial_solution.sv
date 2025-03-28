module TopModule (
    input  logic p1a,
    input  logic p1b,
    input  logic p1c,
    input  logic p1d,
    input  logic p1e,
    input  logic p1f,
    input  logic p2a,
    input  logic p2b,
    input  logic p2c,
    input  logic p2d,
    output logic p1y,
    output logic p2y
);

    // Intermediate signals for the AND gates
    logic and1_out; // Output of first 3-input AND gate
    logic and2_out; // Output of second 3-input AND gate
    logic and3_out; // Output of first 2-input AND gate
    logic and4_out; // Output of second 2-input AND gate

    // Two 3-input AND gates for p1y
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;

    // OR the outputs of the two AND gates for p1y
    assign p1y = and1_out | and2_out;

    // Two 2-input AND gates for p2y
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;

    // OR the outputs of the two AND gates for p2y
    assign p2y = and3_out | and4_out;

endmodule