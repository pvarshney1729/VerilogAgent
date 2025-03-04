module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // Output logic for Y1: Transition to state B
    assign Y1 = y[0] & w;

    // Output logic for Y3: Transition to state D
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule