module TopModule (
    input  logic p1a,
    input  logic p1b,
    input  logic p1c,
    input  logic p1d,
    input  logic p2a,
    input  logic p2b,
    input  logic p2c,
    input  logic p2d,
    output logic p1y,
    output logic p2y
);

    // Combinational logic for the first 4-input NAND gate
    always @(*) begin
        p1y = ~(p1a & p1b & p1c & p1d);
    end

    // Combinational logic for the second 4-input NAND gate
    always @(*) begin
        p2y = ~(p2a & p2b & p2c & p2d);
    end

endmodule