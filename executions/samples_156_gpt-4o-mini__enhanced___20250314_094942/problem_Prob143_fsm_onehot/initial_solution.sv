module TopModule (
    input logic in,                     // Single-bit input
    input logic [9:0] state,           // One-hot encoded current state (state[0]=S0, ..., state[9]=S9)
    output logic [9:0] next_state,      // One-hot encoded next state (next_state[0]=S0, ..., next_state[9]=S9)
    output logic out1,                  // Single-bit output
    output logic out2                   // Single-bit output
);

always @(*) begin
    // Default values
    next_state = 10'b0000000000; // All bits low
    out1 = 1'b0;                 // Default output
    out2 = 1'b0;                 // Default output

    // State transition logic
    case (1'b1) // Only one state should be high in one-hot encoding
        state[0]: begin // S0
            next_state[0] = 1'b1; // Stay in S0
            if (in) next_state[1] = 1'b1; // Transition to S1 on input 1
        end
        state[1]: begin // S1
            if (in) next_state[2] = 1'b1; // Transition to S2 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
        end
        state[2]: begin // S2
            if (in) next_state[3] = 1'b1; // Transition to S3 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
        end
        state[3]: begin // S3
            if (in) next_state[4] = 1'b1; // Transition to S4 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
        end
        state[4]: begin // S4
            if (in) next_state[5] = 1'b1; // Transition to S5 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
        end
        state[5]: begin // S5
            if (in) next_state[6] = 1'b1; // Transition to S6 on input 1
            else next_state[8] = 1'b1; // Transition to S8 on input 0
        end
        state[6]: begin // S6
            if (in) next_state[7] = 1'b1; // Transition to S7 on input 1
            else next_state[9] = 1'b1; // Transition to S9 on input 0
        end
        state[7]: begin // S7
            if (in) next_state[7] = 1'b1; // Stay in S7 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
            out2 = 1'b1; // Output is (0, 1)
        end
        state[8]: begin // S8
            if (in) next_state[1] = 1'b1; // Transition to S1 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
            out1 = 1'b1; // Output is (1, 0)
        end
        state[9]: begin // S9
            if (in) next_state[1] = 1'b1; // Transition to S1 on input 1
            else next_state[0] = 1'b1; // Transition to S0 on input 0
            out2 = 1'b1; // Output is (1, 1)
        end
    endcase
end

endmodule