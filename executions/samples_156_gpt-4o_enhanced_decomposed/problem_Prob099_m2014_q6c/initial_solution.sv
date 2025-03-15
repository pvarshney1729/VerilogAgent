module TopModule(
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3,
    output logic Y2,
    output logic Y4
);

    // Output logic
    assign Y1 = y[4]; // Active in state E
    assign Y3 = y[3]; // Active in state D

    // Next state logic
    assign Y2 = (y[0] & ~w) | (y[5] & ~w); // Next state B
    assign Y4 = (y[1] & w) | (y[2] & w) | (y[5] & w); // Next state D

endmodule