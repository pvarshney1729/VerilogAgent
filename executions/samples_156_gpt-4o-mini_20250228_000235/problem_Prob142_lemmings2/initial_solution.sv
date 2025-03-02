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

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) 
                    next_state = WALK_LEFT; // Stay in WALK_LEFT
                else if (ground == 0) 
                    next_state = FALLING; // Fall
                else 
                    next_state = WALK_LEFT; // Continue walking left
            end
            WALK_RIGHT: begin
                if (bump_left) 
                    next_state = WALK_RIGHT; // Stay in WALK_RIGHT
                else if (ground == 0) 
                    next_state = FALLING; // Fall
                else 
                    next_state = WALK_RIGHT; // Continue walking right
            end
            FALLING: begin
                if (ground) 
                    next_state = (bump_left) ? WALK_RIGHT : (bump_right) ? WALK_LEFT : current_state; // Resume walking
                else 
                    next_state = FALLING; // Continue falling
            end
            default: next_state = WALK_LEFT; // Default state
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (areset) 
            current_state <= WALK_LEFT; // Reset to WALK_LEFT
        else 
            current_state <= next_state; // Update state
    end

    // Output logic
    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    assign aaah = (current_state == FALLING);

endmodule