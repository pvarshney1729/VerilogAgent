module TopModule(
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // Output logic
    assign Y1 = y[4] | y[5]; // High in states E or F
    assign Y3 = (y[1] & ~w) | (y[2] & w); // High when transitioning from B to C or C to D

    // Next-state logic for Y2 and Y4
    logic Y2, Y4;
    assign Y2 = (y[0] & ~w) | (y[2] & ~w); // Next state for y[1]
    assign Y4 = (y[1] & w) | (y[2] & w) | (y[4] & w); // Next state for y[3]

endmodule