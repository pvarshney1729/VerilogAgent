module TopModule (
    input logic p1a, p1b, p1c, p1d,
    input logic p2a, p2b, p2c, p2d,
    output logic p1y,
    output logic p2y
);

    // Combinational logic for the first 4-input NAND gate
    assign p1y = ~(p1a & p1b & p1c & p1d);

    // Combinational logic for the second 4-input NAND gate
    assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule