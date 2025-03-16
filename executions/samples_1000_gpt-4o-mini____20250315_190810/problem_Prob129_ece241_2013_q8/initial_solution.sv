module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after '1'
        S2 = 2'b10  // State after '10'
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1; // Stay in S1 if x is 1
                end else begin
                    next_state = S2; // Move to S2 if x is 0
                end
            end
            S2: begin
                if (x) begin
                    next_state = S1; // Move back to S1 if x is 1
                end else begin
                    next_state = S0; // Move back to S0 if x is 0
                end
            end
            default: next_state = S0; // Default case
        endcase
    end

    // Output logic for Mealy FSM
    always @(*) begin
        z = (current_state == S2 && x); // Assert z when in S2 and x is 1
    end

endmodule