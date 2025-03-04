module TopModule(
    input logic x,
    input logic y,
    output logic z
);

    // Combinational logic for output z
    assign z = (~x & ~y) | (x & y);

endmodule