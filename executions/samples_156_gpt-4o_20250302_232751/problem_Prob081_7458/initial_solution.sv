module TopModule(
    input logic p1a, p1b, p1c, p1d, p1e, p1f,
    input logic p2a, p2b, p2c, p2d,
    output logic p1y, p2y
);

    // Intermediate wires for AND gate outputs
    logic and1_out, and2_out, and3_out, and4_out;

    // Combinational logic for p1y
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    assign p1y = and1_out | and2_out;

    // Combinational logic for p2y
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;
    assign p2y = and3_out | and4_out;

endmodule