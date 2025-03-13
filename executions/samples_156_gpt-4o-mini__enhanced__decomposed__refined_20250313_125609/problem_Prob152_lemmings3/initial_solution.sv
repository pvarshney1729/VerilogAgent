[BEGIN]
module TopModule (
    input logic clk,               // Clock signal (positive edge triggered)
    input logic areset,           // Asynchronous reset signal (active high)
    input logic bump_left,        // Input signal to bump the Lemming left (1-bit)
    input logic bump_right,       // Input signal to bump the Lemming right (1-bit)
    input logic ground,           // Signal indicating if the ground is present (1-bit, active high)
    input logic dig,              // Input signal to dig (1-bit, active high)
    output logic walk_left,       // Output signal indicating walking left (1-bit)
    output logic walk_right,      // Output signal indicating walking right (1-bit)
    output logic aaah,            // Output signal indicating falling (1-bit)
    output logic digging           // Output signal indicating digging (1-bit)
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Initialize to walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            current_state <= next_state; // Update state on clock edge
        end
    end

    // State transition logic
    always_ff @(current_state, bump_left, bump_right, ground, dig) begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state; // Default to current state

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING; // Transition to falling
                    aaah = 1'b1;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT; // Bumped right
                end else if (dig) begin
                    next_state = DIGGING; // Start digging
                    digging = 1'b1;
                end
            end
            
            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING; // Transition to falling
                    aaah = 1'b1;
                end else if (bump_left) begin
                    next_state = WALK_LEFT; // Bumped left
                end else if (dig) begin
                    next_state = DIGGING; // Start digging
                    digging = 1'b1;
                end
            end
            
            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    next_state = (walk_left ? WALK_LEFT : WALK_RIGHT); // Resume walking in last direction
                end
            end
            
            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING; // Transition to falling
                    aaah = 1'b1;
                end
            end
            
            default: next_state = WALK_LEFT; // Default to walking left
        endcase
    end
endmodule
[DONE]