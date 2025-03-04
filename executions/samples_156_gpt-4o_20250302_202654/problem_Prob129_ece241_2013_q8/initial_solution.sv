module TopModule (
    input logic clk,          // Clock signal, triggers on positive edge
    input logic aresetn,      // Active-low asynchronous reset, negative edge-triggered
    input logic x,            // Input signal for sequence detection
    output logic z            // Output signal, asserted high when "101" sequence is detected
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x) next_state = S1;
            end
            S1: begin
                if (!x) next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule