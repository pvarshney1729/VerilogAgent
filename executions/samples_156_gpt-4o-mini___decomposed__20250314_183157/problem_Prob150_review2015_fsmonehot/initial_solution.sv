module TopModule (
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

    always @(*) begin
        // Default values for outputs
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        case (state)
            10'b0000000001: begin // State S
                S_next = 1;
                if (d) S1_next = 1;
            end
            10'b0000000010: begin // State S1
                if (d) begin
                    S1_next = 0; // Transition to S11
                end else begin
                    S_next = 1; // Transition to S
                end
            end
            10'b0000000100: begin // State S11
                if (d) begin
                    // Stay in S11
                end else begin
                    S110_next = 1; // Transition to S110
                end
            end
            10'b0000001000: begin // State S110
                if (d) B0_next = 1; // Transition to B0
                else S_next = 1; // Transition to S
            end
            10'b0000010000: begin // State B0
                shift_ena = 1; // Always go to B1
            end
            10'b0000100000: begin // State B1
                shift_ena = 1; // Always go to B2
            end
            10'b0001000000: begin // State B2
                shift_ena = 1; // Always go to B3
            end
            10'b0010000000: begin // State B3
                shift_ena = 1; // Always go to Count
            end
            10'b0100000000: begin // State Count
                counting = 1;
                if (done_counting) Wait_next = 1; // Transition to Wait
            end
            10'b1000000000: begin // State Wait
                done = 1;
                if (ack) S_next = 1; // Transition to S
            end
        endcase
    end

endmodule