module lemming_controller (
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
        WALKING_LEFT,
        WALKING_RIGHT,
        FALLING,
        DIGGING_LEFT,
        DIGGING_RIGHT
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALKING_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALKING_RIGHT;
                else
                    next_state = WALKING_LEFT;
            end
            WALKING_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALKING_LEFT;
                else
                    next_state = WALKING_RIGHT;
            end
            FALLING: begin
                if (ground) begin
                    if (state == DIGGING_LEFT || state == WALKING_LEFT)
                        next_state = WALKING_LEFT;
                    else
                        next_state = WALKING_RIGHT;
                end else
                    next_state = FALLING;
            end
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else
                    next_state = DIGGING_LEFT;
            end
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else
                    next_state = DIGGING_RIGHT;
            end
            default: next_state = WALKING_LEFT;
        endcase
    end

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALKING_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WALKING_LEFT: walk_left = 1;
            WALKING_RIGHT: walk_right = 1;
            FALLING: aaah = 1;
            DIGGING_LEFT: begin
                digging = 1;
                walk_left = 1;
            end
            DIGGING_RIGHT: begin
                digging = 1;
                walk_right = 1;
            end
        endcase
    end

endmodule