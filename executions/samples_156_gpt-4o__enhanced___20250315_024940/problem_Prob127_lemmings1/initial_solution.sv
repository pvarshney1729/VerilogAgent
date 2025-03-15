```verilog
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic bump_left,
    input  logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    // State encoding
    typedef enum logic {
        STATE_LEFT,  // Walking left
        STATE_RIGHT  // Walking right
    } state_t;

    // Current state and next state variables
    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;

        // Next state logic
        case (current_state)
            STATE_LEFT: begin
                if (bump_right) begin
                    next_state = STATE_LEFT; // Stay in left on right bump
                    walk_left = 1'b1;
                end else if (bump_left) begin
                    next_state = STATE_RIGHT; // Switch to right on left bump
                    walk_right = 1'b1;
                end else begin
                    next_state = STATE_LEFT; // Stay in left if no bumps
                    walk_left = 1'b1;
                end
            end

            STATE_RIGHT: begin
                if (bump_left) begin
                    next_state = STATE_RIGHT; // Stay in right on left bump
                    walk_right = 1'b1;
                end else if (bump_right) begin
                    next_state = STATE_LEFT; // Switch to left on right bump
                    walk_left = 1'b1;
                end else begin
                    next_state = STATE_RIGHT; // Stay in right if no bumps
                    walk_right = 1'b1;
                end
            end

            default: begin
                next_state = STATE_LEFT; // Default state
                walk_left = 1'b1;
            end
        endcase
    end

endmodule
```