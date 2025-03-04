module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic areset,       // Asynchronous reset, active high
    input logic bump_left,    // Input signal indicating a bump on the left
    input logic bump_right,   // Input signal indicating a bump on the right
    input logic ground,       // Input signal indicating ground presence
    input logic dig,          // Input signal to start digging
    output logic walk_left,   // Output signal, 1 when walking left
    output logic walk_right,  // Output signal, 1 when walking right
    output logic aaah,        // Output signal, 1 when falling
    output logic digging      // Output signal, 1 when digging
);

    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = FALLING;
                end
            end
            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = DIGGING;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // State update logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
        digging = (current_state == DIGGING);
    end

endmodule