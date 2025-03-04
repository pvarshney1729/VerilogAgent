module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(posedge clk) begin
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
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT; // Handle bump_right while in STATE_WALK_LEFT
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT; // Handle bump_left while in STATE_WALK_RIGHT
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            default: next_state = STATE_WALK_LEFT; // Default case
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
    end

endmodule