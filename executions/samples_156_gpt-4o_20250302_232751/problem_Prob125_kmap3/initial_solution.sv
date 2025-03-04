module TopModule (
    input wire a,   // Input: 'a', 1-bit, unsigned
    input wire b,   // Input: 'b', 1-bit, unsigned
    input wire c,   // Input: 'c', 1-bit, unsigned
    input wire d,   // Input: 'd', 1-bit, unsigned
    output wire out // Output: 'out', 1-bit, unsigned
);

    // Simplified logic expression derived from the Karnaugh map
    assign out = (~a & b & d) | (a & ~b) | (c & d);

endmodule