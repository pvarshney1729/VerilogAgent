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
        STATE_FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t last_walk_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            last_walk_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (next_state == STATE_WALK_LEFT || next_state == STATE_WALK_RIGHT) begin
                last_walk_state <= next_state;
            end
        end
    end

    // Next state logic
    always_comb begin
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
                    next_state = last_walk_state;
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
    always_comb begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALLING);
    end

endmodule