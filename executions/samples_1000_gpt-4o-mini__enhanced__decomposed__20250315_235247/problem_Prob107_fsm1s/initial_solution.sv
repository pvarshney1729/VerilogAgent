module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);
    typedef enum logic [1:0] {B, A} state_t;
    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) 
            current_state <= B;
        else 
            current_state <= next_state;
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            B: begin
                out = 1'b1; // Output for state B
                if (in) 
                    next_state = B; // Stay in B
                else 
                    next_state = A; // Transition to A
            end
            A: begin
                out = 1'b0; // Output for state A
                if (in) 
                    next_state = A; // Stay in A
                else 
                    next_state = B; // Transition to B
            end
            default: begin
                out = 1'b0; // Default output
                next_state = B; // Default state
            end
        endcase
    end
endmodule