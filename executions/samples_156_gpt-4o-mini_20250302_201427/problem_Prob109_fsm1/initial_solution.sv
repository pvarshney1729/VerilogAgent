module TopModule (
    input logic clk,         // Clock signal, positive edge-triggered
    input logic areset,      // Asynchronous reset, active high
    input logic in,          // Input signal
    output logic out         // Output signal, driven by state
);

    typedef logic state_t; // Define state type
    state_t state, next_state; // Current and next state

    // Asynchronous reset to State B
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // Reset to State B
        end else begin
            state <= next_state; // Update state
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            1'b0: begin // State A
                if (in == 1'b0) begin
                    next_state = 1'b1; // Transition to State B
                end else begin
                    next_state = 1'b0; // Remain in State A
                end
            end
            1'b1: begin // State B
                if (in == 1'b0) begin
                    next_state = 1'b0; // Transition to State A
                end else begin
                    next_state = 1'b1; // Remain in State B
                end
            end
            default: next_state = 1'b1; // Default to State B
        endcase
    end

    // Output logic
    always_comb begin
        out = (state == 1'b1); // Output 1 when in State B, else 0
    end

endmodule