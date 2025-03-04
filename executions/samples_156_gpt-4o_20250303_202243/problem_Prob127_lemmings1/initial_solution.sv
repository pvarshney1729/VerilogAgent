```verilog
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic bump_left,
    input  logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always_comb begin
        walk_left  = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
    end

endmodule
```