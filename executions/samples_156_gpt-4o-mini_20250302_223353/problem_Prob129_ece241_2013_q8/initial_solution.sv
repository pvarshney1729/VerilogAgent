module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after detecting '1'
        S2 = 2'b10  // State after detecting '10'
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        // Default assignments
        next_state = current_state;
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x == 1'b1) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (x == 1'b0) begin
                    next_state = S2;
                end else begin
                    next_state = S0; // Reset to S0 on '1'
                end
            end
            S2: begin
                if (x == 1'b1) begin
                    z = 1'b1; // Assert z when transitioning to S0
                    next_state = S0;
                end else begin
                    next_state = S0; // Reset to S0 on '0'
                end
            end
            default: begin
                next_state = S0; // Default case
            end
        endcase
    end

endmodule