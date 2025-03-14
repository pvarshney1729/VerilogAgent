module TopModule(
    input  [5:0] y,
    input        w,
    output       Y1,
    output       Y2,
    output       Y3,
    output       Y4
);

    // Next-state logic for Y2 (state B: y[1])
    assign Y2 = y[0] & ~w; // Transition to state B from A on 0

    // Next-state logic for Y4 (state D: y[3])
    assign Y4 = (y[1] & w) | (y[2] & w) | (y[4] & w) | (y[5] & w); // Transition to state D from B, C, E, F on 1

    // Y1 and Y3 are not defined in the specification
    assign Y1 = 1'b0; // Placeholder for undefined functionality
    assign Y3 = 1'b0; // Placeholder for undefined functionality

endmodule