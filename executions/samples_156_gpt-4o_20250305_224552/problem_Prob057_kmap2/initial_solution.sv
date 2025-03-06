module TopModule (
    input wire a,    // One-bit input
    input wire b,    // One-bit input
    input wire c,    // One-bit input
    input wire d,    // One-bit input
    output wire out  // One-bit output
);

    // Combinational logic derived from the Karnaugh map
    assign out = (~c & ~d) | (~a & ~b & d) | (a & b & d) | (a & ~b & ~c);

endmodule