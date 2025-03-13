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

    typedef enum logic [1:0] {
        WALKING_LEFT = 2'b01,
        WALKING_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALKING_LEFT: begin
                if (bump_left)
                    next_state = WALKING_RIGHT;
                else
                    next_state = WALKING_LEFT;
            end
            WALKING_RIGHT: begin
                if (bump_right)
                    next_state = WALKING_LEFT;
                else
                    next_state = WALKING_RIGHT;
            end
            default: next_state = WALKING_LEFT;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (areset)
            current_state <= WALKING_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        case (current_state)
            WALKING_LEFT: begin
                walk_left = 1'b1;
            end
            WALKING_RIGHT: begin
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
[DONE]
```