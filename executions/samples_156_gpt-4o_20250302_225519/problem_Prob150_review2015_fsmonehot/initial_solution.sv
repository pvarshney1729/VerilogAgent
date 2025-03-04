module TopModule (
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,
    input logic clk,
    input logic rst_n,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
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
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            S:     if (d) next_state = S1;
            S1:    if (d) next_state = S11;
            S11:   if (!d) next_state = S110;
            S110:  if (!d) next_state = B0;
            B0:    next_state = B1;
            B1:    next_state = B2;
            B2:    next_state = B3;
            B3:    next_state = Count;
            Count: if (done_counting) next_state = Wait;
            Wait:  if (ack) next_state = S;
            default: next_state = S;
        endcase
    end

    // Output logic
    always_comb begin
        B3_next = (next_state == B3);
        S_next = (next_state == S);
        S1_next = (next_state == S1);
        Count_next = (next_state == Count);
        Wait_next = (next_state == Wait);
        done = (current_state == Wait) && ack;
        counting = (current_state == Count);
        shift_ena = (current_state == B0) || (current_state == B1) || (current_state == B2) || (current_state == B3);
    end

endmodule