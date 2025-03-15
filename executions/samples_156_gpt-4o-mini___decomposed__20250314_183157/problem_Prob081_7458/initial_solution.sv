module TopModule (
    input logic p1a,
    input logic p1b,
    input logic p1c,
    input logic p1d,
    input logic p1e,
    input logic p1f,
    input logic p2a,
    input logic p2b,
    input logic p2c,
    input logic p2d,
    output logic p1y,
    output logic p2y
);

logic and1_out, and2_out, and3_out, and4_out;

assign and1_out = p1a & p1b & p1c; // 3-input AND
assign and2_out = p1d & p1e & p1f; // 3-input AND
assign p1y = and1_out | and2_out;   // OR of two 3-input ANDs

assign and3_out = p2a & p2b;       // 2-input AND
assign and4_out = p2c & p2d;       // 2-input AND
assign p2y = and3_out | and4_out;   // OR of two 2-input ANDs

endmodule