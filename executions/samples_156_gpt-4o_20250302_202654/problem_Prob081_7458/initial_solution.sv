module TopModule(
    input logic p1a,  // Single-bit input
    input logic p1b,  // Single-bit input
    input logic p1c,  // Single-bit input
    input logic p1d,  // Single-bit input
    input logic p1e,  // Single-bit input
    input logic p1f,  // Single-bit input
    input logic p2a,  // Single-bit input
    input logic p2b,  // Single-bit input
    input logic p2c,  // Single-bit input
    input logic p2d,  // Single-bit input
    output logic p1y, // Single-bit output
    output logic p2y  // Single-bit output
);

    // Combinational logic for output p1y
    assign p1y = (p1a & p1b & p1c) | (p1d & p1e & p1f);

    // Combinational logic for output p2y
    assign p2y = (p2a & p2b) | (p2c & p2d);

endmodule