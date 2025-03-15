module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b01, // State A
        B = 2'b10  // State B
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset to State A
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= A; // Reset to State A
        else 
            current_state <= next_state; // Update to next state
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        next_state = current_state;
        z = 1'b0; // Default output value

        case (current_state)
            A: begin
                if (x) begin
                    next_state = B; // Transition to State B
                    z = 1'b1;       // Output 1
                end else begin
                    z = 1'b0;       // Remain in State A, output 0
                end
            end
            B: begin
                if (x) begin
                    z = 1'b0;       // Remain in State B, output 0
                end else begin
                    z = 1'b1;       // Remain in State B, output 1
                end
            end
            default: begin
                // Should never reach here, but safe to handle
                next_state = A; // Default to State A
            end
        endcase
    end

endmodule