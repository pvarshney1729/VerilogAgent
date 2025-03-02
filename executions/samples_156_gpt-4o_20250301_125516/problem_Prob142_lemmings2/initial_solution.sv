module TopModule (
    input wire clk,          // Clock input, positive edge-triggered
    input wire areset,       // Asynchronous reset, active high
    input wire bump_left,    // Indicates a bump on the left
    input wire bump_right,   // Indicates a bump on the right
    input wire ground,       // Indicates whether the ground is present
    output reg walk_left,    // Output high when walking left
    output reg walk_right,   // Output high when walking right
    output reg aaah          // Output high when falling
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL       = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL: begin
                if (ground)
                    next_state = (bump_left) ? STATE_WALK_RIGHT : STATE_WALK_LEFT;
                else
                    next_state = STATE_FALL;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL);
    end

endmodule