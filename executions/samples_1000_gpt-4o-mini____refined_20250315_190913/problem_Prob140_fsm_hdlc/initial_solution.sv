module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Received 0
        S2, // Received 1 (1st)
        S3, // Received 1 (2nd)
        S4, // Received 1 (3rd)
        S5, // Received 1 (4th)
        S6, // Received 1 (5th)
        S7, // Received 1 (6th)
        S8  // Error state (7 or more 1s)
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S0: begin
                if (in) next_state = S2; // Start of 1s
            end
            S1: begin
                if (in) next_state = S2; // Start of 1s
                else next_state = S0;    // Back to initial
            end
            S2: begin
                if (in) next_state = S3; // 1st 1
                else next_state = S1;    // 0 after 1
            end
            S3: begin
                if (in) next_state = S4; // 2nd 1
                else next_state = S1;    // 0 after 2
            end
            S4: begin
                if (in) next_state = S5; // 3rd 1
                else next_state = S1;    // 0 after 3
            end
            S5: begin
                if (in) next_state = S6; // 4th 1
                else next_state = S1;    // 0 after 4
            end
            S6: begin
                if (in) next_state = S7; // 5th 1
                else next_state = S1;    // 0 after 5
            end
            S7: begin
                if (in) next_state = S8; // 6th 1 (error state)
                else begin
                    disc = 1'b1;          // Discard the 0 after 5 1s
                    next_state = S1;     // Go back to initial
                end
            end
            S8: begin
                err = 1'b1;               // Error state
                if (!in) next_state = S1; // Reset on 0
            end
        endcase

        // Flagging the frame
        if (state == S7 && in) begin
            flag = 1'b1; // Flagging the frame
        end
    end

endmodule