module TopModule (
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state, // 10-bit input for one-hot encoded states
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena,
    input logic clk,          // Clock signal for state transitions
    input logic rst_n         // Active-low reset signal
);

    // State transition logic
    always @(*) begin
        // Default next state values
        S_next = 1'b0;
        S1_next = 1'b0;
        B3_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1) // One-hot encoded state machine
            state[0]: begin // S
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            state[1]: begin // S1
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            state[2]: begin // S11
                if (d) S1_next = 1'b1;
                else B3_next = 1'b1;
            end
            state[3]: begin // S110
                if (d) B3_next = 1'b1;
                else S_next = 1'b1;
            end
            state[4]: B3_next = 1'b1; // B0
            state[5]: B3_next = 1'b1; // B1
            state[6]: B3_next = 1'b1; // B2
            state[7]: B3_next = 1'b1; // B3
            state[8]: begin // Count
                if (done_counting) Wait_next = 1'b1;
                else Count_next = 1'b1;
            end
            state[9]: begin // Wait
                if (ack) S_next = 1'b1;
                else Wait_next = 1'b1;
            end
            default: S_next = 1'b1; // Default to S on unexpected state
        endcase
    end

    // Output logic
    always @(*) begin
        shift_ena = |state[4:7]; // Assert shift_ena in B0, B1, B2, B3
        counting = state[8];     // Assert counting in Count
        done = state[9];         // Assert done in Wait
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 10'b0000000001; // Reset to state S
        end else begin
            state <= {Wait_next, Count_next, B3_next, B3_next, B3_next, B3_next, S1_next, S_next};
        end
    end

endmodule