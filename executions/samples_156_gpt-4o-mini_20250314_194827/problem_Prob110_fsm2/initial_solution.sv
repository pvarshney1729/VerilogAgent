module state_machine (
    input logic clk,
    input logic rst_n,
    output logic state
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= OFF; // Initialize to OFF state on reset
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            OFF: next_state = ON;
            ON: next_state = OFF;
            default: next_state = OFF; // Default case to handle unexpected states
        endcase
    end

    // Output logic
    assign state = (current_state == ON);

endmodule