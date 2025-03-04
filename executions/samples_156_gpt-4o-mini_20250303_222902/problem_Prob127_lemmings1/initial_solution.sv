module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic {WALK_LEFT, WALK_RIGHT} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left) 
                    next_state = WALK_RIGHT;
                else 
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right) 
                    next_state = WALK_LEFT;
                else 
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT; // Default state
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (areset) 
            current_state <= WALK_LEFT;
        else 
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
    end

endmodule