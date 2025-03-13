[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    output logic walk_left,
    output logic walk_right,
    output logic aaah
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL       = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) 
                    next_state = STATE_FALL;
                else if (bump_left || bump_right) 
                    next_state = STATE_WALK_RIGHT;
                else 
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground) 
                    next_state = STATE_FALL;
                else if (bump_left || bump_right) 
                    next_state = STATE_WALK_LEFT;
                else 
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL: begin
                if (ground) 
                    next_state = (current_state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                else 
                    next_state = STATE_FALL;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    always_comb begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL);
    end

endmodule
[DONE]