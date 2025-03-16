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
        STATE_FALL,
        STATE_DIG
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

    // Output logic
    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);
    assign aaah = (current_state == STATE_FALL);
    assign digging = (current_state == STATE_DIG);

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_FALL: begin
                if (ground) begin
                    if (bump_left) begin
                        next_state = STATE_WALK_RIGHT;
                    end else if (bump_right) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end else begin
                    next_state = STATE_FALL;
                end
            end

            STATE_DIG: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                end else begin
                    next_state = STATE_DIG;
                end
            end

            default: next_state = STATE_WALK_LEFT;
        endcase
    end

endmodule