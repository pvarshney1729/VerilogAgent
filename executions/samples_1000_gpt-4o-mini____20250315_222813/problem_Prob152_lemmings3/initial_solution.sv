module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALLING,
        STATE_DIGGING
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
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
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_FALLING: begin
                if (ground) begin
                    if (bump_left) begin
                        next_state = STATE_WALK_RIGHT;
                    end else if (bump_right) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = (current_state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end else begin
                    next_state = STATE_FALLING;
                end
            end

            STATE_DIGGING: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else begin
                    next_state = STATE_DIGGING;
                end
            end

            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // Output logic
    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);
    assign aaah = (current_state == STATE_FALLING);
    assign digging = (current_state == STATE_DIGGING);

endmodule