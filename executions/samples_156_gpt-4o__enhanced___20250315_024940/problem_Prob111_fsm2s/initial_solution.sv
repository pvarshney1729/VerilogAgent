module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF; // Reset to OFF state
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Next state logic based on current state and inputs
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
    assign out = (current_state == ON); // Output is 1 when in ON state

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly