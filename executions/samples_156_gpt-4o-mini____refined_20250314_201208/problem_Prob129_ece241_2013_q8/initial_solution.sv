module TopModule (
    input  logic clk,
    input  logic aresetn,
    input  logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after '1'
        S2 = 2'b10  // State after '10'
    } state_t;

    state_t current_state, next_state;
    assign z = (current_state == S2 && x == 1'b1); // Output z is high when in S2 and x is 1

    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0; // Reset to initial state
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    always_comb begin
        case (current_state)
            S0: begin
                if (x) next_state = S1; // Transition to S1 on '1'
                else next_state = S0;   // Stay in S0
            end
            S1: begin
                if (!x) next_state = S2; // Transition to S2 on '0'
                else next_state = S1;    // Stay in S1
            end
            S2: begin
                if (x) next_state = S1; // Transition to S1 on '1' (overlapping)
                else next_state = S0;   // Reset to S0 on '0'
            end
            default: next_state = S0; // Default case
        endcase
    end

endmodule