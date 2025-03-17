module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // State after detecting '1'
        S2 = 2'b10   // State after detecting '10'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state; // Default to hold state
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end else begin
                    next_state = S0;
                end
            end
        endcase
    end

endmodule