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
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL = 2'b10,
        STATE_DIG = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_left || bump_right) begin
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
                end else if (bump_right || bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_FALL: begin
                if (ground) begin
                    next_state = (current_state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
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
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL);
        digging = (current_state == STATE_DIG);
    end

endmodule