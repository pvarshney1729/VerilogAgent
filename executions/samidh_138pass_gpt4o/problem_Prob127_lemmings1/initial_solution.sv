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
        STATE_LEFT  = 2'b01,
        STATE_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset)
            current_state <= STATE_LEFT;
        else
            current_state <= next_state;
    end

    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        case (current_state)
            STATE_LEFT: begin
                walk_left = 1'b1;
                if (bump_left || (bump_left && bump_right))
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_LEFT;
            end

            STATE_RIGHT: begin
                walk_right = 1'b1;
                if (bump_right || (bump_left && bump_right))
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_RIGHT;
            end

            default: next_state = STATE_LEFT; // Default safe state
        endcase
    end

endmodule
```