module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);
    // State encoding
    localparam S0 = 3'b000; // Initial state, waiting for 0
    localparam S1 = 3'b001; // Received 0
    localparam S2 = 3'b010; // Received 1 (first)
    localparam S3 = 3'b011; // Received 1 (second)
    localparam S4 = 3'b100; // Received 1 (third)
    localparam S5 = 3'b101; // Received 1 (fourth)
    localparam S6 = 3'b110; // Received 1 (fifth)
    localparam S7 = 3'b111; // Error state (six or more 1s)

    logic [2:0] state, next_state;

    // Synchronous reset logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S0; // Reset to initial state
        end else begin
            state <= next_state; // Transition to next state
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state; // Default to hold state
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S0: begin
                if (in) next_state = S1; // Move to S1 on '1'
            end
            S1: begin
                if (in) next_state = S2; // Move to S2 on '1'
                else next_state = S0; // Move back to S0 on '0'
            end
            S2: begin
                if (in) next_state = S3; // Move to S3 on '1'
                else next_state = S0; // Move back to S0 on '0'
            end
            S3: begin
                if (in) next_state = S4; // Move to S4 on '1'
                else next_state = S0; // Move back to S0 on '0'
            end
            S4: begin
                if (in) next_state = S5; // Move to S5 on '1'
                else next_state = S0; // Move back to S0 on '0'
            end
            S5: begin
                if (in) next_state = S6; // Move to S6 on '1'
                else next_state = S0; // Move back to S0 on '0'
            end
            S6: begin
                if (in) begin
                    next_state = S7; // Move to error state on '1'
                    err = 1'b1; // Signal error
                end else begin
                    next_state = S0; // Move back to S0 on '0'
                    disc = 1'b1; // Signal discard
                end
            end
            S7: begin
                if (in) begin
                    err = 1'b1; // Remain in error state
                end else begin
                    next_state = S0; // Move back to S0 on '0'
                end
            end
        endcase
    end

endmodule