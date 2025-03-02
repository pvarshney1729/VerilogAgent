module TopModule (
    input logic clk,
    input logic rst,
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,
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
    always @(*) begin
        next_state = S; // Default to S
        case (current_state)
            S:     next_state = (d) ? S1 : S;
            S1:    next_state = (d) ? S11 : S;
            S11:   next_state = (d) ? S11 : S110;
            S110:  next_state = (d) ? B0 : S;
            B0:    next_state = B1;
            B1:    next_state = B2;
            B2:    next_state = B3;
            B3:    next_state = Count;
            Count: next_state = (done_counting) ? Wait : Count;
            Wait:  next_state = (ack) ? S : Wait;
            default: next_state = S;
        endcase
    end

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        // Default outputs
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        case (current_state)
            B0, B1, B2, B3: shift_ena = 1;
            Count: counting = 1;
            Wait: done = 1;
        endcase

        // Next state outputs
        B3_next = (next_state == B3);
        S_next = (next_state == S);
        S1_next = (next_state == S1);
        Count_next = (next_state == Count);
        Wait_next = (next_state == Wait);
    end

endmodule