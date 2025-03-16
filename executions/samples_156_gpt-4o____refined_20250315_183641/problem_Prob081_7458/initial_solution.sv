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

    // Intermediate signals for AND gates
    logic and1_out, and2_out, and3_out, and4_out;

    // AND gate implementations
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;

    // OR gate implementations
    assign p1y = and1_out | and2_out;
    assign p2y = and3_out | and4_out;

endmodule