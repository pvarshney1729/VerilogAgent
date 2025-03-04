module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic areset,        // Asynchronous reset, active high
    input logic bump_left,     // Indicates obstacle on the left
    input logic bump_right,    // Indicates obstacle on the right
    input logic ground,        // 1 when on ground, 0 when falling
    input logic dig,           // 1 to initiate digging
    output logic walk_left,    // 1 when walking left
    output logic walk_right,   // 1 when walking right
    output logic aaah,         // 1 when falling
    output logic digging       // 1 when digging
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING_LEFT,
        DIGGING_RIGHT
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left || bump_right)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALLING: begin
                if (ground)
                    next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                else
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
            default: next_state = WALK_LEFT;
        endcase
    end

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
        digging = (current_state == DIGGING_LEFT || current_state == DIGGING_RIGHT);
    end

endmodule