module TopModule(
    input wire p1a,
    input wire p1b,
    input wire p1c,
    input wire p1d,
    input wire p1e,
    input wire p1f,
    input wire p2a,
    input wire p2b,
    input wire p2c,
    input wire p2d,
    output wire p1y,
    output wire p2y
);

    // Intermediate wires for AND gate outputs
    wire and1_p1, and2_p1;
    wire and1_p2, and2_p2;

    // AND gate logic for p1y
    assign and1_p1 = p1a & p1b & p1c;
    assign and2_p1 = p1d & p1e & p1f;
    assign p1y = and1_p1 | and2_p1;

    // AND gate logic for p2y
    assign and1_p2 = p2a & p2b;
    assign and2_p2 = p2c & p2d;
    assign p2y = and1_p2 | and2_p2;

endmodule