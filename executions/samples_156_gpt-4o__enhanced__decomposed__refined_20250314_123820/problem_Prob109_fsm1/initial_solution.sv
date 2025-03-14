[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State Encoding
    typedef enum logic {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t current_state, next_state;

    // Synchronous Reset and State Transition Logic
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_B; // Synchronous reset to State B
        end else begin
            current_state <= next_state; // State transition on clock edge
        end
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_B; // Default to State B for safety
        endcase
    end

    // Output Logic
    always_comb begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default to output of State B for safety
        endcase
    end

endmodule
[DONE]