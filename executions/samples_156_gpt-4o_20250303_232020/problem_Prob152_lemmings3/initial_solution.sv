module TopModule (
    input logic clk,          // System clock, positive edge triggered
    input logic areset,       // Asynchronous active high reset
    input logic bump_left,    // Input: Bump on the left
    input logic bump_right,   // Input: Bump on the right
    input logic ground,       // Input: Ground presence
    input logic dig,          // Input: Dig command
    output logic walk_left,   // Output: Walking left state indicator
    output logic walk_right,  // Output: Walking right state indicator
    output logic aaah,        // Output: Falling state indicator
    output logic digging      // Output: Digging state indicator
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;
    state_t previous_walk_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            previous_walk_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (current_state == WALK_LEFT || current_state == WALK_RIGHT) begin
                previous_walk_state <= current_state;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (ground && dig) begin
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
                end else if (ground && dig) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = previous_walk_state;
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
            default: begin
                next_state = WALK_LEFT;
            end
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