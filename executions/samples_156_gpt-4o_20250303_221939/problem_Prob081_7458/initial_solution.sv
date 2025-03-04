module TopModule (
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
    wire and1_out, and2_out, and3_out, and4_out;

    // Implementing the logic for p1y
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    assign p1y = and1_out | and2_out;

    // Implementing the logic for p2y
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;
    assign p2y = and3_out | and4_out;

endmodule