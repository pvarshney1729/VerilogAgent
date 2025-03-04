module TopModule (
    input  wire clk,        // Clock signal
    input  wire areset,     // Asynchronous reset signal, active high
    input  wire bump_left,  // Bump signal from the left
    input  wire bump_right, // Bump signal from the right
    input  wire ground,     // Ground presence signal
    output reg  walk_left,  // Walk left indicator
    output reg  walk_right, // Walk right indicator
    output reg  aaah        // Falling indicator
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALLING    = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t previous_walk_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            previous_walk_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (next_state == STATE_WALK_LEFT || next_state == STATE_WALK_RIGHT) begin
                previous_walk_state <= next_state;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_FALLING: begin
                if (ground) begin
                    next_state = previous_walk_state;
                end else begin
                    next_state = STATE_FALLING;
                end
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
            STATE_WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
            end
            STATE_FALLING: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
        endcase
    end

endmodule