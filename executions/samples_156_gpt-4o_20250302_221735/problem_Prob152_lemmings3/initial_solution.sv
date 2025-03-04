module TopModule (
    input  logic clk,         // Clock signal, positive edge triggered
    input  logic areset,      // Asynchronous reset, active high
    input  logic bump_left,   // Bump sensor on the left
    input  logic bump_right,  // Bump sensor on the right
    input  logic ground,      // Ground presence sensor
    input  logic dig,         // Digging command
    output logic walk_left,   // Lemming walks left
    output logic walk_right,  // Lemming walks right
    output logic aaah,        // Lemming is falling
    output logic digging      // Lemming is digging
);

    typedef enum logic [2:0] {
        STATE_WALK_LEFT    = 3'b000,
        STATE_WALK_RIGHT   = 3'b001,
        STATE_FALLING_LEFT = 3'b010,
        STATE_FALLING_RIGHT= 3'b011,
        STATE_DIG_LEFT     = 3'b100,
        STATE_DIG_RIGHT    = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        // Default assignments
        next_state = state;
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALLING_LEFT;
                end else if (dig) begin
                    next_state = STATE_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALLING_RIGHT;
                end else if (dig) begin
                    next_state = STATE_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALLING_LEFT: begin
                aaah = 1'b1;
                if (ground) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALLING_RIGHT: begin
                aaah = 1'b1;
                if (ground) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_DIG_LEFT: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALLING_LEFT;
                end
            end
            STATE_DIG_RIGHT: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALLING_RIGHT;
                end
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

endmodule