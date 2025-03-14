module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);
    // Next-state logic for Y2 (corresponding to y[1])
    logic Y2;
    // Next-state logic for Y4 (corresponding to y[3])
    logic Y4;

    // Logic for next-state signal Y2 based on state transitions
    assign Y2 = (y[0] & w) | (y[2] & ~w) | (y[3] & ~w) | (y[5]);

    // Logic for next-state signal Y4 based on state transitions
    assign Y4 = (y[1] & ~w) | (y[4] & w);

    // Output assignments based on derived logic
    assign Y1 = Y2;
    assign Y3 = Y4;

endmodule