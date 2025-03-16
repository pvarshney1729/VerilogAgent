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

    // Combinational logic for next state
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        // State transition logic
        case (state)
            10'b0000000001: begin // S
                if (d) begin
                    S1_next = 1'b1; // Transition to S1
                end else begin
                    S_next = 1'b1; // Stay in S
                end
            end
            10'b0000000010: begin // S1
                if (d) begin
                    S_next = 1'b1; // Transition to S11
                end else begin
                    S1_next = 1'b1; // Transition back to S
                end
            end
            10'b0000000100: begin // S11
                if (d) begin
                    S1_next = 1'b1; // Stay in S11
                end else begin
                    Count_next = 1'b1; // Transition to S110
                end
            end
            10'b0000001000: begin // S110
                if (d) begin
                    B3_next = 1'b1; // Transition to B0
                end else begin
                    S_next = 1'b1; // Transition back to S
                end
            end
            10'b0000010000: begin // B0
                B3_next = 1'b1; // Always go to next cycle
            end
            10'b0000100000: begin // B1
                B3_next = 1'b1; // Always go to next cycle
            end
            10'b0001000000: begin // B2
                B3_next = 1'b1; // Always go to next cycle
            end
            10'b0010000000: begin // B3
                B3_next = 1'b1; // Always go to next cycle
            end
            10'b0100000000: begin // Count
                if (done_counting) begin
                    Wait_next = 1'b1; // Transition to Wait
                end else begin
                    Count_next = 1'b1; // Stay in Count
                end
            end
            10'b1000000000: begin // Wait
                if (ack) begin
                    S_next = 1'b1; // Transition to S
                end else begin
                    Wait_next = 1'b1; // Stay in Wait
                end
            end
        endcase
    end

    // Output logic
    assign done = state[9]; // done is high when in Wait state
    assign counting = state[8]; // counting is high when in Count state
    assign shift_ena = (state[4] || state[5] || state[6] || state[7]); // shift_ena is high in B0, B1, B2, B3 states

endmodule