[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(current_state, j, k) begin
        out = 1'b0; // Default output value
        next_state = current_state; // Default next state is current state

        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end
            end
            ON: begin
                out = 1'b1; // Output is 1 in ON state
                if (k) begin
                    next_state = OFF;
                end
            end
        endcase
    end

endmodule
[DONE]