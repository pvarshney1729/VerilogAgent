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
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic previous_direction; // 0 for left, 1 for right

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            previous_direction <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == WALK_LEFT || current_state == WALK_RIGHT) begin
                previous_direction <= (current_state == WALK_RIGHT);
            end
        end
    end

    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                if (ground) begin
                    next_state = previous_direction ? WALK_RIGHT : WALK_LEFT;
                end else begin
                    next_state = FALLING;
                end
            end
            default: begin
                next_state = WALK_LEFT;
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
        endcase

        if (bump_left && bump_right) begin
            next_state = (current_state == WALK_LEFT) ? WALK_RIGHT : WALK_LEFT;
        end
    end

endmodule