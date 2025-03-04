module TopModule (
    input logic clk,         // Clock signal, positive edge triggered
    input logic areset,      // Asynchronous reset, active high
    input logic bump_left,   // Input signal: 1 indicates a left bump
    input logic bump_right,  // Input signal: 1 indicates a right bump
    input logic ground,      // Input signal: 1 indicates ground is present
    input logic dig,         // Input signal: 1 indicates digging request
    output logic walk_left,  // Output signal: 1 indicates walking left
    output logic walk_right, // Output signal: 1 indicates walking right
    output logic aaah,       // Output signal: 1 indicates falling
    output logic digging     // Output signal: 1 indicates digging
);

    // State encoding
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALLING = 3'b010,
        DIGGING_LEFT = 3'b011,
        DIGGING_RIGHT = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALLING: begin
                if (ground)
                    next_state = (walk_left == 1'b1) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = FALLING;
            end
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else
                    next_state = DIGGING_LEFT;
            end
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else
                    next_state = DIGGING_RIGHT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (current_state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALLING: aaah = 1'b1;
            DIGGING_LEFT: digging = 1'b1;
            DIGGING_RIGHT: digging = 1'b1;
        endcase
    end

endmodule