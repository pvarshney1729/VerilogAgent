module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0,  // Initial state
        S1,  // After one '1'
        S2,  // After two '1's
        S3,  // After three '1's
        S4,  // After four '1's
        S5,  // After five '1's
        S6,  // After six '1's
        S7   // Error state (seven or more '1's)
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        next_state = current_state;

        case (current_state)
            S0: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S0;
            end
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S0;
                    disc = 1'b1; // 0111110 detected
                end
            end
            S7: begin
                if (in) begin
                    next_state = S7; // Remain in error state
                    err = 1'b1; // 01111111... detected
                end else begin
                    next_state = S0;
                    flag = 1'b1; // 01111110 detected
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule