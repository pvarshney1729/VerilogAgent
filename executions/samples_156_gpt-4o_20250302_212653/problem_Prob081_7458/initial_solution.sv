module TopModule (
    input wire p1a, // Single-bit input
    input wire p1b, // Single-bit input
    input wire p1c, // Single-bit input
    input wire p1d, // Single-bit input
    input wire p1e, // Single-bit input
    input wire p1f, // Single-bit input
    input wire p2a, // Single-bit input
    input wire p2b, // Single-bit input
    input wire p2c, // Single-bit input
    input wire p2d, // Single-bit input
    output wire p1y, // Single-bit output
    output wire p2y  // Single-bit output
);

    // Intermediate signals for AND gate outputs
    wire and1_out, and2_out, and3_out, and4_out;

    // AND gate operations
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;

    // OR gate operations for final outputs
    assign p1y = and1_out | and2_out;
    assign p2y = and3_out | and4_out;

endmodule