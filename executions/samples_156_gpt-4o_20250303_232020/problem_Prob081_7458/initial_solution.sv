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
    wire and1_out = p1a & p1b & p1c;
    wire and2_out = p1d & p1e & p1f;
    wire and3_out = p2a & p2b;
    wire and4_out = p2c & p2d;

    // Assign outputs using OR of intermediate AND gate outputs
    assign p1y = and1_out | and2_out;
    assign p2y = and3_out | and4_out;

endmodule