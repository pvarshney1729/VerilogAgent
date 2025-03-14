```
[BEGIN]
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

    // State Definitions
    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALLING = 2'b10,
        STATE_DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous Reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT; // Reset to walking left
            walk_left <= 1'b1;                 // Initialize walk_left
            walk_right <= 1'b0;                // Initialize walk_right
            aaah <= 1'b0;                       // Initialize aaah
            digging <= 1'b0;                    // Initialize digging
        end else begin
            current_state <= next_state;       // Update state on clock edge
        end
    end

    // State Transition Logic
    always @(*) begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state; // Default to current state

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1; // Walking left
                if (ground == 1'b0) begin
                    next_state = STATE_FALLING; // Fall if no ground
                    aaah = 1'b1; // Say aaah!
                end else if (dig) begin
                    next_state = STATE_DIGGING; // Start digging
                    digging = 1'b1; // Digging action
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT; // Switch to walk right on bump
                end
            end
            
            STATE_WALK_RIGHT: begin
                walk_right = 1'b1; // Walking right
                if (ground == 1'b0) begin
                    next_state = STATE_FALLING; // Fall if no ground
                    aaah = 1'b1; // Say aaah!
                end else if (dig) begin
                    next_state = STATE_DIGGING; // Start digging
                    digging = 1'b1; // Digging action
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT; // Switch to walk left on bump
                end
            end

            STATE_FALLING: begin
                aaah = 1'b1; // Indicate falling
                if (ground) begin
                    // Resume walking in the last direction
                    next_state = (current_state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end

            STATE_DIGGING: begin
                digging = 1'b1; // Digging action
                if (ground == 1'b0) begin
                    next_state = STATE_FALLING; // Fall if no ground
                    aaah = 1'b1; // Say aaah!
                end
            end

            default: begin
                next_state = STATE_WALK_LEFT; // Default to walking left
            end
        endcase
    end

endmodule
[DONE]
```