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

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING    = 2'b10,
        DIGGING    = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALLING: begin
                if (ground)
                    next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = FALLING;
            end
            DIGGING: begin
                if (!ground)
                    next_state = FALLING;
                else
                    next_state = DIGGING;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALLING);
        digging = (state == DIGGING);
    end

endmodule