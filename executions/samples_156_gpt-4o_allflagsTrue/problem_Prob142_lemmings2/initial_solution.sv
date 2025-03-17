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
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL_LEFT  = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end

            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end

            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end

            default: next_state = WALK_LEFT; // Default state
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALL_LEFT) || (current_state == FALL_RIGHT);
    end

endmodule