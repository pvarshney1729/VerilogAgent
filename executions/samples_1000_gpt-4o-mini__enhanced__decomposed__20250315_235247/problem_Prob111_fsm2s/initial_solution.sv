module TopModule(
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);
    typedef enum logic [1:0] {OFF = 1'b0, ON = 1'b1} state_t;
    state_t current_state, next_state;

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF; // Reset to OFF state
        end else begin
            current_state <= next_state; // Update to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON; // Transition to ON state
                end else begin
                    next_state = OFF; // Remain in OFF state
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF; // Transition to OFF state
                end else begin
                    next_state = ON; // Remain in ON state
                end
            end
            default: begin
                next_state = OFF; // Default to OFF state
            end
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            OFF: out = 1'b0; // Output is 0 in OFF state
            ON:  out = 1'b1; // Output is 1 in ON state
            default: out = 1'b0; // Default output
        endcase
    end

endmodule