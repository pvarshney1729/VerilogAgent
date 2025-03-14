```
[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);
    
    // State encoding
    typedef enum logic [1:0] {
        STATE_LEFT = 2'b00,
        STATE_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_LEFT: begin
                if (bump_right) 
                    next_state = STATE_LEFT; // Stay left
                else if (bump_left) 
                    next_state = STATE_RIGHT; // Switch to right
                else 
                    next_state = STATE_LEFT; // Remain in state
            end
            STATE_RIGHT: begin
                if (bump_left) 
                    next_state = STATE_LEFT;  // Switch to left
                else if (bump_right) 
                    next_state = STATE_RIGHT; // Stay right
                else 
                    next_state = STATE_RIGHT; // Remain in state
            end
            default: 
                next_state = STATE_LEFT; // Default to walking left
        endcase
    end

    // State transition on clock edge with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic based on state
    always @(*) begin
        walk_left = (current_state == STATE_LEFT);
        walk_right = (current_state == STATE_RIGHT);
    end

endmodule
[DONE]
```