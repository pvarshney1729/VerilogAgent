module TopModule(
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
    typedef enum logic [2:0] {
        STATE_WALK_LEFT  = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALLING    = 3'b010,
        STATE_DIGGING    = 3'b011,
        STATE_SPLATTER   = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;  // Counter for falling duration, max value is 31

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;

            // Update fall counter for falling state
            if (current_state != STATE_FALLING || ground) begin
                fall_counter <= 5'b0;
            end else begin
                fall_counter <= fall_counter + 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_FALLING: begin
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = STATE_SPLATTER;
                    end else if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end else begin
                    next_state = STATE_FALLING;
                end
            end

            STATE_DIGGING: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else begin
                    next_state = STATE_DIGGING;
                end
            end

            STATE_SPLATTER: begin
                next_state = STATE_SPLATTER; // Remain in splatter state
            end

            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALLING);
        digging = (current_state == STATE_DIGGING);
    end

endmodule