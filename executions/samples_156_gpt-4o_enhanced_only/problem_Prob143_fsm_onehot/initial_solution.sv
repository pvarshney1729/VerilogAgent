module TopModule(
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

    always @(*) begin
        // Default next_state and outputs
        next_state = 10'b0;
        out1 = 1'b0;
        out2 = 1'b0;

        // State transition and output logic
        if (state[0]) begin
            // S0
            if (in == 1'b0) next_state[0] = 1'b1; // Stay in S0
            else next_state[1] = 1'b1; // Move to S1
        end
        if (state[1]) begin
            // S1
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[2] = 1'b1; // Move to S2
        end
        if (state[2]) begin
            // S2
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[3] = 1'b1; // Move to S3
        end
        if (state[3]) begin
            // S3
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[4] = 1'b1; // Move to S4
        end
        if (state[4]) begin
            // S4
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[5] = 1'b1; // Move to S5
        end
        if (state[5]) begin
            // S5
            if (in == 1'b0) next_state[8] = 1'b1; // Move to S8
            else next_state[6] = 1'b1; // Move to S6
        end
        if (state[6]) begin
            // S6
            if (in == 1'b0) next_state[9] = 1'b1; // Move to S9
            else next_state[7] = 1'b1; // Move to S7
        end
        if (state[7]) begin
            // S7
            out2 = 1'b1; // Output (0, 1)
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[7] = 1'b1; // Stay in S7
        end
        if (state[8]) begin
            // S8
            out1 = 1'b1; // Output (1, 0)
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[1] = 1'b1; // Move to S1
        end
        if (state[9]) begin
            // S9
            out1 = 1'b1; // Output (1, 1)
            out2 = 1'b1;
            if (in == 1'b0) next_state[0] = 1'b1; // Move to S0
            else next_state[1] = 1'b1; // Move to S1
        end
    end
    
endmodule