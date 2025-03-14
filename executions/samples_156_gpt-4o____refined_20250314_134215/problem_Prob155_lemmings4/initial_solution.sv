[BEGIN]
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

    typedef enum logic [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011,
        STATE_DIG_LEFT = 3'b100,
        STATE_DIG_RIGHT = 3'b101,
        STATE_SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT)
                fall_counter <= fall_counter + 5'd1;
            else
                fall_counter <= 5'd0;
        end
    end

    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state;

        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (dig)
                    next_state = STATE_DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (dig)
                    next_state = STATE_DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = STATE_WALK_LEFT;
            end
            STATE_FALL_LEFT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = STATE_SPLATTER;
                    else
                        next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALL_RIGHT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = STATE_SPLATTER;
                    else
                        next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_DIG_LEFT: begin
                digging = 1'b1;
                if (!ground)
                    next_state = STATE_FALL_LEFT;
            end
            STATE_DIG_RIGHT: begin
                digging = 1'b1;
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
            end
            STATE_SPLATTER: begin
                // All outputs remain 0
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

endmodule
[DONE]