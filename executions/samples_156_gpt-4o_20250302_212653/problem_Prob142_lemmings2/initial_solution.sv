module TopModule (
    input wire clk,          // Clock signal, positive edge triggered
    input wire areset,       // Asynchronous reset, active high
    input wire bump_left,    // Input: Bump signal from the left
    input wire bump_right,   // Input: Bump signal from the right
    input wire ground,       // Input: Ground signal indicating support
    output reg walk_left,    // Output: Walking left signal
    output reg walk_right,   // Output: Walking right signal
    output reg aaah          // Output: Falling signal
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL_LEFT  = 2'b10,
        STATE_FALL_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT: begin
                if (ground)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                if (ground)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_FALL_RIGHT;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL_LEFT) || (current_state == STATE_FALL_RIGHT);
    end

endmodule