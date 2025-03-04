module TopModule (
    input  wire a,  // 1-bit input
    input  wire b,  // 1-bit input
    input  wire c,  // 1-bit input
    input  wire d,  // 1-bit input
    output wire out // 1-bit output
);

    // Simplified boolean expression using don't-care conditions
    assign out = (b & c) | (~a & b & c);

endmodule