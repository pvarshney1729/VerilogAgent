```
[BEGIN]
module TopModule (
    input logic clk,                // Clock signal (positive edge-triggered)
    input logic areset,             // Asynchronous reset (active-high)
    input logic bump_left,          // Input signal to bump left (active-high)
    input logic bump_right,         // Input signal to bump right (active-high)
    output logic walk_left,         // Output signal indicating walking left (active-high)
    output logic walk_right         // Output signal indicating walking right (active-high)
);
    
    // State encoding
    localparam STATE_LEFT  = 1'b0; // State 0: Walking Left
    localparam STATE_RIGHT = 1'b1; // State 1: Walking Right
    logic current_state, next_state; // Current and next state of the FSM

    // State transitions with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_LEFT: begin
                if (bump_left)
                    next_state = STATE_RIGHT; // Bumped left, walk right
                else if (bump_right)
                    next_state = STATE_LEFT; // Bumped right, stay walking left
                else
                    next_state = STATE_LEFT; // Stay walking left
            end
            
            STATE_RIGHT: begin
                if (bump_left)
                    next_state = STATE_RIGHT; // Bumped left, stay walking right
                else if (bump_right)
                    next_state = STATE_LEFT; // Bumped right, walk left
                else
                    next_state = STATE_RIGHT; // Stay walking right
            end
            
            default: begin
                next_state = STATE_LEFT; // Default to walking left
            end
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        walk_left = (current_state == STATE_LEFT);
        walk_right = (current_state == STATE_RIGHT);
    end

endmodule
[DONE]
```