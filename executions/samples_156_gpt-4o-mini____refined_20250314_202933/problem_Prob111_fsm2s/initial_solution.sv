[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);
    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default to hold the current state
        case (current_state)
            OFF: if (j) begin
                    next_state = ON;
                 end
            ON:  if (k) begin
                    next_state = OFF;
                 end
            default: next_state = current_state; // Handle unexpected states
        endcase
    end

    assign out = (current_state == ON);

endmodule
[DONE]