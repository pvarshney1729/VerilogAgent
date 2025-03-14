module TopModule (
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

    always @(*) begin
        // Default assignments
        next_state = 10'b0;
        out1 = 1'b0;
        out2 = 1'b0;

        // State transition logic
        if (state[0]) begin
            if (in)
                next_state[1] = 1'b1; // S0 to S1
            else
                next_state[0] = 1'b1; // Stay in S0
        end

        if (state[1]) begin
            if (in)
                next_state[2] = 1'b1; // S1 to S2
            else
                next_state[0] = 1'b1; // S1 to S0
        end

        if (state[2]) begin
            if (in)
                next_state[3] = 1'b1; // S2 to S3
            else
                next_state[0] = 1'b1; // S2 to S0
        end

        if (state[3]) begin
            if (in)
                next_state[4] = 1'b1; // S3 to S4
            else
                next_state[0] = 1'b1; // S3 to S0
        end

        if (state[4]) begin
            if (in)
                next_state[5] = 1'b1; // S4 to S5
            else
                next_state[0] = 1'b1; // S4 to S0
        end

        if (state[5]) begin
            if (in)
                next_state[6] = 1'b1; // S5 to S6
            else
                next_state[8] = 1'b1; // S5 to S8
        end

        if (state[6]) begin
            if (in)
                next_state[7] = 1'b1; // S6 to S7
            else
                next_state[9] = 1'b1; // S6 to S9
        end

        if (state[7]) begin
            out2 = 1'b1; // Output (0, 1) in S7
            if (in)
                next_state[7] = 1'b1; // Stay in S7
            else
                next_state[0] = 1'b1; // S7 to S0
        end

        if (state[8]) begin
            out1 = 1'b1; // Output (1, 0) in S8
            if (in)
                next_state[1] = 1'b1; // S8 to S1
            else
                next_state[0] = 1'b1; // S8 to S0
        end

        if (state[9]) begin
            out1 = 1'b1; // Output (1, 1) in S9
            out2 = 1'b1;
            if (in)
                next_state[1] = 1'b1; // S9 to S1
            else
                next_state[0] = 1'b1; // S9 to S0
        end
    end

endmodule