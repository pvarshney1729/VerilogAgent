module TopModule (
    input [5:0] y, // 6-bit one-hot encoded state input
    input wire w,  // 1-bit input signal for transitions
    output wire Y1, // 1-bit output connected to the input of state flip-flop y[1]
    output wire Y3  // 1-bit output connected to the input of state flip-flop y[3]
);

    // Combinational logic for next state transitions
    assign Y1 = (y[0] & w) | (y[5] & w); // Transition to state B
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w); // Transition to state D

endmodule