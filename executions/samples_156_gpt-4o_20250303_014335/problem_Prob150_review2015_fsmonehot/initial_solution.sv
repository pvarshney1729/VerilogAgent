module TopModule (
    input logic clk,                 // Clock signal for sequential logic
    input logic reset,               // Active-high reset signal
    input logic d,                   // Data input
    input logic done_counting,       // Input signal indicating counting completion
    input logic ack,                 // Acknowledge signal
    input logic [9:0] state,         // One-hot encoded state input (10 bits)
    output logic B3_next,            // Next state is B3 state
    output logic S_next,             // Next state is S state
    output logic S1_next,            // Next state is S1 state
    output logic Count_next,         // Next state is Count state
    output logic Wait_next,          // Next state is Wait state
    output logic done,               // Output signal indicating completion
    output logic counting,           // Output signal indicating counting in progress
    output logic shift_ena           // Output signal enabling shift operation
);

    // State Transitions and Output Logic
    always @(*) begin
        S_next    = (state[0] & ~d) | (state[1] & ~d) | (state[7] & ack);
        S1_next   = (state[0] & d) | (state[1] & d);
        B3_next   = state[6];
        Count_next = state[7];
        Wait_next  = (state[8] & done_counting);

        done      = state[9];
        counting  = state[8];
        shift_ena = state[4] | state[5] | state[6] | state[7];
    end

endmodule