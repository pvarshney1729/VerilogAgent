module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic areset,       // Asynchronous reset, active-high
    input logic bump_left,    // Bump indication from the left
    input logic bump_right,   // Bump indication from the right
    input logic ground,       // Ground presence signal
    input logic dig,          // Dig command signal
    output logic walk_left,   // Output indicating walking left
    output logic walk_right,  // Output indicating walking right
    output logic aaah,        // Output indicating falling
    output logic digging      // Output indicating digging
);

    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING    = 2'b10,
        DIGGING    = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic previous_direction; // 0 for left, 1 for right

    // State transition logic
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

    // Next state logic
    always_comb begin
        case (current_state)
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
                    next_state = previous_direction ? WALK_RIGHT : WALK_LEFT;
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

    // Output logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
        digging = (current_state == DIGGING);
    end

endmodule