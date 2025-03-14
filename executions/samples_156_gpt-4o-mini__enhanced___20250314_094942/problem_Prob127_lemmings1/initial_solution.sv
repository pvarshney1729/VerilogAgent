module TopModule (
    input  logic clk,            // Clock signal (1-bit)
    input  logic areset,        // Asynchronous reset signal (1-bit, active high)
    input  logic bump_left,     // Bump signal from the left (1-bit, active high)
    input  logic bump_right,    // Bump signal from the right (1-bit, active high)
    output logic walk_left,     // Walking left output signal (1-bit, active high)
    output logic walk_right     // Walking right output signal (1-bit, active high)
);

// State Encoding
typedef enum logic [1:0] {
    STATE_WALK_LEFT = 2'b01,  // Walking left state
    STATE_WALK_RIGHT = 2'b10  // Walking right state
} state_t;

// State variables
state_t current_state, next_state;

// Synchronous reset and state transition
always @(posedge clk) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT; // Reset to walking left state
    end else begin
        current_state <= next_state;       // Transition to next state
    end
end

// Output Logic
always @(*) begin
    // Default outputs
    walk_left = 1'b0;
    walk_right = 1'b0;

    // Output logic based on current state
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
    endcase
end

// Next State Logic
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT; // Bump right triggers a state change
            end else begin
                next_state = STATE_WALK_LEFT;  // Stay in the same state
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT; // Bump left triggers a state change
            end else begin
                next_state = STATE_WALK_RIGHT; // Stay in the same state
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT; // Fallback to a known state
        end
    endcase
end

endmodule