```verilog
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
        STATE_LEFT = 2'b01,
        STATE_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_LEFT: begin
                if (bump_left)
                    next_state = STATE_RIGHT;
                else if (bump_right)
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_LEFT;
            end
            STATE_RIGHT: begin
                if (bump_right)
                    next_state = STATE_LEFT;
                else if (bump_left)
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_RIGHT;
            end
            default: next_state = STATE_LEFT;
        endcase

        // Toggle logic for simultaneous bumps
        if (bump_left && bump_right)
            next_state = (current_state == STATE_LEFT) ? STATE_RIGHT : STATE_LEFT;
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == STATE_LEFT);
        walk_right = (current_state == STATE_RIGHT);
    end

endmodule
[DONE]
```