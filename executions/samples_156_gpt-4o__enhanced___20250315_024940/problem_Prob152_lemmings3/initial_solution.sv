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

    // State Encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    // State and Next State
    state_t current_state, next_state;

    // Sequential Logic: State Transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Update to next state
        end
    end

    // Combinational Logic: Next State Logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        // State Transition Logic
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING; // Transition to falling
                    aaah = 1'b1; // Indicate falling
                end else if (dig) begin
                    next_state = DIGGING; // Start digging
                    digging = 1'b1; // Indicate digging
                end else if (bump_right) begin
                    next_state = WALK_RIGHT; // Change direction to right
                end else begin
                    walk_left = 1'b1; // Continue walking left
                end
            end
            
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING; // Transition to falling
                    aaah = 1'b1; // Indicate falling
                end else if (dig) begin
                    next_state = DIGGING; // Start digging
                    digging = 1'b1; // Indicate digging
                end else if (bump_left) begin
                    next_state = WALK_LEFT; // Change direction to left
                end else begin
                    walk_right = 1'b1; // Continue walking right
                end
            end
            
            FALLING: begin
                if (ground) begin
                    // If ground reappears, resume walking in the last direction
                    if (current_state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    aaah = 1'b1; // Continue falling
                end
            end
            
            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING; // Transition to falling if ground disappears
                    aaah = 1'b1; // Indicate falling
                end else begin
                    digging = 1'b1; // Continue digging
                end
            end
            
            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end

endmodule