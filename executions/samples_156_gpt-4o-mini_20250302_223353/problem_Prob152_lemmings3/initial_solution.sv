module lemming_controller (
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

    typedef enum logic [1:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALLING,
        STATE_DIGGING
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset to initial state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic based on current state
    always_ff @(current_state) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                    aaah = 1'b1;
                end else if (dig && ground) begin
                    next_state = STATE_DIGGING;
                    digging = 1'b1;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                    walk_right = 1'b1;
                end else begin
                    next_state = STATE_WALK_LEFT;
                    walk_left = 1'b1;
                end
            end

            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                    aaah = 1'b1;
                end else if (dig && ground) begin
                    next_state = STATE_DIGGING;
                    digging = 1'b1;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                    walk_left = 1'b1;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                    walk_right = 1'b1;
                end
            end

            STATE_FALLING: begin
                if (ground) begin
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT;
                        walk_left = 1'b1;
                    end else begin
                        next_state = STATE_WALK_RIGHT;
                        walk_right = 1'b1;
                    end
                end else begin
                    next_state = STATE_FALLING;
                    aaah = 1'b1;
                end
            end

            STATE_DIGGING: begin
                if (!ground) begin
                    next_state = STATE_FALLING;
                    aaah = 1'b1;
                end else begin
                    next_state = STATE_DIGGING;
                    digging = 1'b1;
                end
            end

            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly