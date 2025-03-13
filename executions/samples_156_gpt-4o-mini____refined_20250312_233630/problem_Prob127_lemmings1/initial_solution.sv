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

    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to current state
        case (current_state)
            LEFT: begin
                if (bump_right || bump_left) begin
                    next_state = RIGHT;
                end
            end
            RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = LEFT;
                end
            end
        endcase
    end

    // Output logic
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);

endmodule
[DONE]
```