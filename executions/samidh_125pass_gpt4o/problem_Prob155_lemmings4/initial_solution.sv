module TopModule (
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

    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALLING,
        STATE_DIGGING,
        STATE_SPLATTER
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5-bit counter for 0 to 31

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALLING) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALLING: begin
                if (ground) begin
                    if (fall_counter >= 5'd20) begin
                        next_state = STATE_SPLATTER;
                    end else begin
                        next_state = STATE_WALK_LEFT;
                    end
                end
            end
            STATE_DIGGING: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end
            end
            STATE_SPLATTER: begin
                // Remain in splatter state until reset
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (current_state)
            STATE_WALK_LEFT: walk_left = 1'b1;
            STATE_WALK_RIGHT: walk_right = 1'b1;
            STATE_FALLING: aaah = 1'b1;
            STATE_DIGGING: digging = 1'b1;
            STATE_SPLATTER: begin
                // All outputs are 0
            end
        endcase
    end

endmodule