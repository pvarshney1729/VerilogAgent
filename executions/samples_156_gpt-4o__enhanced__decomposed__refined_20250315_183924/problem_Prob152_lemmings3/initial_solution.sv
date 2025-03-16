[BEGIN]
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

    // State Encoding
    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALLING    = 2'b10,
        STATE_DIGGING    = 2'b11
    } state_t;

    state_t current_state, next_state;
    state_t last_direction;

    // State Transition Logic with Synchronous Reset
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            last_direction <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (ground && (current_state == STATE_WALK_LEFT || current_state == STATE_WALK_RIGHT)) begin
                last_direction <= current_state;
            end
        end
    end

    // Next State Logic
    always_comb begin
        // Default to current state
        next_state = current_state;

        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_left || bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end else if (dig) begin
                    next_state = STATE_DIGGING;
                end else if (bump_left || bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALLING: begin
                if (ground) begin
                    next_state = last_direction;
                end
            end

            STATE_DIGGING: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                end
            end
        endcase
    end

    // Output Logic
    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            STATE_WALK_LEFT: walk_left = 1'b1;
            STATE_WALK_RIGHT: walk_right = 1'b1;
            STATE_FALLING: aaah = 1'b1;
            STATE_DIGGING: digging = 1'b1;
        endcase
    end

endmodule
[DONE]