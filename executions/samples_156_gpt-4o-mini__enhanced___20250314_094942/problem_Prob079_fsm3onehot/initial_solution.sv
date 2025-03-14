module TopModule (
    input logic in,            // One-bit input signal
    input logic [3:0] state,  // 4-bit input representing current state (one-hot encoding)
    output logic [3:0] next_state, // 4-bit output representing next state (one-hot encoding)
    output logic out          // One-bit output signal
);

// Implementing the combinational logic for next_state and output
assign next_state = (state[0] & ~in) ? state : // State A
                    (state[1] & ~in) ? 4'b0100 : // State B to C
                    (state[1] & in)  ? state : // State B remains B
                    (state[2] & ~in) ? 4'b0001 : // State C to A
                    (state[2] & in)  ? 4'b1000 : // State C to D
                    (state[3] & ~in) ? 4'b0100 : // State D to C
                                     (state[1] & in) ? state : // State D to B
                                     4'b0000; // Default case, invalid state

assign out = (state[3] & in) ? 1'b1 : 1'b0; // Only output 1 when in state D and input is 1

endmodule