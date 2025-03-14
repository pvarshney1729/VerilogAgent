module TopModule (
    input logic p1a,  // Input signal A1 (1-bit)
    input logic p1b,  // Input signal A2 (1-bit)
    input logic p1c,  // Input signal A3 (1-bit)
    input logic p1d,  // Input signal A4 (1-bit)
    input logic p2a,  // Input signal B1 (1-bit)
    input logic p2b,  // Input signal B2 (1-bit)
    input logic p2c,  // Input signal B3 (1-bit)
    input logic p2d,  // Input signal B4 (1-bit)
    output logic p1y, // Output signal for the first NAND gate (1-bit)
    output logic p2y  // Output signal for the second NAND gate (1-bit)
);

    // Combinational Logic: The functionality of the module mirrors two 4-input NAND gates.
    assign p1y = ~(p1a & p1b & p1c & p1d); // NAND operation for the first gate
    assign p2y = ~(p2a & p2b & p2c & p2d); // NAND operation for the second gate

endmodule