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
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (areset) 
            current_state <= WALK_LEFT; // Reset to walk left state
        else 
            current_state <= next_state; // Transition to next state
    end

    // Combinational logic for state transitions and outputs
    always @(*) begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state; // Default to stay in current state

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    aaah = 1'b1; // Fall
                    next_state = FALLING;
                end else if (dig) begin
                    digging = 1'b1; // Start digging
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT; // Bumped on the right
                end
            end
            
            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    aaah = 1'b1; // Fall
                    next_state = FALLING;
                end else if (dig) begin
                    digging = 1'b1; // Start digging
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_LEFT; // Bumped on the left
                end
            end
            
            FALLING: begin
                aaah = 1'b1; // Continue falling
                if (ground) begin
                    next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT; // Resume walking
                end
            end
            
            DIGGING: begin
                digging = 1'b1; // Continue digging
                if (!ground) begin
                    aaah = 1'b1; // Fall
                    next_state = FALLING;
                end
            end
            
            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end

endmodule