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
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t previous_walk_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            previous_walk_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_WALK_LEFT || current_state == STATE_WALK_RIGHT) begin
                previous_walk_state <= current_state;
            end
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (bump_left || (bump_left && bump_right)) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_FALL: begin
                aaah = 1'b1;
                if (ground) begin
                    next_state = previous_walk_state;
                end else begin
                    next_state = STATE_FALL;
                end
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

endmodule