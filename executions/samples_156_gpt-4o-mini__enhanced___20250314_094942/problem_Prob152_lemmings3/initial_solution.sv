module TopModule (
    input  logic clk,          // Clock signal
    input  logic areset,      // Asynchronous reset signal (active high)
    input  logic bump_left,    // Input signal to indicate bump to the left (active high)
    input  logic bump_right,   // Input signal to indicate bump to the right (active high)
    input  logic ground,       // Input signal to indicate presence of ground (active high)
    input  logic dig,          // Input signal to indicate digging action (active high)
    output logic walk_left,    // Output signal for walking left (active high)
    output logic walk_right,   // Output signal for walking right (active high)
    output logic aaah,         // Output signal indicating the Lemming is falling (active high)
    output logic digging        // Output signal indicating the Lemming is digging (active high)
);

// State encoding for FSM
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALLING,
    STATE_DIGGING
} state_t;

state_t current_state, next_state;

// Timing Behavior
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT; // Reset state
        walk_left <= 1'b1;                 // Initial output state
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        current_state <= next_state; // Update state on clock edge
    end
end

// Next state logic
always_comb begin
    // Default outputs
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;
    
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            if (ground == 1'b0) begin
                next_state = STATE_FALLING;
                aaah = 1'b1; // Start falling
            end else if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (dig && ground) begin
                next_state = STATE_DIGGING;
                digging = 1'b1; // Start digging
            end else begin
                next_state = STATE_WALK_LEFT; // Remain in current state
            end
        end

        STATE_WALK_RIGHT: begin
            walk_right = 1'b1;
            if (ground == 1'b0) begin
                next_state = STATE_FALLING;
                aaah = 1'b1; // Start falling
            end else if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (dig && ground) begin
                next_state = STATE_DIGGING;
                digging = 1'b1; // Start digging
            end else begin
                next_state = STATE_WALK_RIGHT; // Remain in current state
            end
        end

        STATE_FALLING: begin
            aaah = 1'b1; // Falling state persists
            if (ground == 1'b1) begin
                // Resume walking in the last direction
                next_state = (walk_left ? STATE_WALK_LEFT : STATE_WALK_RIGHT);
            end else begin
                next_state = STATE_FALLING; // Continue falling
            end
        end

        STATE_DIGGING: begin
            digging = 1'b1; // Digging state persists
            if (ground == 1'b0) begin
                next_state = STATE_FALLING; // Fall if no ground
                aaah = 1'b1;
            end else if (bump_left || bump_right) begin
                // Bump does not affect digging
                next_state = STATE_DIGGING;
            end else begin
                next_state = STATE_DIGGING; // Continue digging
            end
        end

        default: next_state = STATE_WALK_LEFT; // Default case for safety
    endcase
end

endmodule