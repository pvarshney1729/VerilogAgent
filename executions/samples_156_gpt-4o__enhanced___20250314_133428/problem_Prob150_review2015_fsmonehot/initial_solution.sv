module TopModule (
    input logic clk,                // Clock signal
    input logic reset_n,            // Active-low asynchronous reset
    input logic d,                  // 1-bit input
    input logic done_counting,      // 1-bit input
    input logic ack,                // 1-bit input
    input logic [9:0] state,        // 10-bit input, one-hot encoded
    output logic B3_next,           // 1-bit output
    output logic S_next,            // 1-bit output
    output logic S1_next,           // 1-bit output
    output logic Count_next,        // 1-bit output
    output logic Wait_next,         // 1-bit output
    output logic done,              // 1-bit output
    output logic counting,          // 1-bit output
    output logic shift_ena          // 1-bit output
);

    // Next-state logic
    always @(*) begin
        S_next = (state[0] & ~d) | (state[1] & ~d) | (state[9] & ack);
        S1_next = (state[0] & d) | (state[1] & d);
        B3_next = state[6];
        Count_next = (state[7] & ~done_counting);
        Wait_next = (state[8] & done_counting) | (state[9] & ~ack);
    end

    // Output logic
    assign shift_ena = state[4] | state[5] | state[6] | state[7];
    assign counting = state[8];
    assign done = state[9];

endmodule