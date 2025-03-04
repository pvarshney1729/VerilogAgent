module TopModule (
    input logic clk,      // Clock signal, positive-edge triggered
    input logic areset,   // Active-high asynchronous reset
    input logic j,        // Input signal for state transition
    input logic k,        // Input signal for state transition
    output logic out      // Output signal representing the state
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
            out <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
                out = 0;
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
                out = 1;
            end
            default: begin
                next_state = OFF;
                out = 0;
            end
        endcase
    end

endmodule