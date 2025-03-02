module TopModule (
    input logic p1a,  // 1-bit input
    input logic p1b,  // 1-bit input
    input logic p1c,  // 1-bit input
    input logic p1d,  // 1-bit input
    input logic p2a,  // 1-bit input
    input logic p2b,  // 1-bit input
    input logic p2c,  // 1-bit input
    input logic p2d,  // 1-bit input
    output logic p1y, // 1-bit output
    output logic p2y  // 1-bit output
);

assign p1y = ~(p1a & p1b & p1c & p1d);
assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule