module TopModule (
    input logic clk,                // Clock input
    input logic areset,             // Asynchronous reset, active high
    input logic bump_left,          // Bump from the left, active high
    input logic bump_right,         // Bump from the right, active high
    input logic ground,             // Ground presence, active high
    input logic dig,                // Digging command, active high
    output logic walk_left,         // Walking to the left, active high
    output logic walk_right,        // Walking to the right, active high
    output logic aaah,              // Falling state indicator, active high
    output logic digging            // Digging state indicator, active high
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic previous_walk_left;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            previous_walk_left <= 1'b1;
        end else begin
            current_state <= next_state;
            if (current_state == WALK_LEFT || current_state == WALK_RIGHT) begin
                previous_walk_left <= (current_state == WALK_LEFT);
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = previous_walk_left ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = FALLING;
                end
            end
            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = DIGGING;
                end
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
        digging = (current_state == DIGGING);
    end

endmodule