[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
        endcase
    end

    // State update logic with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);

endmodule
```
[DONE]