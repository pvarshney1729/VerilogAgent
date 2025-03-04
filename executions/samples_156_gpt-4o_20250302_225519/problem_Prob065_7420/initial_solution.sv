module TopModule (
    input wire p1a,  // 1-bit input
    input wire p1b,  // 1-bit input
    input wire p1c,  // 1-bit input
    input wire p1d,  // 1-bit input
    input wire p2a,  // 1-bit input
    input wire p2b,  // 1-bit input
    input wire p2c,  // 1-bit input
    input wire p2d,  // 1-bit input
    output wire p1y, // 1-bit output
    output wire p2y  // 1-bit output
);

    assign p1y = ~(p1a & p1b & p1c & p1d);
    assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule