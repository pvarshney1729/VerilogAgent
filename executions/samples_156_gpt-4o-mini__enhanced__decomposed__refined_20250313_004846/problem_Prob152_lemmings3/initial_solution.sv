```verilog
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

    // State encoding
    typedef enum logic [2:0] {
        STATE_WALK_LEFT  = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT  = 3'b010,
        STATE_FALL_RIGHT = 3'b011,
        STATE_DIG_LEFT   = 3'b100,
        STATE_DIG_RIGHT  = 3'b101
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state update
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to current state
        
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end else if (dig && ground) begin
                    next_state = STATE_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else if (dig && ground) begin
                    next_state = STATE_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALL_LEFT: begin
                if (ground) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALL_RIGHT: begin
                if (ground) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_DIG_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end
            end

            STATE_DIG_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end
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
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
            end

            STATE_FALL_LEFT,
            STATE_FALL_RIGHT: begin
                aaah = 1'b1;
            end

            STATE_DIG_LEFT,
            STATE_DIG_RIGHT: begin
                digging = 1'b1;
            end
        endcase
    end

endmodule
[DONE]
```