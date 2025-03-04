module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire out,
    output wire out_n
);

    // Intermediate wires
    wire and1_out, and2_out;

    // Layer 1: AND gates
    assign and1_out = a & b;
    assign and2_out = c & d;

    // Layer 2: OR gate
    assign out = and1_out | and2_out;

    // Inversion for out_n
    assign out_n = ~out;

endmodule