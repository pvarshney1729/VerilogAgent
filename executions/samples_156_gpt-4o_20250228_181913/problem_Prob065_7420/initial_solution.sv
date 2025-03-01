```verilog
module TopModule(
    input wire p1a,  // Input to the first NAND gate
    input wire p1b,  // Input to the first NAND gate
    input wire p1c,  // Input to the first NAND gate
    input wire p1d,  // Input to the first NAND gate
    input wire p2a,  // Input to the second NAND gate
    input wire p2b,  // Input to the second NAND gate
    input wire p2c,  // Input to the second NAND gate
    input wire p2d,  // Input to the second NAND gate
    output wire p1y, // Output from the first NAND gate
    output wire p2y  // Output from the second NAND gate
);

    // First 4-input NAND gate
    assign p1y = ~(p1a & p1b & p1c & p1d);

    // Second 4-input NAND gate
    assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule