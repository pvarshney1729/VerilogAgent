module TopModule (
    input logic d,                // 1-bit input
    input logic done_counting,    // 1-bit input
    input logic ack,              // 1-bit input
    input logic [9:0] state,      // 10-bit input representing the state (one-hot encoded)
    output logic B3_next,         // Assert when next-state is B3 state
    output logic S_next,          // Assert when next-state is S state
    output logic S1_next,         // Assert when next-state is S1 state
    output logic Count_next,      // Assert when next-state is Count state
    output logic Wait_next,       // Assert when next-state is Wait state
    output logic done,            // Assert when operation is complete
    output logic counting,         // Assert when counting is active
    output logic shift_ena        // Assert when shifting is enabled
);

    // Combinational logic for next state and output generation
    always @(*) begin
        // Default outputs
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        // State transitions and output logic
        if (state[0]) begin // S
            if (d) S1_next = 1'b1;
        end else if (state[1]) begin // S1
            if (d) S1_next = 1'b0; // back to S
            else S1_next = 1'b1; // to S11
        end else if (state[2]) begin // S11
            if (d) S1_next = 1'b1; // stay in S11
            else Count_next = 1'b1; // to S110
        end else if (state[3]) begin // S110
            if (d) B3_next = 1'b1; // to B0
            else S_next = 1'b1; // back to S
        end else if (state[4]) begin // B0
            shift_ena = 1'b1; // to B1
        end else if (state[5]) begin // B1
            shift_ena = 1'b1; // to B2
        end else if (state[6]) begin // B2
            shift_ena = 1'b1; // to B3
        end else if (state[7]) begin // B3
            shift_ena = 1'b1; // to Count
        end else if (state[8]) begin // Count
            counting = 1'b1;
            if (done_counting) Wait_next = 1'b1; // to Wait
        end else if (state[9]) begin // Wait
            done = 1'b1;
            if (ack) S_next = 1'b1; // back to S
        end
    end

endmodule