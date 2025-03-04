module TopModule (
    input  wire p1a,  // Input to first 4-input NAND gate
    input  wire p1b,  // Input to first 4-input NAND gate
    input  wire p1c,  // Input to first 4-input NAND gate
    input  wire p1d,  // Input to first 4-input NAND gate
    input  wire p2a,  // Input to second 4-input NAND gate
    input  wire p2b,  // Input to second 4-input NAND gate
    input  wire p2c,  // Input to second 4-input NAND gate
    input  wire p2d,  // Input to second 4-input NAND gate
    output wire p1y,  // Output from first 4-input NAND gate
    output wire p2y   // Output from second 4-input NAND gate
);

    // Implementing the first 4-input NAND gate
    assign p1y = ~(p1a & p1b & p1c & p1d);

    // Implementing the second 4-input NAND gate
    assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule