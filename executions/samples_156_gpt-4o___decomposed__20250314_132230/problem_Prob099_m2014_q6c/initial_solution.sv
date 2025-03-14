module TopModule (
    input  [5:0] y,  // 6-bit input representing the current state in one-hot encoding
    input        w,  // 1-bit input
    output logic Y1, // 1-bit output
    output logic Y3  // 1-bit output
);

    // Logic for Y1: Corresponds to y[1] (State B)
    assign Y1 = (y[0] & ~w); // Transition to B from A on w = 0

    // Logic for Y3: Corresponds to y[3] (State D)
    assign Y3 = (y[1] & w) | (y[2] & w) | (y[4] & w) | (y[5] & w); // Transitions to D from B, C, E, F on w = 1

endmodule