module TopModule (
    input logic clk,            // Clock input
    input logic areset,         // Asynchronous reset, active high
    input logic bump_left,      // Input signal indicating bump on the left
    input logic bump_right,     // Input signal indicating bump on the right
    input logic ground,         // Input signal indicating presence of ground
    input logic dig,            // Input signal for digging command
    output logic walk_left,     // Output signal, high when walking left
    output logic walk_right,    // Output signal, high when walking right
    output logic aaah,          // Output signal, high when falling
    output logic digging        // Output signal, high when digging
);

    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL_LEFT,
        STATE_FALL_RIGHT,
        STATE_DIG_LEFT,
        STATE_DIG_RIGHT
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end else if (dig) begin
                    next_state = STATE_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else if (dig) begin
                    next_state = STATE_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_FALL_LEFT: begin
                if (ground) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_FALL_LEFT;
                end
            end
            STATE_FALL_RIGHT: begin
                if (ground) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_FALL_RIGHT;
                end
            end
            STATE_DIG_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end else begin
                    next_state = STATE_DIG_LEFT;
                end
            end
            STATE_DIG_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else begin
                    next_state = STATE_DIG_RIGHT;
                end
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL_LEFT) || (current_state == STATE_FALL_RIGHT);
        digging = (current_state == STATE_DIG_LEFT) || (current_state == STATE_DIG_RIGHT);
    end

endmodule