module TopModule(
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

    // Next state logic
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

        // State transitions based on current state and inputs
        if (state[0]) begin // State S
            if (d) begin
                S1_next = 1'b1; // Go to S1
            end else begin
                S_next = 1'b1; // Stay in S
            end
        end else if (state[1]) begin // State S1
            if (d) begin
                S_next = 1'b0; // Go to S11
            end else begin
                S_next = 1'b1; // Go back to S
            end
        end else if (state[2]) begin // State S11
            if (d) begin
                S1_next = 1'b0; // Stay in S11
            end else begin
                Count_next = 1'b1; // Go to S110
            end
        end else if (state[3]) begin // State S110
            if (d) begin
                B3_next = 1'b1; // Go to B0
            end else begin
                S_next = 1'b1; // Go back to S
            end
        end else if (state[4]) begin // State B0
            shift_ena = 1'b1; // Always go to B1
        end else if (state[5]) begin // State B1
            shift_ena = 1'b1; // Always go to B2
        end else if (state[6]) begin // State B2
            shift_ena = 1'b1; // Always go to B3
        end else if (state[7]) begin // State B3
            shift_ena = 1'b1; // Always go to Count
        end else if (state[8]) begin // State Count
            counting = 1'b1; // Counting is enabled
            if (done_counting) begin
                Wait_next = 1'b1; // Go to Wait on done_counting = 1
            end else begin
                Count_next = 1'b1; // Stay in Count
            end
        end else if (state[9]) begin // State Wait
            done = 1'b1; // Done output is asserted
            if (ack) begin
                S_next = 1'b1; // Go to S on ack = 1
            end else begin
                Wait_next = 1'b1; // Stay in Wait
            end
        end
    end

endmodule