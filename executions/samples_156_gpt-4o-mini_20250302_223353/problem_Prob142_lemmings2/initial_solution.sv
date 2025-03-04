module TopModule (
    input  logic clk,          // Clock signal, positive edge-triggered
    input  logic areset,       // Asynchronous active-high reset signal
    input  logic bump_left,    // Indicates an obstacle on the left
    input  logic bump_right,   // Indicates an obstacle on the right
    input  logic ground,       // Indicates if ground is present (1) or absent (0)
    output logic walk_left,    // High when Lemming is walking left
    output logic walk_right,   // High when Lemming is walking right
    output logic aaah          // High when Lemming is falling
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else if (!ground) begin
                    next_state = STATE_FALLING;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else if (!ground) begin
                    next_state = STATE_FALLING;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_FALLING: begin
                if (ground) begin
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end else begin
                    next_state = STATE_FALLING;
                end
            end

            default: next_state = STATE_WALK_LEFT; // Default case
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALLING);
    end

endmodule