module TopModule (
    input logic clk,                   // Clock input
    input logic reset,                 // Synchronous reset
    input logic d,                     // 1-bit input: primary data input
    input logic done_counting,         // 1-bit input: signal to indicate counting completion
    input logic ack,                   // 1-bit input: acknowledge signal
    input logic [9:0] state,           // 10-bit input: one-hot encoded state representation
    output logic B3_next,              // 1-bit output: high when next state is B3
    output logic S_next,               // 1-bit output: high when next state is S
    output logic S1_next,              // 1-bit output: high when next state is S1
    output logic Count_next,           // 1-bit output: high when next state is Count
    output logic Wait_next,            // 1-bit output: high when next state is Wait
    output logic done,                 // 1-bit output: high when in Wait state
    output logic counting,             // 1-bit output: high when in Count state
    output logic shift_ena             // 1-bit output: high when in B0, B1, B2, or B3 states
);

    typedef enum logic [9:0] {
        S     = 10'b0000000001,
        S1    = 10'b0000000010,
        S11   = 10'b0000000100,
        S110  = 10'b0000001000,
        B0    = 10'b0000010000,
        B1    = 10'b0000100000,
        B2    = 10'b0001000000,
        B3    = 10'b0010000000,
        Count = 10'b0100000000,
        Wait  = 10'b1000000000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S:     next_state = d ? S1 : S;
            S1:    next_state = d ? S11 : S;
            S11:   next_state = d ? S11 : S110;
            S110:  next_state = d ? B0 : S;
            B0:    next_state = B1;
            B1:    next_state = B2;
            B2:    next_state = B3;
            B3:    next_state = Count;
            Count: next_state = done_counting ? Wait : Count;
            Wait:  next_state = ack ? S : Wait;
            default: next_state = S; // Handle illegal states
        endcase
    end

    // Sequential logic for state register
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S;
        else
            current_state <= next_state;
    end

    // Output logic
    assign shift_ena = (current_state == B0) || (current_state == B1) || 
                       (current_state == B2) || (current_state == B3);
    assign counting = (current_state == Count);
    assign done = (current_state == Wait);

    // Next state outputs
    assign B3_next = (next_state == B3);
    assign S_next = (next_state == S);
    assign S1_next = (next_state == S1);
    assign Count_next = (next_state == Count);
    assign Wait_next = (next_state == Wait);

endmodule