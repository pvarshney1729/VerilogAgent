module TopModule (
    input wire clk,           // Clock signal, positive edge-triggered
    input wire areset,        // Asynchronous active-high reset
    input wire bump_left,     // Input: Lemming bumped from the left
    input wire bump_right,    // Input: Lemming bumped from the right
    input wire ground,        // Input: Ground detected (1) or not (0)
    output reg walk_left,     // Output: Lemming walks left
    output reg walk_right,    // Output: Lemming walks right
    output reg aaah           // Output: Lemming falling (ground = 0)
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING    = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t previous_walking_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            previous_walking_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (next_state == WALK_LEFT || next_state == WALK_RIGHT) begin
                previous_walking_state <= next_state;
            end
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                    walk_left = 1;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                    walk_right = 1;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = previous_walking_state;
                end else begin
                    next_state = FALLING;
                end
                aaah = 1;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule