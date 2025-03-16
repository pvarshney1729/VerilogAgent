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
        S1, // Received 1
        S2, // Received 11
        S3, // Received 111
        S4, // Received 1111
        S5, // Received 11111
        S6, // Received 111111
        S7  // Error state (7 or more 1s)
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
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        // Next state logic
        case (state)
            S0: begin
                if (in) next_state = S1; // Received 1
                else next_state = S0; // Stay in S0
            end
            S1: begin
                if (in) next_state = S2; // Received 11
                else next_state = S0; // Reset to S0
            end
            S2: begin
                if (in) next_state = S3; // Received 111
                else next_state = S0; // Reset to S0
            end
            S3: begin
                if (in) next_state = S4; // Received 1111
                else next_state = S0; // Reset to S0
            end
            S4: begin
                if (in) next_state = S5; // Received 11111
                else next_state = S0; // Reset to S0
            end
            S5: begin
                if (in) next_state = S6; // Received 111111
                else next_state = S0; // Reset to S0
            end
            S6: begin
                if (in) begin
                    next_state = S7; // Error state (7 or more 1s)
                    err = 1'b1; // Signal error
                end else begin
                    next_state = S0; // Reset to S0
                end
            end
            S7: begin
                // Stay in error state
                next_state = S7;
                err = 1'b1; // Continue to signal error
            end
            default: next_state = S0; // Default to S0
        endcase

        // Output logic for disc and flag
        if (state == S6) begin
            disc = 1'b1; // Signal to discard
        end else if (state == S6 && in) begin
            flag = 1'b1; // Signal frame flag
        end
    end

endmodule