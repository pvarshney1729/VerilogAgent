module TopModule (
    input [5:0] y,  // State encoding
    input w,        // Input signal
    output logic Y1, // Output signal
    output logic Y3  // Output signal
);

    // Logic for output Y1: High for states E and F
    assign Y1 = y[4] | y[5];

    // Logic for output Y3: High for transitions to state D
    assign Y3 = (y[1] & w) | (y[2] & w) | (y[4] & ~w) | (y[5] & w);

    // Logic for next-state signal Y2 (corresponding to y[1])
    logic Y2;
    assign Y2 = (y[0] & ~w) | (y[2] & ~w);

    // Logic for next-state signal Y4 (corresponding to y[3])
    logic Y4;
    assign Y4 = (y[1] & w) | (y[2] & ~w) | (y[4] & w);

endmodule